import AstalNetwork from "gi://AstalNetwork"
import {getAccessPointIcon, getNetworkIconBinding} from "../../utils/network";
import {bind, Variable} from "astal"
import {Gtk, App} from "astal/gtk4"
import {execAsync} from "astal/process"
import {SystemMenuWindowName} from "../SystemMenuWindow";
import Pango from "gi://Pango?version=1.0";
import RevealerRow from "../../common/RevealerRow";
import OkButton from "../../common/OkButton";
const wifiConnections = Variable<string[]>([])
const inactiveWifiConnections = Variable<string[]>([])
const activeWifiConnections = Variable<string[]>([])
const vpnConnections = Variable<string[]>([])
export const activeVpnConnections = Variable<string[]>([])

function ssidInRange(ssid: string) {
    const network = AstalNetwork.get_default()

    return network.wifi.accessPoints.find((accessPoint) => {
        return accessPoint.ssid === ssid
    }) != null
}

function updateConnections() {
    // update active connections
    execAsync(["bash", "-c", `nmcli -t -f NAME,TYPE connection show --active`])
        .catch((error) => {
            console.error(error)
        })
        .then((value) => {
            if (typeof value !== "string") {
                return
            }

            const wifiNames = value
                .split("\n")
                .filter((line) => line.includes("802-11-wireless"))
                .map((line) => line.split(":")[0].trim())
                .sort((a, b) => {
                    const aInRange = ssidInRange(a)
                    const bInRange = ssidInRange(b)
                    if (aInRange && bInRange) {
                        return 0
                    } else if (aInRange) {
                        return -1
                    } else {
                        return 1
                    }
                });

            activeWifiConnections.set(wifiNames)

            const vpnNames = value
                .split("\n")
                .filter((line) => line.includes("vpn") || line.includes("wireguard"))
                .map((line) => line.split(":")[0].trim())
                .sort((a, b) => {
                    if (a > b) {
                        return 1
                    } else {
                        return -1
                    }
                });

            activeVpnConnections.set(vpnNames)
        })
        .finally(() => {
            // update inactive connections
            execAsync(["bash", "-c", `nmcli -t -f NAME,TYPE connection show`])
                .catch((error) => {
                    console.error(error)
                })
                .then((value) => {
                    if (typeof value !== "string") {
                        return
                    }

                    const wifiNames = value
                        .split("\n")
                        .filter((line) => line.includes("802-11-wireless"))
                        .map((line) => line.split(":")[0].trim())
                        .sort((a, b) => {
                            const aInRange = ssidInRange(a)
                            const bInRange = ssidInRange(b)
                            if (aInRange && bInRange) {
                                return 0
                            } else if (aInRange) {
                                return -1
                            } else {
                                return 1
                            }
                        });

                    wifiConnections.set(wifiNames)
                    inactiveWifiConnections.set(
                        wifiNames
                            .filter((line) => !activeWifiConnections.get().includes(line))
                    )

                    const vpnNames = value
                        .split("\n")
                        .filter((line) => line.includes("vpn") || line.includes("wireguard"))
                        .map((line) => line.split(":")[0].trim())
                        .filter((line) => !activeVpnConnections.get().includes(line))
                        .sort((a, b) => {
                            if (a > b) {
                                return 1
                            } else {
                                return -1
                            }
                        });

                    vpnConnections.set(vpnNames)
                })
        })
}

function deleteConnection(ssid: string) {
    execAsync(["bash", "-c", `nmcli connection delete "${ssid}"`])
        .finally(() => {
            updateConnections()
        })
}

function disconnect(ssid: string) {
    execAsync(["bash", "-c", `nmcli connection down "${ssid}"`])
        .finally(() => {
            updateConnections()
        })
}

function addWireguardConnection()
{
    const dialog = new Gtk.FileChooserNative({
        title: 'Select WireGuard Config',
        action: Gtk.FileChooserAction.OPEN,
        accept_label: 'Open',
        cancel_label: 'Cancel',
    });

    // Filter for .conf files
    const filter = new Gtk.FileFilter();
    filter.set_name('WireGuard Config (*.conf)');
    filter.add_pattern('*.conf');
    dialog.add_filter(filter);

    dialog.connect('response', (dlg, response) => {
        if (response === Gtk.ResponseType.ACCEPT) {
            const file = dlg.get_file();
            if (file !== null) {
                execAsync(["bash", "-c", `nmcli connection import type wireguard file "${file.get_path()}"`])
                    .finally(() => {
                        updateConnections()
                    })
            }
        }
        dlg.destroy();
    });

    dialog.show();
}

function connectVpn(name: string) {
    // first disconnect any existing vpn connections
    activeVpnConnections.get().forEach((vpnName) => {
        execAsync(["bash", "-c", `nmcli connection down "${vpnName}"`])
            .finally(() => {
                updateConnections()
            })
    })

    execAsync(["bash", "-c", `nmcli connection up "${name}"`])
        .catch((error) => {
            console.error(error)
        }).finally(() => {
            updateConnections()
        })
}

function PasswordEntry(
    {
        accessPoint,
        passwordEntryRevealed
    }: {
        accessPoint: AstalNetwork.AccessPoint,
        passwordEntryRevealed: Variable<boolean>
    }
) {
    const text = Variable("")
    const errorRevealed = Variable(false)
    const isConnecting = Variable(false)

    passwordEntryRevealed.subscribe((r) => {
        if (!r) {
            errorRevealed.set(false)
        }
    })

    const connect = () => {
        errorRevealed.set(false)
        isConnecting.set(true)
        execAsync(["bash", "-c", `echo '${text.get()}' | nmcli device wifi connect "${accessPoint.ssid}" --ask`])
            .catch((error) => {
                console.error(error)
                errorRevealed.set(true)
                deleteConnection(accessPoint.ssid)
            })
            .then((value) => {
                console.log(value)
            })
            .finally(() => {
                if (!errorRevealed.get()) {
                    passwordEntryRevealed.set(false)
                    updateConnections()
                }
                isConnecting.set(false)
            })
    }

    return <box
        marginTop={4}
        vertical={true}
        spacing={4}>
        {accessPoint.flags !== 0 && <box
            vertical={true}>
            <label
                halign={Gtk.Align.START}
                cssClasses={["labelSmall"]}
                label="Password"/>
            <entry
                cssClasses={["networkPasswordEntry"]}
                onChanged={self => text.set(self.text)}
                onActivate={() => connect()}/>
        </box>}
        <revealer
            revealChild={errorRevealed()}
            transitionDuration={200}
            transitionType={Gtk.RevealerTransitionType.SLIDE_DOWN}>
            <label
                halign={Gtk.Align.START}
                cssClasses={["labelSmallWarning"]}
                label="Error Connecting"/>
        </revealer>
        <OkButton
            primary={true}
            hexpand={true}
            label={isConnecting((connecting) => {
                if (connecting) {
                    return "Connecting"
                } else {
                    return "Connect"
                }
            })}
            onClicked={() => {
                if (!isConnecting.get()) {
                    connect()
                }
            }}/>
    </box>
}

function WifiConnections() {
    const network = AstalNetwork.get_default()

    return <box
        vertical={true}>
        <label
            halign={Gtk.Align.START}
            cssClasses={["labelLargeBold"]}
            label="Saved networks"/>
        {inactiveWifiConnections((connectionsValue) => {
            return connectionsValue.map((connection) => {
                const buttonsRevealed = Variable(false)

                setTimeout(() => {
                    bind(App.get_window(SystemMenuWindowName)!, "visible").subscribe((visible) => {
                        if (!visible) {
                            buttonsRevealed.set(false)
                        }
                    })
                }, 1_000)

                let label: string
                let canConnect: boolean
                const accessPoint = network.wifi.accessPoints.find((accessPoint) => {
                    return accessPoint.ssid === connection
                })
                if (accessPoint != null) {
                    label = `${getAccessPointIcon(accessPoint)}  ${connection}`
                    canConnect = network.wifi.activeAccessPoint?.ssid !== connection;
                } else {
                    label = `󰤮  ${connection}`
                    canConnect = false
                }

                return <box
                    vertical={true}>
                    <OkButton
                        hexpand={true}
                        label={label}
                        labelHalign={Gtk.Align.START}
                        onClicked={() => {
                            buttonsRevealed.set(!buttonsRevealed.get())
                        }}/>
                    <revealer
                        revealChild={buttonsRevealed()}
                        transitionDuration={200}
                        transitionType={Gtk.RevealerTransitionType.SLIDE_DOWN}>
                        <box
                            marginTop={4}
                            vertical={true}
                            spacing={4}>
                            {canConnect && <OkButton
                                hexpand={true}
                                primary={true}
                                label="Connect"
                                onClicked={() => {
                                    execAsync(`nmcli c up ${connection}`)
                                        .catch((error) => {
                                            console.error(error)
                                        })
                                        .finally(() => {
                                            updateConnections()
                                        })
                                }}/>}
                            <OkButton
                                hexpand={true}
                                primary={true}
                                label="Forget"
                                onClicked={() => {
                                    deleteConnection(connection)
                                }}/>
                        </box>
                    </revealer>
                </box>
            })
        })}
    </box>
}

function WifiScannedConnections() {
    const network = AstalNetwork.get_default()

    return <box
        vertical={true}>
        {bind(network.wifi, "scanning").as((scanning) => {
            if (scanning) {
                return <label
                    halign={Gtk.Align.START}
                    cssClasses={["labelLargeBold"]}
                    marginBottom={4}
                    label="Scanning…"/>
            } else {
                const accessPoints = network.wifi.accessPoints

                const accessPointsUi = accessPoints.filter((value) => {
                    return value.ssid != null
                        && wifiConnections.get().find((connection) => {
                            return value.ssid === connection
                        }) == null
                }).sort((a, b) => {
                    if (a.strength > b.strength) {
                        return -1
                    } else {
                        return 1
                    }
                }).map((accessPoint) => {
                    const passwordEntryRevealed = Variable(false)

                    setTimeout(() => {
                        bind(App.get_window(SystemMenuWindowName)!, "visible").subscribe((visible) => {
                            if (!visible) {
                                passwordEntryRevealed.set(false)
                            }
                        })
                    }, 1_000)

                    return <box
                        vertical={true}>
                        <box
                            vertical={false}>
                            <OkButton
                                hexpand={true}
                                labelHalign={Gtk.Align.START}
                                label={`${getAccessPointIcon(accessPoint)}  ${accessPoint.ssid}`}
                                onClicked={() => {
                                    passwordEntryRevealed.set(!passwordEntryRevealed.get())
                                }}/>
                        </box>
                        <revealer
                            revealChild={passwordEntryRevealed()}
                            transitionDuration={200}
                            transitionType={Gtk.RevealerTransitionType.SLIDE_DOWN}>
                            <PasswordEntry
                                accessPoint={accessPoint}
                                passwordEntryRevealed={passwordEntryRevealed}/>
                        </revealer>
                    </box>
                })

                return <box
                    vertical={true}>
                    <label
                        halign={Gtk.Align.START}
                        cssClasses={["labelLargeBold"]}
                        label="Available networks"/>
                    {accessPointsUi}
                </box>
            }
        })}
    </box>
}

function VpnActiveConnections() {
    return <box
        visible={activeVpnConnections((connections) => {
            return connections.length !== 0
        })}
        vertical={true}>
        {activeVpnConnections().as((connections) => {
            if (connections.length === 0) {
                return <box/>
            }
            return <box
                vertical={true}>
                <label
                    halign={Gtk.Align.START}
                    cssClasses={["labelLargeBold"]}
                    label="Active VPN"/>
                {connections.map((connection) => {
                    const buttonsRevealed = Variable(false)

                    setTimeout(() => {
                        bind(App.get_window(SystemMenuWindowName)!, "visible").subscribe((visible) => {
                            if (!visible) {
                                buttonsRevealed.set(false)
                            }
                        })
                    }, 1_000)

                    return <box
                        vertical={true}>
                        <OkButton
                            hexpand={true}
                            labelHalign={Gtk.Align.START}
                            label={`󰯄  ${connection}`}
                            onClicked={() => {
                                buttonsRevealed.set(!buttonsRevealed.get())
                            }}/>
                        <revealer
                            revealChild={buttonsRevealed()}
                            transitionDuration={200}
                            transitionType={Gtk.RevealerTransitionType.SLIDE_DOWN}>
                            <box
                                marginTop={4}
                                marginBottom={4}
                                vertical={true}
                                spacing={4}>
                                <OkButton
                                    hexpand={true}
                                    primary={true}
                                    label="Disconnect"
                                    onClicked={() => {
                                        execAsync(`nmcli c down ${connection}`)
                                            .catch((error) => {
                                                console.error(error)
                                            })
                                            .finally(() => {
                                                updateConnections()
                                            })
                                    }}/>
                                <OkButton
                                    hexpand={true}
                                    primary={true}
                                    label="Forget"
                                    onClicked={() => {
                                        deleteConnection(connection)
                                    }}/>
                            </box>
                        </revealer>
                    </box>
                })}
            </box>
        })}
    </box>
}

function VpnConnections() {
    return <box
        vertical={true}
        spacing={4}>
        <label
            halign={Gtk.Align.START}
            cssClasses={["labelLargeBold"]}
            label="VPN Connections"/>
        {vpnConnections((connectionsValue) => {
            return connectionsValue.map((connection) => {
                const buttonsRevealed = Variable(false)
                const isConnecting = Variable(false)

                setTimeout(() => {
                    bind(App.get_window(SystemMenuWindowName)!, "visible").subscribe((visible) => {
                        if (!visible) {
                            buttonsRevealed.set(false)
                        }
                    })
                }, 1_000)

                return <box
                    vertical={true}>
                    <OkButton
                        hexpand={true}
                        labelHalign={Gtk.Align.START}
                        label={`󰯄  ${connection}`}
                        onClicked={() => {
                            buttonsRevealed.set(!buttonsRevealed.get())
                        }}/>
                    <revealer
                        revealChild={buttonsRevealed()}
                        transitionDuration={200}
                        transitionType={Gtk.RevealerTransitionType.SLIDE_DOWN}>
                        <box
                            marginTop={4}
                            marginBottom={4}
                            vertical={true}
                            spacing={4}>
                            <OkButton
                                hexpand={true}
                                primary={true}
                                label={isConnecting().as((connecting) => {
                                    if (connecting) {
                                        return "Connecting"
                                    } else {
                                        return "Connect"
                                    }
                                })}
                                onClicked={() => {
                                    if (!isConnecting.get()) {
                                        isConnecting.set(true)
                                        connectVpn(connection)
                                    }
                                }}/>
                            <OkButton
                                hexpand={true}
                                primary={true}
                                label="Forget"
                                onClicked={() => {
                                    deleteConnection(connection)
                                }}/>
                        </box>
                    </revealer>
                </box>
            })
        })}
        <OkButton
            primary={true}
            label="Add Wireguard VPN"
            onClicked={() => {
                addWireguardConnection()
            }}/>
    </box>
}

export default function () {
    const network = AstalNetwork.get_default()

    updateConnections()

    setTimeout(() => {
        bind(App.get_window(SystemMenuWindowName)!, "visible").subscribe((visible) => {
            if (visible) {
                updateConnections()
            }
        })
    }, 1_000)

    const networkName = Variable.derive([
        bind(network.client, "primaryConnection"),
        activeVpnConnections
    ])

    return <RevealerRow
        icon={getNetworkIconBinding()}
        iconOffset={2}
        windowName={SystemMenuWindowName}
        content={
            <label
                cssClasses={["labelMediumBold"]}
                halign={Gtk.Align.START}
                hexpand={true}
                ellipsize={Pango.EllipsizeMode.END}
                label={networkName().as((value) => {
                    const primaryConnection = value[0]
                    const activeVpnConnectionsValue = value[1]
                    let name: string
                    if (primaryConnection === null) {
                        name = "Not Connected"
                    } else if (primaryConnection.id.toLowerCase().startsWith("wired")) {
                        name = "Wired"
                    } else {
                        name = primaryConnection.id
                    }
                    if (activeVpnConnectionsValue.length === 0) {
                        return name
                    } else {
                        return `${name} (+VPN)`
                    }
                })}/>
        }
        revealedContent={
            <box
                marginTop={10}
                vertical={true}
                spacing={12}>
                {network.wifi && bind(network.wifi, "activeAccessPoint").as((activeAccessPoint) => {
                    return <box
                        hexpand={true}
                        marginBottom={8}>
                        <OkButton
                            hexpand={true}
                            visible={activeAccessPoint !== null}
                            primary={true}
                            label="Disconnect"
                            onClicked={() => {
                                disconnect(activeAccessPoint.ssid)
                            }}/>
                    </box>
                })}
                <VpnActiveConnections/>
                <VpnConnections/>
                {network.wifi && <WifiConnections connections={inactiveWifiConnections}/>}
                {network.wifi && <WifiScannedConnections/>}
            </box>
        }
        setup={(revealed) => {
            revealed.subscribe((r) => {
                if (r) {
                    network.wifi?.scan()
                }
            })
        }}
    />
}
