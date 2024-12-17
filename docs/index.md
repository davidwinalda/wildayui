---
title: Home
layout: home
nav_order: 1
---

## Table of Contents
{: .no_toc .text-delta }

1. TOC
{:toc}

# What is WildayUI
WildayUI is a simple, minimalist, and customizable library of pre-built components for Ruby on Rails applications. It empowers developers to quickly build user interfaces, enabling them to focus on bringing their ideas to life and creating impactful websites.

WildayUI's main goal is to provide **static components** (such as buttons, badges, etc.) and **dynamic components** (such as dropdowns, modals, etc.) that are easily customizable and extendable. Each page in the component documentation is divided into sections for static and dynamic components.

---
## Installation
To start using Wilday UI, add it to your Gemfile:
```ruby
gem "wilday_ui"
```
Then install the gem:
```bash
$ bundle install
```

---
## Seamless Rails Integration
WildayUI is built as a Rails engine, allowing effortless setup and native integration into your Rails applications without additional configuration.

For example, after installing WildayUI, you can instantly use the prebuilt `w_button` helper in your views like this:

```erb
<%= w_button "Click Me", variant: :solid %>
```

This renders a styled, ready-to-use button in your Rails application:

```html
<button class="w-button w-button-solid">Click Me</button>
```

No need to manually add assets or write repetitive HTML/CSS. WildayUI handles it for you!

---
## UI Component Library
WildayUI aims to provide the essential UI components you need to build interfaces quickly using reusable elements with minimal CSS and JavaScript.

Focus on functionality instead of repetitive code, while enjoying the flexibility of fully customizable components tailored to your needs.
### Example: Button Component

WildayUI simplifies creating buttons with different styles, sizes, and functionalities without needing extensive CSS or JavaScript setup.

**Code Example:**

```erb
# A primary button with default styling
<%= w_button "Primary Button", variant: :solid, theme: { name: :primary } %>

# A secondary button with rounded corners
<%= w_button "Rounded Button", variant: :secondary, radius: :rounded %>

# A primary button with a loading spinner and custom loading text
<%= w_button "Loading Button", loading: true, loading_text: "Processing..." %>

# An outline-styled button acting as an external link that opens in a new tab
<%= w_button "External Link", href: "https://example.com", target: "_blank", variant: :outline %>

# A primary button with an icon positioned to the right of the text
<%= w_button "Icon Button Right", variant: :solid, theme: { name: :primary }, icon: "fa-solid fa-user", icon_position: :right %>

# A primary button with an icon positioned to the left of the text
<%= w_button "Icon Button Left", variant: :solid, theme: { name: :primary }, icon: "fa-solid fa-user", icon_position: :left %>
```

WildayUI handles the underlying CSS and JavaScript logic, so you can focus on building functionality while keeping your codebase clean and maintainable.

---
## CSS & JavaScript
We love CSS and JavaScript, but sometimes building a website quickly while keeping it manageable can take more time if you handle all the CSS and JavaScript yourself.

WildayUI is here to help developers minimize the need for custom CSS and JavaScript, allowing you to build fast without sacrificing simplicity. And of course, you can always add more CSS and JavaScript later as needed.

---
# Customizeable
It's essential to provide developers with the flexibility and freedom to customize components, whether it's the CSS, JavaScript, or integration with frameworks and libraries.

If WildayUI's pre-built components don't fully meet your design or interaction needs, you can easily customize and extend them to align perfectly with your project's requirements.

---
## Customize CSS
We provide `additional_classes` so you can add or change CSS styles for the component.

WildayUI components come with minimal CSS to ensure you can style them as needed to match your project's unique design system. You can extend or override the default styles by using your own CSS classes or customizing the provided styles.

For example, you can add your custom styles to enhance or completely restyle a button:

```css
/* Add your custom styles */
.my-custom-button {
  background-color: #4caf50; /* Green background */
  color: white; /* White text */
  border: none;
  padding: 0.75rem 1.5rem;
  font-size: 1rem;
  border-radius: 0.5rem; /* Rounded corners */
  transition: background-color 0.3s ease;
}

.my-custom-button:hover {
  background-color: #45a049; /* Darker green on hover */
}
```

Then apply it to the button using the `additional_classes` option:

```erb
<%= w_button "Custom Styled Button", additional_classes: "my-custom-button" %>
```

This gives you the flexibility to quickly adapt WildayUI components to your design needs while keeping your CSS modular and manageable.

### Override Default Classes

You can override WildayUI's default classes in your application's CSS:

```css
/* app/assets/stylesheets/application.css */

/* Override primary theme */
.w-button[data-theme="primary"] {
  /* Default state */
  --w-button-color: white;
  --w-button-bg: #8b5cf6;      /* Custom purple */
  --w-button-border: #8b5cf6;

  /* Hover state */
  --w-button-hover-color: white;
  --w-button-hover-bg: #7c3aed;
  --w-button-hover-border: #7c3aed;

  /* Active state */
  --w-button-active-color: white;
  --w-button-active-bg: #6d28d9;
  --w-button-active-border: #6d28d9;
}

/* Override secondary theme */
.w-button[data-theme="secondary"] {
  --w-button-color: white;
  --w-button-bg: #64748b;      /* Custom slate */
  --w-button-border: #64748b;
  --w-button-hover-color: white;
  --w-button-hover-bg: #475569;
  --w-button-hover-border: #475569;
  --w-button-active-color: white;
  --w-button-active-bg: #334155;
  --w-button-active-border: #334155;
}

/* Custom medium size */

.w-button-medium {

padding: 0.75rem 1.5rem;

}

/* Let's add a custom gradient variant */

.w-button-gradient {

background: linear-gradient(to right, #4f46e5, #7c3aed);

color: white;

border: none;

}

.w-button-gradient:hover {

background: linear-gradient(to right, #4338ca, #6d28d9);

}
```

```erb
<%= w_button "Primary", variant: :solid, theme: { name: :primary } %>

<%= w_button "Secondary", theme: { name: :secondary } %>

<%= w_button "Gradient", additional_classes: "w-button-gradient" %>
```

### Add Custom Classes

Use the `additional_classes` parameter to add your own classes:

```erb
<%= w_button "Custom Button",
             variant: :solid,
             theme: { name: :primary },
             additional_classes: "my-custom-button" %>
```

```css
/* Your custom CSS */
.my-custom-button {
  text-transform: uppercase;
  letter-spacing: 0.1em;
}
```

### Create New Variants

Extend the button with your own themes by combining custom classes:

```css
/* app/assets/stylesheets/application.css */

/* Custom neon variant */
.w-button-neon {
  background-color: transparent;
  color: #00ff00;
  border: 2px solid #00ff00;
  text-shadow: 0 0 5px #00ff00;
  box-shadow: 0 0 10px #00ff00;
}

.w-button-neon:hover {
  background-color: rgba(0, 255, 0, 0.1);
  box-shadow: 0 0 20px #00ff00;
}

/* Custom retro variant */
.w-button-retro {
  background: #ffd700;
  color: #800080;
  border: 3px solid #800080;
  box-shadow: 3px 3px 0 #800080;
  transform: translate(-3px, -3px);
}

.w-button-retro:hover {
  transform: translate(0, 0);
  box-shadow: 0 0 0 #800080;
}
```

```erb
<%= w_button "Neon Button",
    variant: :solid,
    additional_classes: "w-button-neon",
    icon: "fa-solid fa-bolt"
%>

<%= w_button "Retro Style",
    variant: :solid,
    additional_classes: "w-button-retro"
%>
```

---
## Customize JavaScript
WildayUI's components come with pre-built JavaScript functionality, but we understand that every project has unique interaction needs. You can **extend** or **override** the default JavaScript behavior to fit your specific requirements.

Our components are built using **Stimulus**, making it simple to hook into or replace the default behavior with your own Stimulus controllers or JavaScript functions.

For example, you can override the behavior of the `w_button` loading state:
### Default Behavior

The `button_controller.js` manages the loading state when you click a button with the `loading` attribute.

```erb
<%= w_button "Submit", loading_text: "Submitting..." %>
```

This triggers the default `toggleLoading` action in the `ButtonController` to display a spinner and disable the button during the loading state.
### Custom Behavior Example

If you need a custom loading duration or additional functionality, you can create your own Stimulus controller:

```javascript
// app/javascript/controllers/custom_button_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    console.log("Custom button controller connected!");
  }

  toggleLoading(event) {
    const button = this.element;
    button.innerHTML = "Custom Loading...";
    button.disabled = true;

    // Add your custom logic
    setTimeout(() => {
      button.innerHTML = "Done!";
      button.disabled = false;
    }, 3000); // Custom duration
  }
}
```

Attach this custom controller to the button:

```erb
<%= w_button "Custom Button", loading_text: "Loading...", additional_classes: "custom-button", data: { controller: "custom-button", action: "click->custom-button#toggleLoading" } %>
```

With this flexibility, you can easily tailor the component's behavior to your application's unique requirements while leveraging WildayUI's foundation.

---
### Customize JavaScript for Plain JavaScript Users

WildayUI components are designed to be flexible and work seamlessly, even if you're not using Stimulus. For developers who prefer plain JavaScript, we provide hooks and example code snippets to help you integrate and customize the component behavior.

For instance, you can handle the loading state of the `w_button` component without Stimulus by writing your own JavaScript logic.

---
#### Default Example with Stimulus

Using Stimulus, the `loading` state is managed automatically:

```erb
<%= w_button "Submit", loading_text: "Submitting..." %>
```

This button uses the `ButtonController` by default to handle the loading state.

---

#### Plain JavaScript Customization Example

To achieve similar functionality without Stimulus, you can manually toggle the loading state of a button using HTML attribute `id` :

```erb
<%= w_button "Submit", id: "plain-js-button", loading_text: "Submitting..." %>
```

Here’s how you can implement the behavior using plain JavaScript:

```javascript
document.addEventListener("DOMContentLoaded", () => {
  const button = document.getElementById("plain-js-button");

  if (button) {
    button.addEventListener("click", (event) => {
      // Prevent default behavior
      event.preventDefault();

      // Save the original content
      const originalContent = button.innerHTML;
      const loadingText = button.getAttribute("data-button-loading-text") || "Loading...";

      // Set loading state
      button.disabled = true;
      button.innerHTML = `<span class="w-button-spinner"></span> ${loadingText}`;

      // Simulate a delay (e.g., API call)
      setTimeout(() => {
        button.disabled = false;
        button.innerHTML = originalContent;
      }, 2000); // Custom delay
    });
  }
});
```

---

#### Key Points for Plain JavaScript Users

- **Hook into the HTML attributes**: Use attributes like `id` and `data-*` to connect your custom JavaScript logic to the component.
- **Manipulate DOM Elements**: Directly update the component's content and classes for your desired behavior.
- **Minimal Dependencies**: You don’t need Stimulus or any other JavaScript framework to customize WildayUI components.

This approach gives you full control of the component's behavior while maintaining the simplicity of using plain JavaScript.

You can see another use case here

[Button Usage Examples →](./components/button/examples.html#customization-examples-with-plain-javascript){: .btn .btn-primary }

---
## Customize Stimulus

WildayUI components are powered by Stimulus controllers to provide interactive behaviors seamlessly. For instance, the default button controller automatically manages loading states when `loading_text` is specified.

We **highly recommend** utilizing the default Stimulus controllers as they simplify functionality and save development time. Only **disable** them when absolutely necessary. If customization is needed, consider overriding, extending, or even combining the default controller with your custom logic for maximum flexibility and efficiency.
### Add Custom Controller

You can add your own Stimulus controller without disabling the default one:

```erb
<%# The default controller won't be added since we specified our own %>
<%= w_button "Custom Behavior", 
             data: { controller: "my-button" } %>
```

Create your controller:
```javascript
// app/javascript/controllers/my_button_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("Custom button controller connected!")
  }
  
  handleClick(event) {
    // Your custom click handling
    console.log("Button clicked!")
  }
}
```

### Using Both Controllers

You can use both the default and your custom controller:

```erb
<%= w_button "Dual Control",
             loading_text: "Loading...",
             data: { 
               controller: "button my-button",
               action: "click->button#toggleLoading click->my-button#handleClick"
             } %>
```

### Explicitly Disable Default Controller

If needed, you can explicitly disable the default controller using `use_default_controller: false`:

```erb
<%= w_button "No Default",
             use_default_controller: false,
             loading_text: "Loading...",
             data: { controller: "my-button" } %>
```

### Extended Example

Here's a additional example combining loading states with custom behavior:

```javascript
// app/javascript/controllers/submit_button_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    submitUrl: String
  }

  async handleSubmit(event) {
    event.preventDefault()
    
    try {
      // Start loading state
      this.element.classList.add("w-button-loading")
      
      // Your async operation
      const response = await fetch(this.submitUrlValue, {
        method: 'POST',
        // ... other fetch options
      })
      
      if (response.ok) {
        // Success handling
        this.element.classList.add("w-button-success")
      } else {
        // Error handling
        this.element.classList.add("w-button-error")
      }
    } finally {
      // Always remove loading state
      this.element.classList.remove("w-button-loading")
    }
  }
}
```

Use it in your view:
```erb
<%= w_button "Submit Form",
             variant: :solid,
             theme: { name: :primary },
             loading_text: "Submitting...",
             data: { 
               controller: "submit-button",
               action: "click->submit-button#handleSubmit",
               submit_button_submit_url_value: submit_path
             } %>
```

### Event Handling

Listen for button events in your controller:

```javascript
// app/javascript/controllers/button_events_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  initialize() {
    // Listen for loading state changes
    this.element.addEventListener("wilday:loading:start", this.handleLoadingStart)
    this.element.addEventListener("wilday:loading:end", this.handleLoadingEnd)
  }
  
  handleLoadingStart(event) {
    console.log("Button started loading")
    // Your custom loading start logic
  }
  
  handleLoadingEnd(event) {
    console.log("Button finished loading")
    // Your custom loading end logic
  }
  
  disconnect() {
    // Clean up event listeners
    this.element.removeEventListener("wilday:loading:start", this.handleLoadingStart)
    this.element.removeEventListener("wilday:loading:end", this.handleLoadingEnd)
  }
}
```

This gives you complete control over button behavior while maintaining the option to use the default loading state functionality.

---
### **`use_default_controller`**

The `use_default_controller` option provides flexibility by allowing you to enable or disable the default Stimulus controller for any component. By setting it to `false`, you can fully control the component's behavior, integrating your own JavaScript logic or using third-party libraries without conflicts.

---

#### When to Use

- **Custom Behavior**: Implement unique interactions tailored to your app.
- **Third-Party Integration**: Avoid conflicts with external libraries like Bootstrap or jQuery.
- **Minimal JavaScript**: Use the component without attaching any JavaScript functionality.
- **Advanced Use Cases**: Extend or override default functionality with your own implementation.

---
#### Example

For a button component:

```erb
<%= w_button "Custom Submit", 
    variant: :solid,
    theme: { name: :primary },
    loading_text: "Processing...", 
    use_default_controller: false, 
    data: { controller: "custom-handler", action: "click->custom-handler#onClick" } %>
```

In this example:

- The default Stimulus controller is disabled.
- A custom Stimulus controller `custom-handler` is attached with the `onClick` action to handle specialized functionality.

---
## Using Library and Framework
### Tailwind

WildayUI components are designed to work seamlessly with Tailwind CSS. You can leverage Tailwind's utility classes through the `additional_classes` parameter to customize components while maintaining your project's design system.
#### Basic Integration

```erb
<%= w_button "Tailwind Button", 
	 variant: :solid,
	 theme: { name: :primary },
	 additional_classes: "bg-indigo-600 hover:bg-indigo-700" 
%>
```

#### Extended Examples

```erb
# Custom gradient button with Tailwind
<%= w_button "Gradient Button",
	 additional_classes: "bg-gradient-to-r from-purple-500 to-pink-500 hover:from-purple-600 hover:to-pink-600" %>

# Fully customized button with Tailwind
<%= w_button "Custom Button",
             use_default_controller: true,
             additional_classes: "px-4 py-2 bg-teal-500 text-white font-semibold rounded-lg shadow-md hover:bg-teal-700 focus:outline-none focus:ring-2 focus:ring-teal-400 focus:ring-opacity-75" %>

# Responsive button using Tailwind
<%= w_button "Responsive",
             additional_classes: "w-full md:w-auto text-sm md:text-base" %>
```

#### Combining with WildayUI Variants

You can mix WildayUI's built-in variants with Tailwind utilities for maximum flexibility:

```erb
<%= w_button "Hybrid Button",
             variant: :solid,
             theme: { name: :primary },
             radius: :rounded,
             additional_classes: "shadow-lg hover:shadow-xl transition-shadow duration-300" %>
```

This approach allows you to maintain WildayUI's core functionality while leveraging Tailwind's extensive utility classes for fine-tuned styling.
### Bootstrap

WildayUI can be integrated with Bootstrap, but it's important to understand how to handle potential style conflicts between the two libraries.

#### Style Conflicts

When using both WildayUI and Bootstrap classes, you might encounter styling conflicts. For example:

```erb
# NOT RECOMMENDED - Style Conflict
<%= w_button "Bootstrap Button", 
             variant: :solid,
             theme: { name: :primary },
             additional_classes: "btn btn-primary" %>
```

This code will cause conflicts because:
- WildayUI's `variant: :primary` applies `.w-button-primary` styles
- Bootstrap's `btn btn-primary` applies its own primary button styles
- Both libraries will try to control the same properties (background-color, border, etc.)

#### Recommended Approaches

##### Use WildayUI OR Bootstrap (Recommended)

Choose one styling system for each button:

```erb
# Option 1: Pure WildayUI styling
<%= w_button "WildayUI Button", 
             variant: :solid,
             theme: { name: :primary } %>

# Option 2: Pure Bootstrap styling
<%= w_button "Bootstrap Button",
             variant: nil,
             additional_classes: "btn btn-primary" %>
```

##### Custom Integration

If you need to use both libraries, create custom classes that don't conflict:

```erb
# Custom integration with Bootstrap utilities
<%= w_button "Hybrid Button",
             variant: :solid,
             theme: { name: :primary },
             additional_classes: "shadow-sm d-inline-block" %>
```

#### Best Practices

1. **Choose One Base Style:**
   ```erb
   # Use WildayUI's base styles
   <%= w_button "Primary Button", variant: :solid, theme: { name: :primary } %>
   
   # OR use Bootstrap's base styles
   <%= w_button "Bootstrap Button", 
                variant: nil,
                additional_classes: "btn btn-primary" %>
   ```

2. **Use Utility Classes Safely:**
   ```erb
   # Add Bootstrap utilities that don't conflict with core button styles
   <%= w_button "Enhanced Button",
                variant: :solid,
                theme: { name: :primary },
                additional_classes: "mt-3 d-inline-block shadow-sm" %>
   ```

3. **Full Bootstrap Mode:**
   ```erb
   # Disable WildayUI styling completely
   <%= w_button "Pure Bootstrap",
                variant: nil,
                use_default_controller: false,
                additional_classes: "btn btn-primary" %>
   ```

This approach ensures clean, predictable styling while still allowing you to leverage features from both libraries when needed.
### Icon Library

WildayUI's current `icon` parameter is optimized for **Font Awesome** and similar CSS-based icon libraries that use the `<i>` tag with CSS classes. 
#### Compatible Icon Libraries
The `icon` parameter works out of the box with:

```erb
# Font Awesome
<%= w_button "User", icon: "fa-solid fa-user" %>

# Bootstrap Icons
<%= w_button "Search", icon: "bi bi-search" %>

# Remix Icons
<%= w_button "Home", icon: "ri-home-line" %>
```

#### Other Icon Libraries
For icon libraries that use different HTML structures (like SVG-based icons), you'll need to use block syntax instead:

```erb
# Material Icons (needs block syntax)
<%= w_button variant: :solid do %>
  <span class="material-icons">face</span>
  User Profile
<% end %>

# Heroicons (SVG-based)
<%= w_button variant: :solid do %>
  <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
    <!-- SVG path -->
  </svg>
  Settings
<% end %>
```

#### Best Practices

1. **Using the `icon` Parameter**
   ```erb
   # For CSS-based icon libraries (Font Awesome, Bootstrap Icons, etc.)
   <%= w_button "Save", 
                icon: "fa-solid fa-save",
                icon_position: :left %>
   ```

2. **Using Block Syntax**
   ```erb
   # For other icon libraries or custom icons
   <%= w_button variant: :solid do %>
     <!-- Your custom icon HTML here -->
     <span>Button Text</span>
   <% end %>
   ```

#### Future Improvements

We're planning to enhance icon support to better accommodate different icon libraries. Future updates may include:

- Support for SVG-based icons
- Custom icon renderers
- More flexible icon positioning options

## Integration with Other Libraries

While WildayUI provides core UI components, you can enhance them by integrating with popular JavaScript libraries. Here are some common integrations:
### Select2 Integration
```erb

# Enhanced select dropdowns

<%= w_button "Select Options",
  data: {
    controller: "select2",
    action: "click->select2#open"
  } 
%>


# JavaScript setup

import Select2 from 'select2'
// In your Stimulus controller
export default class extends Controller {

  connect() {
  this.select2 = new Select2(...)
  }

  open() {
  this.select2.open()
  }
}

```
## Additional Attributes
(In progress...)

---
# Contribution
We welcome contributions! Check out our [GitHub repository](https://github.com/davidwinalda/wilday_ui) for more details on how to get involved.

---
# License
Wilday UI is open source and available under the [MIT License](https://opensource.org/licenses/MIT).

WildayUI is completely free to use and open source, empowering developers to customize, contribute, and adapt the library to suit their needs without restrictions.  

---
