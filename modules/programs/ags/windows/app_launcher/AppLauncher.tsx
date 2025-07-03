import Applications from 'gi://AstalApps'

import { Astal, Gdk, Gtk } from 'astal/gtk3'
import { Variable } from 'astal'

import { FloatingWindow, FlowBox } from '@widgets'
import { revealAppLauncher } from './vars'

const applications = new Applications.Apps({
  nameMultiplier: 2,
  entryMultiplier: 0,
  executableMultiplier: 2,
})

const query = Variable('')
const queriedApplications = Variable(applications.fuzzy_query(''))
const selectedApplication = Variable(queriedApplications.get()[0])
const selectedIndex = Variable(0)

function QueryBox() {
  return (
    <overlay
      className='query_box'
      passThrough={true}
      hexpand={true}>
      <box className='query_container'>
        <entry
          className='query'
          hexpand={true}
          onChanged={({ text }) => {
            query.set(text)
            queriedApplications.set(applications.fuzzy_query(text))
            selectedApplication.set(queriedApplications.get()[0])
          }}
          setup={(self) => {
            self.hook(revealAppLauncher, () => {
              if (!revealAppLauncher.get()) {
                self.text = ''
                queriedApplications.set(applications.fuzzy_query(''))
                selectedApplication.set(queriedApplications.get()[0])
                selectedIndex.set(0)
              }

              self.grab_focus()
            })
          }}
        />
      </box>

      <label
        className='placeholder'
        label={
          query().as(query =>
            query.length <= 0
              ? 'Search Apps'
              : ''
          )
        }
        xalign={0}
      />
    </overlay>
  )
}

// function CategorySelector() {
//   return (
//     <box className='category_selector'>
//     </box>
//   )
// }

function ApplicationList() {
  return (
    <scrollable
      className='applications'
      hexpand={true}
      vexpand={true}>
      <FlowBox
        maxChildrenPerLine={4}
        hexpand={true}
        valign={Gtk.Align.START}>
        {queriedApplications(applications =>
          applications.map(app => (
            <button
              className={
                selectedApplication()
                  .as(selectedApp =>
                    selectedApp.get_name() === app.get_name()
                      ? 'application selected'
                      : 'application'
                  )
              }
              cursor='pointer'
              halign={Gtk.Align.START}
              onClick={() => {
                app.launch()
                revealAppLauncher.set(false)
              }}>
              <box
                spacing={8}
                halign={Gtk.Align.CENTER}
                valign={Gtk.Align.CENTER}>
                <icon
                  className='icon'
                  icon={app.get_icon_name()}
                />
              </box>
            </button>
          ))
        )}
      </FlowBox>
    </scrollable>
  )
}

function AppLauncher() {
  return (
    <box vertical={true}>
      <box spacing={8}>
        {/*<CategorySelector /> */}
        <ApplicationList />
      </box>

      <QueryBox />
    </box>
  )
}

export default function(gdkmonitor: Gdk.Monitor) {
  return (
    <FloatingWindow
      className='app_launcher'
      title='App Launcher'
      gdkmonitor={gdkmonitor}
      anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.LEFT}
      revealer={revealAppLauncher}
      transitionType={Gtk.RevealerTransitionType.SLIDE_RIGHT}
      keymode={
        revealAppLauncher().as(revealed =>
          revealed
            ? Astal.Keymode.EXCLUSIVE
            : Astal.Keymode.NONE
        )
      }
      onKeyPressEvent={(_, event) => {
        const keyval = event.get_keyval().pop()

        switch (keyval) {
          case Gdk.KEY_Escape:
            return revealAppLauncher.set(false)
          case Gdk.KEY_Tab:
          case Gdk.KEY_Down:
            if (queriedApplications.get().length <= 0) return

            if (selectedIndex.get() < queriedApplications.get().length - 1) {
              selectedIndex.set(selectedIndex.get() + 1)
              selectedApplication.set(queriedApplications.get()[selectedIndex.get()])
            }

            break
          case Gdk.KEY_Up:
            if (queriedApplications.get().length <= 0) return

            if (selectedIndex.get() > 0) {
              selectedIndex.set(selectedIndex.get() - 1)
              selectedApplication.set(queriedApplications.get()[selectedIndex.get()])
            }

            break
          case Gdk.KEY_Return:
            if (!selectedApplication.get()) return

            selectedApplication
              .get()
              .launch()

            revealAppLauncher.set(false)

            break
          // default:
          //   if (!queryBox?.has_focus)
          //     queryBox?.grab_focus()
          //
          //   break
        }
      }}>
      <AppLauncher />
    </FloatingWindow>
  )
}
