---
layout: default
title: Button
parent: Components
nav_order: 1
has_children: true
---

### Buttons

You can add buttons using the `w_button` helper:

```erb
<%= w_button "Primary Button", variant: :primary %>
<%= w_button "Disabled Button", variant: :outline, disabled: true %>
<%= w_button "Go to Google", href: "https://www.google.com", target: "_blank" %>
```

---

## Button Component

### Customization Options

| Option                   | Description                                           | Example                                  |
| ------------------------ | ----------------------------------------------------- | ---------------------------------------- |
| **`variant`**            | Button style (`:primary`, `:secondary`, `:outline`)   | `variant: :primary`                      |
| **`size`**               | Button size (`:small`, `:medium`, `:large`)           | `size: :large`                           |
| **`radius`**             | Button shape (`:rounded`, `:pill`, `:square`)         | `radius: :pill`                          |
| **`icon`**               | Add an icon (e.g., FontAwesome class)                 | `icon: "fa-solid fa-user"`               |
| **`icon_position`**      | Position of the icon (`:left`, `:right`)              | `icon_position: :right`                  |
| **`loading`**            | Enable loading state (`true`, `false`)                | `loading: true`                          |
| **`loading_text`**       | Text displayed during loading                         | `loading_text: "Processing..."`          |
| **`disabled`**           | Disable the button (`true`, `false`)                  | `disabled: true`                         |
| **`href`**               | Converts the button into a link                       | `href: "https://example.com"`            |
| **`method`**             | HTTP method for the link (`:get`, `:post`, etc.)      | `method: :post`                          |
| **`target`**             | Target attribute (`_blank`, `_self`)                  | `target: "_blank"`                       |
| **`additional_classes`** | Add custom CSS classes                                | `additional_classes: "shadow-md"`        |
| **`**options`\*\*        | Add custom HTML attributes (e.g., `data-*`, `aria-*`) | `data: { tracking: "click" }, id: "btn"` |

---

## Examples

### Variants

```erb
<%= w_button "Primary", variant: :primary %>
<%= w_button "Secondary", variant: :secondary %>
<%= w_button "Outline", variant: :outline %>
```

### Sizes

```erb
<%= w_button "Small", size: :small %>
<%= w_button "Medium", size: :medium %>
<%= w_button "Large", size: :large %>
```

### Shapes (Radius)

```erb
<%= w_button "Rounded", radius: :rounded %>
<%= w_button "Pill", radius: :pill %>
<%= w_button "Square", radius: :square %>
```

### Icons

```erb
<%= w_button "Left Icon", icon: "fa-solid fa-user", icon_position: :left %>
<%= w_button "Right Icon", icon: "fa-solid fa-user", icon_position: :right %>
```

### Loading State

```erb
<%= w_button "Loading", loading: true, loading_text: "Processing..." %>
```

### Link Buttons

```erb
<%= w_button "Go to Google", href: "https://www.google.com", target: "_blank" %>
<%= w_button "Submit Form", href: "/submit", method: :post, loading_text: "Submitting..." %>
```

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

---
