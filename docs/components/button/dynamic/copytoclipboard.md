---
layout: default
title: Copy to Clipboard
parent: Dynamic Button
nav_order: 3
---

## Copy to Clipboard

The Copy to Clipboard button component provides an easy way to copy text to the user's clipboard with visual feedback.

## Configuration Options

The `copy_to_clipboard` parameter accepts either a string or a configuration hash:

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `text` | String | Required | The text to be copied |
| `feedback_text` | String | "Copied!" | Custom feedback message |
| `position` | String | "top" | Position of the feedback tooltip |
| `duration` | Number | 2000 | Duration in milliseconds to show feedback |

### Position Options
- `top`, `top-start`, `top-center`, `top-end`
- `bottom`, `bottom-start`, `bottom-center`, `bottom-end`
- `left`, `right`

## Basic Usage

The simplest way to use the copy to clipboard feature is to pass the text directly:

```erb
<%= w_button "Copy to Clipboard", copy_to_clipboard: "Text to copy" %>
```

## Basic Usage - Custom

Customize the position, duration, and feedback text.

```erb
<%= w_button "Copy Text",
    copy_to_clipboard: {
    text: "Text to be copied",
    feedback_text: "Copied to clipboard!",
    position: "bottom-center",
    duration: 3000
    },
    variant: :outline,
    icon: "fa-solid fa-clipboard"
%>
```

## Position Examples

Here are examples of different tooltip positions:

```erb
<%= w_button "Bottom Center",
    copy_to_clipboard: {
        text: "Sample text",
        position: "bottom-center"
    }
%>

<%= w_button "Top Center",
    copy_to_clipboard: {
        text: "Sample text",
        position: "top-center"
    }
%>

<%= w_button "Left",
    copy_to_clipboard: {
        text: "Sample text",
        position: "left"
    }
%>

<%= w_button "Right",
    copy_to_clipboard: {
        text: "Sample text",
        position: "right"
    }
%>
```

### Copying Complex Data

The component can handle various types of content:

```erb
<% fake_api_key = "pk_live_#{SecureRandom.hex(24)}" %>

<%= w_button "Copy API Key",
    copy_to_clipboard: {
        text: "fake_api_key",
        feedback_text: "API key copied!",
        position: "top-center",
        duration: 3000
    },
    loading_text: "Copying...",
    variant: :ghost,
    icon: "fa-solid fa-code"
%>
```

```erb
<% json_data = {
    api_key: "abc123",
    secret_key: "xyz789",
    environment: "development"
}.to_json %>

<%= w_button "Copy JSON Config",
    copy_to_clipboard: {
        text: json_data,
        feedback_text: "JSON copied!",
        position: "top-center",
        duration: 3000
    },
    variant: :ghost,
    icon: "fa-solid fa-code"
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

The Copy to Clipboard button includes these accessibility features:
- Visual feedback for successful copy operations
- Clear feedback messages
- Proper ARIA attributes
- Keyboard support

## Notes

- Can be combined with other button features
- Works with both simple text and complex data structures

---