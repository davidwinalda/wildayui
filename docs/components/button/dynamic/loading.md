---
layout: default
title: Loading
parent: Dynamic Button
nav_order: 1
---

## Loading State

```erb
# Pre loading state
<%= w_button "Loading", loading: true %>

# Interactive loading state
<%= w_button "Loading", loading: true, loading_text: "Processing..." %>
```

The button component supports two types of loading states to handle different use cases.

### **Pre-loaded State**

Use when you need a button that starts in a loading state.
```erb
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
```erb
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

### **Interactive Loading**

Use for buttons that enter loading state after user interaction.
```erb
<%= w_button "Submit", loading_text: "Saving..." %>
```

**Use Cases**

- Form submissions

- AJAX requests

- User-initiated actions

- Save/Update operations

- API calls

**Examples**
```erb
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

### **JavaScript Integration**

For interactive loading buttons, you can control the loading state via JavaScript:
```js
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

### Notes

- Both types of loading states will disable the button while loading

- Loading text is optional but recommended for better UX

- The button will maintain its size during loading state to prevent layout shifts


---