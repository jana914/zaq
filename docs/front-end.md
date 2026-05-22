# ZAQ Frontend Guide

## Tech Stack

| Layer | Technology |
|---|---|
| UI rendering | Phoenix LiveView — server-side reactive HTML over WebSocket |
| Templating | HEEx (`.html.heex`) — Elixir's HTML template syntax |
| Styling | Tailwind CSS v4 + daisyUI (as plugin, not full framework) |
| JS bundler | esbuild (no Webpack, no Vite, no npm scripts) |
| Icons | Heroicons v2 (compiled into CSS bundle via `@plugin`) |
| Fonts | Roboto variable font (self-hosted in `assets/fonts/`) |
| Component preview | Phoenix Storybook (Elixir-native, not Storybook.js) |

There is no React, Vue, or SPA layer. All screens are LiveViews rendered server-side.

---

## Running Locally

### Option A — Native (recommended for dev, enables Storybook)

```bash
mix setup        # install deps, create DB, build assets
mix phx.server   # start the server
```

- Back office: [http://localhost:4000/bo](http://localhost:4000/bo)
- Default credentials on a fresh DB: `admin` / `admin` (forced password change on first login)
- Storybook: [http://localhost:4000/storybook](http://localhost:4000/storybook)
- Phoenix Live Dashboard: [http://localhost:4000/dev/dashboard](http://localhost:4000/dev/dashboard)

### Option B — Docker (production-like, no Storybook)

```bash
./zaq-local.sh
```

- Downloads `docker-compose.yml`, generates `.env` secrets, starts containers
- Opens [http://localhost:4000](http://localhost:4000) automatically
- Re-run the same script to resume if containers are stopped

---

## File Map

### Assets — `assets/`

```
assets/
├── css/app.css          ← ALL styling: Tailwind directives, tokens, components
├── js/app.js            ← LiveView socket setup + every JS hook
├── js/hooks/
│   ├── chart_tooltip_hook.js   ← tooltip positioning for charts
│   └── ontology_tree_hook.js   ← SVG org-tree visualization
├── fonts/Roboto/        ← self-hosted variable font
└── vendor/
    ├── daisyui.js       ← daisyUI component plugin
    ├── daisyui-theme.js ← custom light/dark theme definitions
    ├── heroicons.js     ← icon sprite plugin
    └── topbar.js        ← page loading progress bar
```

**Rule:** only `app.js` and `app.css` are output bundles — import everything into them, never reference external scripts or links in layouts.

---

### Design Tokens — `assets/css/app.css`

All design decisions are CSS custom properties in `:root`:

```
--zaq-font-ui         system UI font
--zaq-font-primary    Roboto (main content)

--color-accent        primary brand color
--color-ink           body text
--color-muted         secondary text
--color-surface-*     backgrounds, cards

Ontology node colors (one set per entity type):
  business / division / department / team / person / domain
  → each has: accent, stroke, border, bg, glow variants
```

Tailwind v4 is configured entirely inside `app.css` — no `tailwind.config.js` exists.
The `@source` directives tell Tailwind where to scan for class names:

```css
@import "tailwindcss" source(none);
@source "../css";
@source "../js";
@source "../../lib/zaq_web";   /* scans all .heex and .ex files */
```

---

### Components — `lib/zaq_web/components/`

Phoenix function components (Elixir functions that render HTML). Use them in templates as `<.component_name>`.

| File | Contents |
|---|---|
| `core_components.ex` | Design system atoms: `<.button>`, `<.input>`, `<.table>`, `<.icon>`, `<.flash>`, `<.header>` |
| `bo_layout.ex` | Back-office shell: collapsible sidebar, nav sections, top bar |
| `chat_message.ex` | `user_bubble` and `assistant_bubble` with confidence indicators and citations |
| `bo_modal.ex` | Confirmation dialog |
| `layouts.ex` | Root HTML layout + theme toggle (dark/light/system) |
| `searchable_select.ex` | Dropdown with search |
| `bo_telemetry_components.ex` | Charts, metrics cards (45 KB — largest component file) |
| `channel_icons.ex` | Icon registry for channel types |
| `file_preview.ex` / `file_preview_modal.ex` | Document preview components |
| `service_unavailable.ex` | Service offline error page |
| `password_policy_components.ex` | Password validation feedback UI |
| `role_share_picker.ex` | Role selection component |

---

### LiveViews — `lib/zaq_web/live/bo/`

Every Back Office screen is a LiveView. Organized by domain:

| Folder | Screens |
|---|---|
| `accounts/` | Users list, User form, Roles list, Role form, Profile |
| `ai/` | Ingestion, File preview, Ontology editor, Prompt templates, AI diagnostics, Knowledge gap |
| `communication/` | Chat, Channels config, Conversation history, Conversation detail, Notification settings (email/SMTP/IMAP) |
| `system/` | System config, License, People, Password management |
| `bo/` root | Dashboard, LLM performance, Conversations metrics, KB metrics |

Each screen has two files:
- `*_live.ex` — Elixir: `mount/3`, event handlers, data fetching
- `*_live.html.heex` — the rendered HTML template

Public route: `lib/zaq_web/live/shared_conversation_live.ex` (no auth required, accessible via `/s/:token`)

---

### JS Hooks — `assets/js/app.js`

Hooks hand off DOM control from LiveView to JavaScript when needed.

| Hook | Purpose |
|---|---|
| `OntologyTree` | SVG org-chart renderer |
| `ChartTooltip` | Tooltip positioning for charts |
| `DownloadFile` | Triggers browser file downloads |
| `FocusAndSelect` | Auto-focus and select input text |
| `CopyToClipboard` | Copy text to clipboard + flash feedback |
| `ScrollBottom` | Keeps chat window scrolled to latest message |
| `Typewriter` | Animated text reveal effect |
| `FocusInput` | Focus a specific input element |
| `SearchableSelect` | Keyboard navigation for the searchable dropdown |
| `AutoExpand` | Textarea that grows with content |

Plain JS (no hook) also in `app.js`:
- Sidebar collapse toggle — state persisted in `localStorage`
- Section expand/collapse — state persisted in `localStorage`

---

### Routing — `lib/zaq_web/router.ex`

Three tiers:

| Tier | Path | Auth |
|---|---|---|
| Public | `/`, `/s/:token` | None |
| BO public | `/bo/login`, `/bo/forgot-password`, `/bo/reset-password/:token` | None |
| BO protected | `/bo/*` | `ZaqWeb.Plugs.Auth` + `AuthHook` on mount |

Dev-only routes (disabled in production):
- `/storybook` — component browser
- `/dev/dashboard` — Phoenix Live Dashboard
- `/dev/mailbox` — email preview

---

### Storybook — `storybook/`

8 story files document the component library. Elixir format (`.story.exs`), not JavaScript Storybook.

```
storybook/
├── core_components/   button, input, header, table, flash
├── chat_message/      assistant_bubble, user_bubble
└── bo_modal/          confirm_dialog
```

Available at [http://localhost:4000/storybook](http://localhost:4000/storybook) when running natively in dev.

---

### Theme System

- Implemented via **daisyUI-theme plugin** — defines `[data-theme=light]` and `[data-theme=dark]` token sets in `app.css`
- An inline script in the root layout reads `localStorage` and sets `data-theme` on `<html>` before first paint — prevents flash of unstyled content
- `<.theme_toggle>` component in `layouts.ex` exposes the light/dark/system switcher to users

---

## Build Pipeline

```
mix assets.build
  → tailwind :zaq    (assets/css/app.css → priv/static/assets/css/app.css)
  → esbuild :zaq     (assets/js/app.js   → priv/static/assets/js/app.js)
```

Configured in `mix.exs` under `aliases`. No `npm run build` — the Elixir build system drives everything.

Production build (minified + digested):
```bash
mix assets.deploy
```

---

## Key Rules

- **Never use `@apply`** in CSS — write Tailwind classes directly in HEEx templates
- **Never use daisyUI components** — only use its theming/token system
- **Never write `<script>` tags** in templates — all JS goes in hooks in `assets/js/`
- **Colocated hook names must start with `.`** — e.g. `.PhoneNumber`
- **Icons via `<.icon name="hero-x-mark" />`** — never import Heroicons modules directly
- **Always use LiveView streams** for collections — never plain assigns for lists
- **Dark mode via `data-theme`** — not via Tailwind's `dark:` prefix
