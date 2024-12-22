---
layout: default
title: Confirmation Dialog
parent: Dynamic Button
nav_order: 4
---

## Confirmation Dialog

The Confirmation Dialog button component adds a confirmation step before executing an action, helping prevent accidental clicks.

## Configuration Options

The `confirm` parameter accepts either a string (message) or a configuration hash:

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `title` | String | "Confirm Action" | Dialog title |
| `message` | String | Required | Confirmation message |
| `variant` | Symbol | :info | Dialog theme variant (:info, :success, :warning, :danger) |
| `confirm_text` | String | "Confirm" | Text for confirm button |
| `cancel_text` | String | "Cancel" | Text for cancel button |

## Basic Usage

The simplest way to use the confirmation dialog is to pass a message string:

```erb
<%= w_button "Delete Item", 
    confirm: "Are you sure you want to delete this item?" 
%>
```

## Variant Examples

Different variants for different contexts:

```erb
<%# Info confirmation - commonly used for non-destructive actions %>
<%= w_button "Submit Application",
    variant: :solid,
    theme: { name: :primary },
    confirm: {
        title: "Submit Application",
        message: "Please review your application before submitting. 
        You won't be able to edit it after submission.",
        variant: :info,
        confirm_text: "Yes, submit now",
        cancel_text: "Review again"
    }
%>

<%# Success confirmation - commonly used for positive actions %>
<%= w_button "Publish Article",
    variant: :solid,
    theme: { name: :success },
    confirm: {
      title: "Publish Article",
      message: "Your article will be visible to the public immediately.",
      variant: :success,
      confirm_text: "Publish now",
      cancel_text: "Save as draft"
    }
%>

<%# Warning confirmation - commonly used for destructive actions %>
<%= w_button "Archive Project",
    variant: :subtle,
    confirm: {
        title: "Archive Project",
        message: "This project will be moved to archives and team members will lose access.",
        variant: :warning,
        confirm_text: "Yes, archive it",
        cancel_text: "No, keep it active"
    }
%>

<%# Danger confirmation - commonly used for destructive actions %>  
<%= w_button "Delete Account",
    variant: :ghost,
    theme: { name: :danger },
    confirm: {
      title: "Delete Account",
      message: "This action cannot be undone. All your data will be permanently deleted.",
      variant: :danger,
      confirm_text: "Yes, delete my account",
      cancel_text: "No, keep my account"
    }
  %>
```


### With Loading State

Add loading state after confirmation:

```erb
<%= w_button "Process Data",
    confirm: {
        title: "Process Data",
        message: "Are you sure you want to process this data?",
        variant: :warning,
        loading: true,
        loading_text: "Processing data..."
    },
    variant: :solid,
    icon: "fa-solid fa-cog"
%>
```

### Case Examples

#### Form submit with confirmation dialog:

```erb
<%= form_with(url: "/test_submit", method: :post) do |f| %>
    <%= w_button "Submit Form",
        variant: :solid,
        theme: { name: :primary },
        confirm: {
          title: "Submit Form",
          message: "This will submit the form. Continue?",
          variant: :info,
          confirm_text: "Yes, submit",
          cancel_text: "No, cancel",
        }
    %>
  <% end %>
```

```javascript
// Listen for form submissions
document.addEventListener("submit", (e) => {
    if (e.target.action.includes("/test_submit")) {
    e.preventDefault();
    alert("Form submitted successfully!");
    }
});
```

#### Link with confirmation dialog:

```erb
<%= w_button "Visit Page",
    variant: :plain,
    href: "https://www.google.com",
    target: "_blank",
    confirm: {
      title: "Navigate Away",
      message: "You will be redirected to another page.",
      variant: :warning,
      confirm_text: "Continue",
      cancel_text: "Stay here"
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

The Confirmation Dialog includes these accessibility features:
- Keyboard navigation support
- Focus trap within dialog
- ARIA labels and roles
- Escape key to close
- Clear visual hierarchy

## Notes

- Dialog is centered on screen
- Backdrop prevents interaction with page
- Can be combined with other button features
- Supports keyboard navigation
- Maintains focus management
- Responsive design for all screen sizes

---