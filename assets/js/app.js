// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//
// If you have dependencies that try to import CSS, esbuild will generate a separate `app.css` file.
// To load it, simply add a second `<link>` to your `root.html.heex` file.

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import topbar from "../vendor/topbar"
import { liveViewHooks } from "./liveview_hooks"

const csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
const liveSocket = new LiveSocket("/live", Socket, {
  longPollFallbackMs: 2500,
  params: {_csrf_token: csrfToken},
  hooks: liveViewHooks,
})

// ── BO Layout: sidebar + collapsible nav sections ──────────────────────────
function toggleSidebar() {
  const sidebar = document.getElementById('bo-sidebar')
  const main = document.getElementById('bo-main')
  sidebar.classList.toggle('collapsed')
  main.classList.toggle('collapsed')
  localStorage.setItem('sidebar-collapsed', sidebar.classList.contains('collapsed'))
}

function setSectionOpenClass(id) {
  const wrapper = document.getElementById(id)
  const items = document.getElementById(id + '-items')
  if (!wrapper || !items) return
  if (items.classList.contains('closed')) {
    wrapper.classList.remove('section-open')
  } else {
    wrapper.classList.add('section-open')
  }
}

function toggleSection(id) {
  const items = document.getElementById(id + '-items')
  const chevron = document.getElementById(id + '-chevron')
  if (!items) return
  items.classList.toggle('closed')
  chevron && chevron.classList.toggle('open')
  localStorage.setItem('section-' + id, items.classList.contains('closed') ? 'closed' : 'open')
  setSectionOpenClass(id)
}

function restoreLayout() {
  const sidebar = document.getElementById('bo-sidebar')
  const main = document.getElementById('bo-main')
  if (!sidebar || !main) return

  if (localStorage.getItem('sidebar-collapsed') === 'true') {
    sidebar.classList.add('collapsed')
    main.classList.add('collapsed')
  } else {
    sidebar.classList.remove('collapsed')
    main.classList.remove('collapsed')
  }

  const sectionIds = (sidebar.dataset.sectionIds || '')
    .split(',')
    .map((id) => id.trim())
    .filter(Boolean)

  sectionIds.forEach(function (id) {
    const state = localStorage.getItem('section-' + id)
    if (!state) return
    const items = document.getElementById(id + '-items')
    const chevron = document.getElementById(id + '-chevron')
    if (!items) return
    if (state === 'closed') {
      items.classList.add('closed')
      chevron && chevron.classList.remove('open')
    } else {
      items.classList.remove('closed')
      chevron && chevron.classList.add('open')
    }
    setSectionOpenClass(id)
  })
}

window.toggleSidebar = toggleSidebar
window.toggleSection = toggleSection
restoreLayout()
window.addEventListener('phx:page-loading-stop', restoreLayout)

// Clipboard copy via push_event
window.addEventListener("phx:clipboard", (e) => {
  if (e.detail && e.detail.text) {
    navigator.clipboard.writeText(e.detail.text)
  }
})

// Show progress bar on live navigation and form submits
const rootStyles = getComputedStyle(document.documentElement)
const topbarAccent = rootStyles.getPropertyValue("--zaq-bg-loading-default").trim()
const gradientStops = topbarAccent.match(/#[0-9a-fA-F]{3,6}|rgba?\([^)]+\)/g)
const barColors = gradientStops && gradientStops.length > 1
  ? Object.fromEntries(gradientStops.map((c, i) => [i / (gradientStops.length - 1), c]))
  : {0: gradientStops?.[0] || "#29d"}
topbar.config({barColors, shadowColor: "rgba(0, 0, 0, .3)"})
window.addEventListener("phx:page-loading-start", _info => topbar.show(300))
window.addEventListener("phx:page-loading-stop", _info => topbar.hide())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket

// The lines below enable quality of life phoenix_live_reload
// development features:
//
//     1. stream server logs to the browser console
//     2. click on elements to jump to their definitions in your code editor
//
if (process.env.NODE_ENV === "development") {
  window.addEventListener("phx:live_reload:attached", ({detail: reloader}) => {
    // Enable server log streaming to client.
    // Disable with reloader.disableServerLogs()
    reloader.enableServerLogs()

    // Open configured PLUG_EDITOR at file:line of the clicked element's HEEx component
    //
    //   * click with "c" key pressed to open at caller location
    //   * click with "d" key pressed to open at function component definition location
    let keyDown
    window.addEventListener("keydown", e => keyDown = e.key)
    window.addEventListener("keyup", _e => keyDown = null)
    window.addEventListener("click", e => {
      if(keyDown === "c"){
        e.preventDefault()
        e.stopImmediatePropagation()
        reloader.openEditorAtCaller(e.target)
      } else if(keyDown === "d"){
        e.preventDefault()
        e.stopImmediatePropagation()
        reloader.openEditorAtDef(e.target)
      }
    }, true)

    window.liveReloader = reloader
  })
}
