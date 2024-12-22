---
layout: default
title: Link
parent: Static Button
nav_order: 6
---

## Link Buttons

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
