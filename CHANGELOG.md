# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/),
and this project adheres to [Semantic Versioning](https://semver.org/).

## [0.5.6] - 2024-12-18

- Added `w_js` helper to use in your application layout file
- This helper `w_js` automatically includes the necessary JavaScript file for WildayUI in your application.

## [0.5.5] - 2024-12-17

- Fixed error javascript not loaded when rails application uses `wilday_ui` gem and deployed to production.

## [0.5.4] - 2024-12-17

- Fixed error when rails application uses `wilday_ui` gem and deployed to production. Using Sprockets for asset precompilation.
  
## [0.5.3] - 2024-12-17

- Fixed error when rails application uses `wilday_ui` gem and deployed to production.

## [0.5.2] - 2024-12-17

- Fixed error when rails application uses `wilday_ui` gem and deployed to production.

## [0.5.1] - 2024-12-17

- Added `require "wilday_ui/version"` in `version.rb` to check for the latest version of the gem.

## [0.5.0] - 2024-12-17

- Added new parameter `theme` for `w_button` component.
- Now you can use basic variants for `w_button` component like `solid`, `outline`, `surface`, `ghost`, `link`.
- Also can use `theme` parameter to change the color of the button like `primary`, `secondary`, `success`, `danger`, `warning`, `info`, `light`, `dark`.
- You can combine `variant` and `theme` parameter like `variant: :solid, theme: { name: :primary }`.
- You can custom theme color for `w_button` component like:
  ```erb
  <%= w_button "Custom", 
      variant: :solid, 
      theme: { 
        custom: { 
          color: "#ffffff",
          background: "#8b5cf6",
          hover: {
            background: "#7c3aed"
          }
        } 
      } 
  %>
  ```

## [0.4.0] - 2024-12-15

- Added basic dropdown and nested dropdown features for button `w_button` component
- Updated the documentation to include the new features

## [0.3.0] - 2024-12-12

- Added loading state for `w_button`.
- Added docs folder to document the usage of the gem. Will be published to [wildayui.com](https://davidwinalda.github.io/wildayui).

## [0.2.3] - 2024-12-10

- Fixed notification through the console when a new version of the gem is available.

## [0.2.2] - 2024-12-10

- Fixed notification through the console when a new version of the gem is available.

## [0.2.1] - 2024-12-10

- Added notification through the console when a new version of the gem is available.

## [0.2.0] - 2024-12-09

- Added `icon` support for `w_button` with `icon_position`.

## [0.1.0] - 2024-12-09

- Initial release with the `w_button` component.
  - Customizable variants (`primary`, `secondary`, `outline`).
  - Adjustable sizes (`small`, `medium`, `large`).
  - Support for border radius (`rounded`, `pill`, `square`).
