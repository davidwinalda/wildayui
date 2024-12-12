---
layout: default
title: Button Examples
parent: Button
nav_order: 1
---

# Button Component Usage Examples

Here are some examples of how to use the button component.

### Basic Form Submit Button

```erb
<%= form_with(model: @article) do |f| %>
  <%= f.text_field :title %>
  <%= w_button "Create Article",
        variant: :primary,
        loading_text: "Creating..."
    %>
<% end %>
```

### Action Buttons in a Table

```erb
<table>
  <% @users.each do |user| %>
    <tr>
      <td><%= user.name %></td>
      <td class="flex gap-2">
        <%= w_button "Edit",
            variant: :secondary,
            size: :small,
            icon: "fa-solid fa-pen",
            href: edit_user_path(user)
        %>

        <%= w_button "Delete",
            variant: :outline,
            size: :small,
            icon: "fa-solid fa-trash",
            method: :delete,
            data: {
                confirm: "Are you sure?",
                turbo_confirm: "Are you sure?"
            }
        %>
      </td>
    </tr>
  <% end %>
</table>
```

### Navigation Links

```erb
<nav class="flex gap-4">
  <%= w_button "Dashboard",
               variant: :primary,
               icon: "fa-solid fa-home",
               href: dashboard_path,
               radius: :pill %>

  <%= w_button "Settings",
               variant: :outline,
               icon: "fa-solid fa-gear",
               href: settings_path,
               radius: :pill %>

  <%= w_button "Logout",
               variant: :secondary,
               icon: "fa-solid fa-sign-out",
               method: :delete,
               href: logout_path,
               radius: :pill %>
</nav>
```

### Loading States for API Calls

```erb
<div data-controller="toggle-loading">
  <%= w_button "Fetch Data",
               variant: :primary,
               loading_text: "Loading...",
               data: {
                 action: "click->toggle-loading#fetch",
                 loading: false
               } %>
</div>
```

### Button Group for Actions

```erb
<div class="flex gap-2">
  <%= w_button "Save Draft",
               variant: :outline,
               icon: "fa-solid fa-save" %>

  <%= w_button "Preview",
               variant: :secondary,
               icon: "fa-solid fa-eye",
               target: "_blank",
               href: preview_post_path(@post) %>

  <%= w_button "Publish",
               variant: :primary,
               icon: "fa-solid fa-paper-plane",
               loading_text: "Publishing..." %>
</div>
```

# Customization Examples with Plain JavaScript

Here are some additional use case examples where you might want to customize the button component with plain JavaScript:

---

### **1. Dynamic Content Updates**

Users might want the button text or behavior to change dynamically based on user input or application state.

**Example: Update Button Text Dynamically**

```erb
<%= w_button "Save", id: "dynamic-button", variant: :primary %>
```

**JavaScript:**

```javascript
document.addEventListener("DOMContentLoaded", () => {
  const button = document.getElementById("dynamic-button");

  if (button) {
    button.addEventListener("click", () => {
      button.innerHTML = "Saved!";
      button.disabled = true;

      setTimeout(() => {
        button.innerHTML = "Save Again";
        button.disabled = false;
      }, 2000);
    });
  }
});
```

---

### **2. Conditional Button Visibility**

Users may hide or show buttons based on application logic or user actions.

**Example: Hide or Show a Button**

```erb
<%= w_button "Delete", id: "delete-button", variant: :secondary %>
```

**JavaScript:**

```javascript
document.addEventListener("DOMContentLoaded", () => {
  const button = document.getElementById("delete-button");

  // Simulate a condition (e.g., API response)
  const shouldShowButton = Math.random() > 0.5;

  if (!shouldShowButton) {
    button.style.display = "none";
  }
});
```

---

### **3. Toggle Button State**

Users might need to enable or disable the button dynamically based on form validation or other conditions.

**Example: Enable Button After Form Validation**

```erb
<%= w_button "Submit", id: "form-submit-button", variant: :primary, disabled: true %>
```

**JavaScript:**

```javascript
document.addEventListener("DOMContentLoaded", () => {
  const button = document.getElementById("form-submit-button");
  const input = document.getElementById("form-input");

  input.addEventListener("input", () => {
    button.disabled = input.value.trim() === "";
  });
});
```

---

### **4. Perform AJAX Calls**

Users might want the button to trigger an asynchronous operation like submitting data without reloading the page.

**Example: Submit Data with AJAX**

```erb
<%= w_button "Submit", id: "ajax-button", loading_text: "Submitting..." %>
```

**JavaScript:**

```javascript
document.addEventListener("DOMContentLoaded", () => {
  const button = document.getElementById("ajax-button");

  button.addEventListener("click", (event) => {
    event.preventDefault();

    // Show loading state
    const originalContent = button.innerHTML;
    const loadingText =
      button.getAttribute("data-button-loading-text") || "Loading...";
    button.innerHTML = `<span class="w-button-spinner"></span> ${loadingText}`;
    button.disabled = true;

    // Simulate an AJAX call
    setTimeout(() => {
      alert("Data submitted successfully!");
      button.innerHTML = originalContent;
      button.disabled = false;
    }, 2000);
  });
});
```

---

### **5. Trigger Navigation**

Users might need the button to navigate programmatically, for example, after a successful operation.

**Example: Navigate After Click**

```erb
<%= w_button "Go to Dashboard", id: "navigate-button", loading_text: "Redirecting..." %>
```

**JavaScript:**

```javascript
document.addEventListener("DOMContentLoaded", () => {
  const button = document.getElementById("navigate-button");

  button.addEventListener("click", (event) => {
    event.preventDefault();

    // Show loading state
    const loadingText =
      button.getAttribute("data-button-loading-text") || "Loading...";
    button.innerHTML = `<span class="w-button-spinner"></span> ${loadingText}`;
    button.disabled = true;

    // Simulate a delay and navigate
    setTimeout(() => {
      window.location.href = "/dashboard";
    }, 2000);
  });
});
```

---

### **6. Customize Hover Effects**

Users might want to add custom behavior on hover.

**Example: Change Button Text on Hover**

```erb
<%= w_button "Hover Me", id: "hover-button", variant: :outline %>
```

**JavaScript:**

```javascript
document.addEventListener("DOMContentLoaded", () => {
  const button = document.getElementById("hover-button");

  button.addEventListener("mouseover", () => {
    button.innerHTML = "You're Hovering!";
  });

  button.addEventListener("mouseout", () => {
    button.innerHTML = "Hover Me";
  });
});
```

---

### **7. Debounce Click Events**

Users might want to prevent multiple rapid clicks on a button.

**Example: Prevent Rapid Clicks**

```erb
<%= w_button "Click Me", id: "debounce-button", variant: :primary %>
```

**JavaScript:**

```javascript
document.addEventListener("DOMContentLoaded", () => {
  const button = document.getElementById("debounce-button");
  let isProcessing = false;

  button.addEventListener("click", (event) => {
    if (isProcessing) return;

    isProcessing = true;
    button.disabled = true;

    setTimeout(() => {
      alert("Action completed!");
      isProcessing = false;
      button.disabled = false;
    }, 2000);
  });
});
```

---
