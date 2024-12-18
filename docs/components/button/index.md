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
| **`loading`** | Enable loading state (`true`, `false`) | `loading: true` | `false` |
| **`loading_text`** | Text displayed during loading | `loading_text: "Processing..."` | `nil` |
| **`disabled`** | Disable the button (`true`, `false`) | `disabled: true` | `false` |
| **`additional_classes`** | Add custom CSS classes | `additional_classes: "shadow-md"` | `""` (empty string) |
| **`use_default_controller`** | Enable Stimulus controllers | `use_default_controller: false` | `true` |
| **`href`** | Converts the button into a link | `href: "https://example.com"` | `nil` |
| **`method`** | HTTP method for the link (`:get`, `:post`, etc.) | `method: :post` | `:get` |
| **`target`** | Target attribute (`_blank`, `_self`) | `target: "_blank"` | `nil` |
| **`dropdown`** | Enable dropdown menu (`true`, `false`, or config hash) | `dropdown: { position: :bottom }` | `false` |
| **`dropdown_items`** | Array of dropdown menu items | `dropdown_items: [{ text: "Item" }]` | `nil` |
| **`dropdown_icon`** | Icon for dropdown button | `dropdown_icon: "fa-chevron-down"` | `nil` |
| **`**options`** | Add custom HTML attributes (e.g., `data-*`, `aria-*`) | `data: { tracking: "click" }, id: "btn"` | `{}` |

---

## Static Button Examples

### Variants

```erb
<%# Solid - Default, high emphasis actions %>
<%= w_button "Save Changes", variant: :solid %>

<%# Subtle - Secondary actions %>
<%= w_button "Filter", variant: :subtle %>

<%# Surface - Card or elevated contexts %>
<%= w_button "Select Plan", variant: :surface %>

<%# Outline - Secondary actions with clear boundaries %>
<%= w_button "Learn More", variant: :outline %>

<%# Ghost - Minimal emphasis actions %>
<%= w_button "Cancel", variant: :ghost %>

<%# Plain - Link-like buttons %>
<%= w_button "View Details", variant: :plain %>
```

### Themed Variants

```erb
<%= w_button "Primary", variant: :solid, theme: { name: :primary } %>
<%= w_button "Secondary", variant: :solid, theme: { name: :secondary } %>
<%= w_button "Success", variant: :solid, theme: { name: :success } %>
<%= w_button "Danger", variant: :solid, theme: { name: :danger } %>
<%= w_button "Warning", variant: :solid, theme: { name: :warning } %>
<%= w_button "Info", variant: :solid, theme: { name: :info } %>
<%= w_button "Light", variant: :solid, theme: { name: :light } %>
<%= w_button "Dark", variant: :solid, theme: { name: :dark } %>

<%= w_button "Subtle", variant: :subtle, theme: { name: :primary } %>
<%= w_button "Secondary", variant: :subtle, theme: { name: :secondary } %>
<%= w_button "Success", variant: :subtle, theme: { name: :success } %>
<%= w_button "Danger", variant: :subtle, theme: { name: :danger } %>
<%= w_button "Warning", variant: :subtle, theme: { name: :warning } %>
<%= w_button "Info", variant: :subtle, theme: { name: :info } %>
<%= w_button "Light", variant: :subtle, theme: { name: :light } %>
<%= w_button "Dark", variant: :subtle, theme: { name: :dark } %>
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

### Gradient

```erb
<%# Predefined gradients %>
<%= w_button "Blue Gradient", gradient: :blue %>
<%= w_button "Purple Gradient", gradient: :purple %>
<%= w_button "Green Gradient", gradient: :green %>
<%= w_button "Sunset Gradient", gradient: :sunset %>
<%= w_button "Indigo Gradient", gradient: :indigo %>
<%= w_button "Slate Gradient", gradient: :slate %>
<%= w_button "Ocean Gradient", gradient: :ocean %>
<%= w_button "Rose Gradient", gradient: :rose %>
<%= w_button "Amber Gradient", gradient: :amber %>
<%= w_button "Emerald Gradient", gradient: :emerald %>

<%# Custom gradients - Two colors gradient %>
<%= w_button "Custom - Coral Reef", gradient: { from: "#ff6b6b", to: "#4ecdc4" } %>
<%= w_button "Custom - Ocean Breeze", gradient: { from: "#2193b0", to: "#6dd5ed" } %>

<%# Custom gradients - Three colors gradient %>
<%= w_button "Custom - Coral Reef", gradient: { from: "#ff6b6b", to: "#4ecdc4", via: "#4ecdc4" } %>
<%= w_button "Custom - Forest Mist", gradient: { from: "#2AF598", via: "#08AEEA", to: "#02CCBA" } %>
```

### Icons

```erb
<%= w_button "Left Icon", icon: "fa-solid fa-user", icon_position: :left %>
<%= w_button "Right Icon", icon: "fa-solid fa-user", icon_position: :right %>
```

### Link Buttons

```erb
<%# Default link with underline %>
<%= w_button "Home", href: "#", variant: :plain %>
<%= w_button "About", href: "#", variant: :plain, theme: { name: :primary } %>

<%# Default link without underline %>
<%= w_button "Home", href: "#", variant: :plain, underline: false %>
<%= w_button "About", href: "#", variant: :plain, theme: { name: :primary }, underline: false %>
<%= w_button "Contact", href: "#", variant: :plain, theme: { name: :secondary }, underline: false %>

<%# Button link %>
<%= w_button "Go to Google", href: "https://www.google.com", variant: :solid, target: :blank, underline: false %>
<%= w_button "Submit Form", href: "#", method: :post, variant: :solid, loading_text: "Submitting...", underline: false %>
```

---
## Dynamic Button Examples

### Loading State


```erb
# Pre loading state
<%= w_button "Loading", loading: true %>

# Interactive loading state
<%= w_button "Loading", loading: true, loading_text: "Processing..." %>
```

The button component supports two types of loading states to handle different use cases.

#### **Pre-loaded State**

Use when you need a button that starts in a loading state.
```
<%= w_button "Loading Button",
    variant: :solid,
    theme: { name: :primary },
    loading: true,
    loading_text: "Loading..." %>
```

**Use Cases**

- Buttons that start in a loading state

- Disabled states while data is fetching

- Initial page load scenarios

- System processing indicators

- Rate-limited actions

**Examples**
```
# Wallet Connection
<%= w_button "Connect Wallet", 
    loading: true, 
    loading_text: "Connecting..." %>

# Permission Check
<%= w_button "Join Meeting", 
    loading: @checking_permissions,
    loading_text: "Checking access..." %>

# Data Loading
<%= w_button "View Dashboard", 
    loading: @loading_data,
    loading_text: "Loading data..." %>
```

#### **Interactive Loading**

Use for buttons that enter loading state after user interaction.
```
<%= w_button "Submit", loading_text: "Saving..." %>
```

**Use Cases**

- Form submissions

- AJAX requests

- User-initiated actions

- Save/Update operations

- API calls

**Examples**
```
# Form Submission
<%= w_button "Save Changes", 
    loading_text: "Saving...",
    id: "save-form" %>

# API Request
<%= w_button "Send Message", 
    loading_text: "Sending..." %>

# File Upload
<%= w_button "Upload", 
    loading_text: "Uploading...",
    id: "upload-button" %>
```

#### **JavaScript Integration**

For interactive loading buttons, you can control the loading state via JavaScript:
```
// Example with Stimulus
export default class extends Controller {
  submit() {
    // Button will show loading state
    this.element.click()
    
    // Your async operation
    await this.saveData()
    
    // Button will return to normal state
  }
}
```

#### Notes

- Both types of loading states will disable the button while loading

- Loading text is optional but recommended for better UX

- The button will maintain its size during loading state to prevent layout shifts


---

### Dropdown Button

The button component supports dropdown menus with various configuration options.

#### Basic Usage

```erb
<%= w_button "Dropdown", 
    dropdown: true,
    dropdown_items: [
      { text: "Profile", href: "#profile" },
      { text: "Settings", href: "#settings" },
      { divider: true },
      { text: "Logout", href: "#logout" }
    ] 
%>
```

#### Configuration Options

The `dropdown` parameter accepts either `true` or a configuration hash:

```erb
<%= w_button "Menu", 
    dropdown: {
      position: :bottom,  # Dropdown position
      align: :start,      # Alignment
      trigger: :hover     # Trigger behavior
    },
    dropdown_items: [...] 
%>
```

| Option | Values | Default | Description |
|--------|---------|---------|-------------|
| `position` | `:bottom`, `:top`, `:left`, `:right` | `:bottom` | Position of dropdown menu |
| `align` | `:start`, `:end`, `:center` | `:start` | Horizontal alignment |
| `trigger` | `:click`, `:hover` | `:click` | Trigger interaction |

#### Dropdown Items Structure

Dropdown items can be configured with these properties:

```ruby
dropdown_items: [
  { 
    text: "Item text",      # Required: Menu item text
    href: "#link",          # Optional: Link URL
    divider: true,          # Optional: Adds divider line
    children: [...]         # Optional: Nested items
  }
]
```

#### Nested Dropdowns

Support for multi-level dropdown menus:

```erb
<%= w_button "Menu", 
    dropdown: true,
    dropdown_items: [
      { text: "Level 1", href: "#1" },
      { 
        text: "Has Submenu", 
        children: [
          { text: "Sub Item 1", href: "#sub1" },
          { text: "Sub Item 2", href: "#sub2" }
        ]
      }
    ] 
%>
```

More deep nested dropdowns are supported.
```erb
<%= w_button "Menu", 
    variant: :surface,
    theme: { name: :primary },
    dropdown: { position: :bottom, align: :start, trigger: :hover },
    dropdown_items: [
        { text: "Option 1", href: "#1" },
        { 
            text: "Option 2 (With Submenu)", 
            children: [
                { text: "Sub Option 1", href: "#2-1" },
                { text: "Sub Option 2", href: "#2-2" },
                { 
                    text: "Sub Option 3 (With Submenu)", 
                    children: [
                        { text: "Sub Sub Option 1", href: "#2-3-1" },
                        { text: "Sub Sub Option 2", href: "#2-3-2" },
                        { text: "Sub Sub Option 3 (With Submenu)", children: [
                            { text: "Sub Sub Sub Option 1", href: "#2-3-3-1" },
                            { text: "Sub Sub Sub Option 2", href: "#2-3-3-2" },
                        ] }
                    ] 
                }
            ]
        },
        { text: "Option 3", href: "#3" }
    ] 
%>
```

#### Custom Styling

Dropdowns can be customized with variants and sizes:

```erb
<%= w_button "Large Menu", 
    variant: :solid,
    theme: { name: :primary },
    size: :large,
    icon: "fa-solid fa-bars",
    dropdown: true,
    dropdown_items: [...] 
%>
```

#### JavaScript Integration

By default, dropdowns use Stimulus for interactivity. You can disable this:

```erb
<%= w_button "Custom Dropdown", 
    dropdown: true,
    use_default_controller: false,
    dropdown_items: [...] 
%>
```

Then implement your own JavaScript:

```javascript
// Custom dropdown behavior
document.querySelector('.w-button-dropdown').addEventListener('click', (e) => {
  // Your custom dropdown logic
});
```

#### Accessibility

Dropdown buttons include these accessibility features:
- `role="menu"` on the dropdown wrapper
- Unique IDs for menu items (`dropdown-item-[index]`)
- Proper ARIA attributes for interactive elements

#### Notes

- Dropdowns require a wrapper element (automatically added)
- Items can have dividers between them
- Nested dropdowns support unlimited depth
- Default trigger is click-based
- Hover trigger available for simpler menus
- All standard button options (variant, size, etc.) apply

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
