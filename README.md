# Wilday UI

Wilday UI is a simple, customizable UI component library for Ruby on Rails projects. It provides a collection of prebuilt, reusable components with customizable styles and options, making it easy to build beautiful, consistent, and maintainable user interfaces.

---

## Features

- Prebuilt, customizable UI components for common needs
- Flexible styling options with variants, sizes, and layouts
- Support for seamless integration with Rails as an engine
- Built for extensibility and framework compatibility

---

## Why These Features Are Important

1. **Flexibility**: Users can style component without being restricted to predefined classes.
2. **Extensibility**: Users can add attributes or integrate component with JavaScript, analytics, or accessibility tools.
3. **Framework Integration**: Supports utility classes from frameworks like Bootstrap or Tailwind.
4. **Library Integration**: Support to use with other libraries like Font Awesome, Bootstrap Icons, etc.

## Installation

Add Wilday UI to your application's Gemfile:

```ruby
gem "wilday_ui"
```

Then execute:

```bash
bundle install
```

Or install it directly:

```bash
gem install wilday_ui
```

---

## Usage

### Button Component

Render a button in your Rails views using the `w_button` helper:

```erb
<%= w_button "Click Me", variant: :primary %>
```

### Customization Options

| Option                   | Description                                           | Example                                  |
| ------------------------ | ----------------------------------------------------- | ---------------------------------------- |
| **`variant`**            | Button style (`:primary`, `:secondary`, `:outline`)   | `variant: :primary`                      |
| **`size`**               | Button size (`:small`, `:medium`, `:large`)           | `size: :large`                           |
| **`radius`**             | Button shape (`:rounded`, `:pill`, `:square`)         | `radius: :pill`                          |
| **`additional_classes`** | Add custom CSS classes                                | `additional_classes: "shadow-md"`        |
| **`**options`\*\*        | Add custom HTML attributes (e.g., `data-*`, `aria-*`) | `data: { tracking: "click" }, id: "btn"` |

---

### Examples

#### Basic Button

```erb
<%= w_button "Submit", variant: :primary %>
```

#### Custom Size and Shape

```erb
<%= w_button "Save", size: :large, radius: :pill %>
```

#### Fully Customized Button

```erb
<%= w_button "Custom",
    variant: :outline,
    additional_classes: "text-center shadow-lg",
    data: { action: "click->controller#action" },
    aria: { label: "Custom Button" } %>
```

---

## Contributing

Contributions are welcome! If you’d like to help improve Wilday UI, feel free to open an issue or submit a pull request.

---

## License

Wilday UI is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

---
