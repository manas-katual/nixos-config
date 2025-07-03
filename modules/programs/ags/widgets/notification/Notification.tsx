import Notifyd from 'gi://AstalNotifd'
import Pango from 'gi://Pango'

import { Gtk } from 'astal/gtk3'
import { GLib, timeout, Variable } from 'astal'
import { notifUrgency } from '@utils/etc'
import ProgressBar from '@widgets/ProgressBar'

const notifyd = Notifyd.get_default()

function NotifHeader(props: {
  notification: Notifyd.Notification,
  popup: boolean
}) {
  const { notification, popup } = props

  return (
    <box
      className='notif_header'
      valign={Gtk.Align.CENTER}
      spacing={8}>
      <label
        className='app_name'
        label={notification.get_app_name()}
        maxWidthChars={12}
        truncate={true}
        xalign={0}
        yalign={1}
      />

      <label
        className='time'
        label={
          GLib.DateTime
            .new_from_unix_local(notification.get_time())
            .format('• %I:%M %p')!
        }
        xalign={0}
        yalign={1}
      />

      {!popup && (
        <button
          className='close'
          cursor='pointer'
          halign={Gtk.Align.END}
          valign={Gtk.Align.CENTER}
          hexpand={true}
          onClick={() => {
            notification.dismiss()
          }}>
          <icon
            className='icon'
            icon='window-close-symbolic'
          />
        </button>
      )}
    </box>
  )
}

function NotifContent(props: { notification: Notifyd.Notification }) {
  const { notification } = props

  return (
    <box className='content'>
      <box spacing={8}>
        <box
          vertical={true}
          spacing={4}>
          <label
            className='summary'
            label={`• ${notification.get_summary()}`}
            maxWidthChars={32}
            truncate={true}
            xalign={0}
          />

          <label
            className='body'
            label={
              notification.get_body()
                .replace(/(\r\n|\n|\r)/gm, ' ')
            }
            maxWidthChars={32}
            wrapMode={Pango.WrapMode.WORD_CHAR}
            wrap={true}
            truncate={true}
            lines={3}
            xalign={0}
          />
        </box>
      </box>
    </box>
  )
}

function NotifActions(props: { notification: Notifyd.Notification }) {
  const { notification } = props

  return (
    <box
      className='actions'
      vertical={true}
      spacing={8}>
      <Gtk.Separator visible />

      <box spacing={4}>
        {notification.get_actions().map(action => (
          <button
            className='action'
            cursor='pointer'
            hexpand={true}
            onClick={() => {
              notification.invoke(action.id)
            }}>
            <label
              className='name'
              label={action.label}
              halign={Gtk.Align.CENTER}
              hexpand={true}
            />
          </button>
        ))}
      </box>
    </box>
  )
}

function NotificationWidget(props: {
  notification: Notifyd.Notification
  popup: boolean,
  popupTimeout: Variable<number> | undefined
}) {
  const { notification, popup, popupTimeout } = props

  return (
    <box
      className={`widget_notification ${popup ? 'popup': ''}`}
      onDestroy={() => popupTimeout?.drop()}>
      {popup && (
        <box
          className={`urgency ${notifUrgency(notification)}`}
          vexpand={true}
        />
      )}

      <box vertical={true}>
        <box
          vertical={true}
          hexpand={true}
          spacing={8}>
          <NotifHeader
            notification={notification}
            popup={popup}
          />

          <Gtk.Separator visible />

          <NotifContent notification={notification} />

          {notification.get_actions().length > 0
            && <NotifActions notification={notification} />}
        </box>

        {popup && (
          <box
            className='popup_timeout'>
            <ProgressBar
              className='progress'
              fraction={popupTimeout?.()}
              valign={Gtk.Align.CENTER}
              hexpand={true}
            />
          </box>
        )}
      </box>
    </box>
  )
}

export default function Notification(props: {
  notification: Notifyd.Notification
  reveal?: boolean
  popup?: boolean
  onClick?: (remove: () => void) => void
  onHoverLost?: (remove: () => void) => void
  onPopupTimeoutDone?: (remove: () => void) => void
}) {
  const {
    notification,
    reveal = false,
    popup = false,
    onClick,
    onHoverLost,
    onPopupTimeoutDone
  } = props

  const downRevealer = Variable(reveal)
  const sideRevealer = Variable(reveal)

  let popupTimeout: Variable<number> | undefined

  if (popup) {
    const rate = 50
    const speed = rate / (USER_SETTINGS.notifPopupTimeout - USER_SETTINGS.animationSpeed)

    popupTimeout = Variable(0)
      .poll(rate, (time) => Math.min(time + speed, 1.0))

    timeout(USER_SETTINGS.notifPopupTimeout, () => {
      onPopupTimeoutDone?.(remove)
    })
  }

  function remove() {
    sideRevealer.set(false)

    timeout(USER_SETTINGS.animationSpeed, () => {
      downRevealer.set(false)
      timeout(USER_SETTINGS.animationSpeed, () => {
        if (!notificationWidget.destroyed(notificationWidget))
          notificationWidget.destroy()
      })
    })
  }

  const notificationWidget = (
    <eventbox
      cursor={popup ? 'pointer' : ''}
      onClick={() => onClick?.(remove)}
      onHoverLost={() => onHoverLost?.(remove)}
      onDestroy={() => {
        downRevealer.drop()
        sideRevealer.drop()
        popupTimeout?.drop()
      }}>
      <box vertical={true}>
        <revealer
          revealChild={downRevealer()}
          transitionType={Gtk.RevealerTransitionType.SLIDE_DOWN}
          transitionDuration={USER_SETTINGS.animationSpeed}
          onRealize={() => {
            timeout(1, () => {
              downRevealer.set(true)
            })
          }}>
          <box halign={Gtk.Align.END}>
            <revealer
              revealChild={sideRevealer()}
              transitionType={Gtk.RevealerTransitionType.SLIDE_LEFT}
              transitionDuration={USER_SETTINGS.animationSpeed}
              onRealize={() => {
                timeout(USER_SETTINGS.animationSpeed, () => {
                  sideRevealer.set(true)
                })
              }}>
              <NotificationWidget
                notification={notification}
                popup={popup}
                popupTimeout={popupTimeout}
              />
            </revealer>
          </box>
        </revealer>
      </box>
    </eventbox>
  )

  const resolvedHandler = notifyd.connect('resolved', (_, id) => {
    if (id !== notification.get_id() && !popup)
      return

    notifyd.disconnect(resolvedHandler)
    remove()
  })

  return notificationWidget
}
