---
layout: default
title: Dropdown
parent: Dynamic Button
nav_order: 2
---

## Dropdown Button

The button component supports dropdown menus with various configuration options.

### Basic Usage

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

### Configuration Options

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

### Dropdown Items Structure

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

### Nested Dropdowns

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

### Custom Styling

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

### JavaScript Integration

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

### Accessibility

Dropdown buttons include these accessibility features:
- `role="menu"` on the dropdown wrapper
- Unique IDs for menu items (`dropdown-item-[index]`)
- Proper ARIA attributes for interactive elements

### Notes

- Dropdowns require a wrapper element (automatically added)
- Items can have dividers between them
- Nested dropdowns support unlimited depth
- Default trigger is click-based
- Hover trigger available for simpler menus
- All standard button options (variant, size, etc.) apply

---