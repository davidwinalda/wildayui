---
layout: default
title: Tooltip
parent: Dynamic Button
nav_order: 5
---

## Tooltip

The Tooltip button component adds informative hover tooltips with customizable positioning, styling, and behavior.

## Configuration Options

The `tooltip` parameter accepts either a string (tooltip content) or a configuration hash:

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `content` | String | Required | Text content of the tooltip |
| `position` | String | "top" | Position of tooltip relative to button |
| `align` | String | "center" | Alignment of tooltip |
| `trigger` | String | "hover" | Trigger behavior ("hover" or "click") |
| `delay` | Hash | `{ show: 0, hide: 0 }` | Delay in ms before showing/hiding |
| `offset` | Number | 8 | Distance from button in pixels |
| `theme` | String/Hash | "light" | Theme name or custom theme config |
| `size` | String | "md" | Size of tooltip ("sm", "md", "lg") |
| `arrow` | Boolean | false | Show/hide tooltip arrow |

## Basic Usage

The simplest way to use tooltips is to pass the content directly:

```erb
<%= w_button "Hover Me", 
    tooltip: "This is a tooltip" 
%>
```

## Basic Usage - Custom

Customize the position, theme, and behavior:

```erb
<%= w_button "Help",
    icon: "fa-solid fa-question-circle",
    variant: :ghost,
    tooltip: {
        content: "Need help? Click here for more information",
        position: "right",
        align: "center",
        theme: "dark",
        delay: { show: 200, hide: 100 },
        arrow: true
    }
%>
```

## Positions

Different tooltip positions:

```erb
<%= w_button "Top Tooltip", tooltip: { content: "I'm on top!", position: "top" } %>

<%= w_button "Bottom Tooltip", tooltip: { content: "I'm at bottom!", position: "bottom" } %>

<%= w_button "Left Tooltip", tooltip: { content: "I'm on left!", position: "left" } %>

<%= w_button "Right Tooltip", tooltip: { content: "I'm on right!", position: "right" } %>
```

## Alignments

Different tooltip alignments:

```erb
<%= w_button "Start Aligned", 
    tooltip: { 
        content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
        position: "bottom",
        align: "start"
    } 
%>

<%= w_button "Center Aligned", 
    tooltip: { 
        content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
        position: "bottom",
        align: "center"
    } 
%>

<%= w_button "End Aligned", 
    tooltip: { 
        content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
        position: "bottom",
        align: "end"
    } 
%>
```

## Arrows

Show or hide the tooltip arrow:

```erb
<%= w_button "Arrow", tooltip: { content: "I have an arrow!", arrow: true } %>

<%= w_button "No Arrow", tooltip: { content: "I have no arrow!", arrow: false } %>

<%= w_button "With Arrow", 
    tooltip: { 
        content: "I have an arrow!",
        position: "bottom",
        arrow: true
    } 
%>

<%= w_button "Arrow Dark", 
    tooltip: { 
        content: "Dark theme with arrow",
        theme: "dark",
        arrow: true
    } 
%>

<%= w_button "Arrow Position", 
    tooltip: { 
        content: "Arrow follows position",
        position: "right",
        arrow: true
    } 
%>
```

## Themes

You can use predefined themes or create your own:

Predefined themes:

```erb
<%= w_button "Light Theme", 
    tooltip: { 
        content: "Light themed tooltip",
        theme: "light"
    } 
%>

<%= w_button "Dark Theme", 
    tooltip: { 
        content: "Dark themed tooltip",
        theme: "dark"
    } 
%>

<%= w_button "Transparent Theme", 
    tooltip: { 
        content: "Transparent themed tooltip",
        theme: "transparent"
    } 
%>
```

Custom themes example:
```erb
<%# Neon Blue %>
<%= w_button "Neon Blue", 
    tooltip: { 
        content: "Glowing blue tooltip",
        theme: {
            custom: {
                color: "#ffffff",
                background: "#0099ff"
            }
        },
        arrow: true
    } 
%>

<%# Gradient Pink %>
<%= w_button "Gradient Pink", 
    tooltip: { 
        content: "Soft pink tooltip",
        theme: {
            custom: {
                color: "#ffffff",
                background: "#ff69b4"
            }
        },
        arrow: true
    } 
%>

<%# Forest Green %>
<%= w_button "Nature Theme", 
    tooltip: { 
        content: "Earthy green tooltip",
        theme: {
            custom: {
                color: "#ffffff",
                background: "#228B22"
            }
        },
        arrow: true
    } 
%>

<%# Dark Purple %>
<%= w_button "Royal Purple", 
    tooltip: { 
        content: "Elegant purple tooltip",
        theme: {
            custom: {
                color: "#ffffff",
                background: "#4B0082"
            }
        },
        arrow: true
    } 
%>

<%# Sunset Orange %>
<%= w_button "Sunset", 
    tooltip: { 
        content: "Warm orange tooltip",
        theme: {
            custom: {
                color: "#ffffff",
                background: "#FF4500"
            }
        },
        arrow: true
    } 
%>

<%# Modern Gray %>
<%= w_button "Modern", 
    tooltip: { 
        content: "Sleek gray tooltip",
        theme: {
            custom: {
                color: "#ffffff",
                background: "#36454F"
            }
        },
        arrow: true
    } 
%>

<%# GitHub Dark Theme %>
<%= w_button "GitHub Style", 
    tooltip: { 
        content: "Developer-friendly tooltip",
        theme: {
            custom: {
                color: "#ffffff",
                background: "#24292e"
            }
        },
        arrow: true
    } 
%>

<%# Material Design Blue %>
<%= w_button "Material Design", 
    tooltip: { 
        content: "Material design tooltip",
        theme: {
            custom: {
                color: "#ffffff",
                background: "#1976d2"
            }
        },
        arrow: true
    } 
%>

<%# Danger Red %>
<%= w_button "Warning", 
    tooltip: { 
        content: "⚠️ Important warning message",
        theme: {
            custom: {
                color: "#ffffff",
                background: "#dc2626"
            }
        },
        arrow: true
    } 
%>
```

## Size

Different tooltip sizes:

```erb
<%= w_button "Small", tooltip: { content: "Small tooltip", size: "sm" } %>

<%= w_button "Medium", tooltip: { content: "Medium tooltip", size: "md" } %>

<%= w_button "Large", tooltip: { content: "Large tooltip", size: "lg" } %>
```

## Trigger

Change the trigger behavior to click:

```erb
<%= w_button "Click Me", tooltip: { content: "Click to show tooltip", trigger: "click" } %>

<%= w_button "Hover", tooltip: { content: "Hover to show tooltip", trigger: "hover" } %>
```

## With HTML Content

Add HTML content to tooltips:

```erb
<%= w_button "HTML Content", tooltip: { content: "<strong>Hello</strong> <i>World</i>", position: "bottom" } %>
```

## Delay

Add show/hide delays for smoother interactions:

```erb
<%= w_button "Slow Tooltip", tooltip: { content: "I appear slowly...", delay: { show: 1000, hide: 200 } } %>

<%= w_button "Fast Tooltip", tooltip: { content: "I appear quickly...", delay: { show: 100, hide: 100 } } %>

<%= w_button "No Delay", tooltip: { content: "I appear immediately...", delay: { show: 0, hide: 0 } } %>

<%= w_button "Hide Slowly", tooltip: { content: "I hide slowly...", delay: { show: 200, hide: 3000 } } %>
```

## Different Variants or Themes

Variants:

```erb
<%= w_button "Solid with Tooltip", 
    variant: :solid,
    tooltip: "I'm a solid button with tooltip" 
%>

<%= w_button "Outline with Tooltip", 
    variant: :outline,
    tooltip: "I'm an outline button with tooltip" 
%>

<%= w_button "Ghost with Tooltip", 
    variant: :ghost,
    tooltip: "I'm a ghost button with tooltip" 
%>
```

Themes:

```erb
<%= w_button "Primary with Tooltip", 
    theme: {
        name: :primary
    },
    tooltip: "I'm a primary button with tooltip" 
%>

<%= w_button "Secondary with Tooltip", 
    theme: {
        name: :secondary
    },
    tooltip: "I'm a secondary button with tooltip" 
%>

<%= w_button "Warning with Tooltip", 
    theme: {
        name: :warning
    },
    tooltip: "I'm a warning button with tooltip" 
%>
```

## Icon Only

```erb
<%= w_button "Icon Only", icon: "fa-solid fa-bell", icon_only: true, tooltip: {content: "Notifications"} %>

<%= w_button "Icon Only", icon: "fa-solid fa-info", icon_only: true, tooltip: {content: "Information", position: "right", arrow: true} %>

<%= w_button "Icon Only", icon: "fa-solid fa-question", icon_only: true, tooltip: {content: "Help"} %>
```

## With Dropdown

```erb
<%= w_button "Options",
    icon: "fa-solid fa-bars",
    dropdown: true,
    dropdown_items: [
        { text: "Edit", href: "#" },
        { text: "Delete", href: "#" }
    ],
    tooltip: { content: "Click to see more options", position: "left", trigger: "click" }
%>
```

## With Copy to Clipboard

```erb
<%= w_button "Copy Token",
    icon: "fa-solid fa-clipboard",
    copy_to_clipboard: { 
        text: "secret-token-123",
        feedback_text: "Token copied!" 
    },
    tooltip: { 
        content: "Copy API token to clipboard",
        position: "right",
        arrow: true,
        theme: "dark" 
    } 
%>
```

## Very Long Content

```erb
<%= w_button "Very Long Text", 
    tooltip: { 
        content: "
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
        " 
    } 
%>
```

## Styling

The component supports all standard button styling options:
- Variants (solid, outline, ghost, etc.)
- Sizes
- Icons
- Custom themes
- Gradients

## Accessibility

The Tooltip component includes these accessibility features:
- ARIA describedby attributes
- Keyboard focus support
- Screen reader compatibility
- Focus management
- Hover and focus states

## Notes

- Tooltips can be combined with other button features
- Automatically adjusts position when near screen edges
- Supports HTML content in tooltips
- Handles long content with wrapping
- Maintains proper z-index stacking
- Responsive to window resizing

---