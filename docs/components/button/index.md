---
layout: default
title: Button
parent: Components
nav_order: 1
has_children: true
---

## Table of Contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

### Buttons

You can add buttons using the `w_button` helper:

```erb
<%= w_button "Basic Button" %>
<%= w_button "Outline Button", variant: :outline %>
<%= w_button "Primary Button", variant: :solid, theme: { name: :primary } %>
<%= w_button "Disabled Button", variant: :solid, disabled: true %>
<%= w_button "Go to Google", variant: :plain, href: "https://www.google.com", target: "_blank" %>
```

---

### Static and Dynamic Button

You can use static button for simple actions and dynamic button for more complex actions.

[Static](./static){: .btn .btn-purple .mr-2 }
[Dynamic](./dynamic){: .btn .btn-purple .mr-2 }

---

## Button Component

### Customization Options

| Option | Description | Example | Default |
|--------|-------------|----------|---------|
| **`variant`** | Button style (`:solid`, `:subtle`, `:surface`, `:outline`, `:ghost`, `:plain`) | `variant: :solid` | `:solid` |
| **`theme`** | Theme configuration with name or custom properties | `theme: { name: :primary } or theme: { custom: { color: "#fff" } }` | `{}` |
| **`size`** | Button size (`:small`, `:medium`, `:large`) | `size: :large` | `:medium` |
| **`radius`** | Button shape (`:rounded`, `:pill`, `:square`) | `radius: :pill` | `:rounded` |
| **`gradient`** | Apply gradient background (predefined or custom). Predefined consists of 10 colors. `:blue`, `:purple`, `:green`, `:sunset`, `:indigo`, `:slate`, `:ocean`, `:rose`, `:amber`, `:emerald` | `gradient: :blue` or `gradient: { from: "#ff6b6b", to: "#4ecdc4" }` | `nil` |
| **`icon`** | Add an icon (e.g., FontAwesome class) | `icon: "fa-solid fa-user"` | `nil` |
| **`icon_position`** | Position of the icon (`:left`, `:right`) | `icon_position: :right` | `:left` |
| **`icon_only`** | Show only icon without text | `icon_only: true` | `false` |
| **`loading`** | Enable loading state (`true`, `false`) | `loading: true` | `false` |
| **`loading_text`** | Text displayed during loading | `loading_text: "Processing..."` | `nil` |
| **`disabled`** | Disable the button (`true`, `false`) | `disabled: true` | `false` |
| **`additional_classes`** | Add custom CSS classes | `additional_classes: "shadow-md"` | `""` (empty string) |
| **`use_default_controller`** | Enable Stimulus controllers | `use_default_controller: false` | `true` |
| **`href`** | Converts the button into a link | `href: "https://example.com"` | `nil` |
| **`method`** | HTTP method for the link (`:get`, `:post`, etc.) | `method: :post` | `:get` |
| **`target`** | Target attribute (`_blank`, `_self`) | `target: "_blank"` | `nil` |
| **`underline`** | Show underline for link buttons | `underline: false` | `true` |
| **`dropdown`** | Enable dropdown menu (`true`, `false`, or config hash) | `dropdown: { position: :bottom }` | `false` |
| **`dropdown_items`** | Array of dropdown menu items | `dropdown_items: [{ text: "Item" }]` | `nil` |
| **`dropdown_icon`** | Icon for dropdown button | `dropdown_icon: "fa-chevron-down"` | `nil` |
| **`copy_to_clipboard`** | Enable copy to clipboard (string or config hash) | `copy_to_clipboard: "Text to copy"` or `copy_to_clipboard: { text: "Copy me", feedback_text: "Copied!" }` | `nil` |
| **`confirm`** | Add confirmation dialog (string or config hash) | `confirm: "Are you sure?"` or `confirm: { title: "Confirm", message: "Continue?" }` | `nil` |
| **`tooltip`** | Add tooltip (string or config hash) | `tooltip: "Help text"` or `tooltip: { content: "Info", position: "top" }` | `nil` |
| **`**options`** | Add custom HTML attributes (e.g., `data-*`, `aria-*`) | `data: { tracking: "click" }, id: "btn"` | `{}` |

---
### Dynamic Feature Options

#### Copy to Clipboard Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `text` | String | Required | Text to be copied |
| `feedback_text` | String | "Copied!" | Custom feedback message |
| `position` | String | "top" | Tooltip position |
| `duration` | Number | 2000 | Feedback duration in ms |

#### Confirmation Dialog Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `title` | String | "Confirm Action" | Dialog title |
| `message` | String | Required | Confirmation message |
| `variant` | Symbol | `:info` | Dialog theme |
| `confirm_text` | String | "Confirm" | Confirm button text |
| `cancel_text` | String | "Cancel" | Cancel button text |
| `loading` | Boolean | `false` | Enable loading after confirm |
| `loading_text` | String | "Processing..." | Loading state text |

#### Tooltip Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `content` | String | Required | Tooltip content |
| `position` | String | "top" | Tooltip position |
| `align` | String | "center" | Tooltip alignment |
| `trigger` | String | "hover" | Trigger type |
| `delay` | Hash | `{ show: 0, hide: 0 }` | Show/hide delays |
| `offset` | Number | 8 | Distance from button |
| `theme` | String/Hash | "light" | Theme configuration |
| `size` | String | "md" | Tooltip size |
| `arrow` | Boolean | `false` | Show arrow pointer |

---

## Advanced Usage

### Stimulus Integration

By default, Wilday UI uses a Stimulus controller to manage interactive states like loading. This is enabled with `use_default_controller`.

Example with a custom Stimulus controller:

```erb
<%= w_button "Custom Stimulus", use_default_controller: false, id: "custom-btn" %>
```

```javascript
// app/javascript/controllers/custom_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    console.log("Custom Stimulus controller connected!");
  }
}
```

### Adding Custom Styling

You can override default styles with custom CSS:

```css
/* app/assets/stylesheets/custom.css */
.w-button-custom {
  background-color: #f56c6c;
  color: white;
}
```

Then use it with:

```erb
<%= w_button "Custom Style", additional_classes: "w-button-custom" %>
```
