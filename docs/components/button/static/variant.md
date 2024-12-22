---
layout: default
title: Variant
parent: Static Button
nav_order: 1
---

## Variant

### Default Variants

```erb
<%# Solid - Default, high emphasis actions %>
<%= w_button "Save Changes", variant: :solid %>

<%# Subtle - Secondary actions %>
<%= w_button "Filter", variant: :subtle %>

<%# Surface - Card or elevated contexts %>
<%= w_button "Select Plan", variant: :surface %>

<%# Outline - Secondary actions with clear boundaries %>
<%= w_button "Learn More", variant: :outline %>

<%# Ghost - Minimal emphasis actions %>
<%= w_button "Cancel", variant: :ghost %>

<%# Plain - Link-like buttons %>
<%= w_button "View Details", variant: :plain %>
```

### Themed Variants

```erb
<%= w_button "Primary", variant: :solid, theme: { name: :primary } %>
<%= w_button "Secondary", variant: :solid, theme: { name: :secondary } %>
<%= w_button "Success", variant: :solid, theme: { name: :success } %>
<%= w_button "Danger", variant: :solid, theme: { name: :danger } %>
<%= w_button "Warning", variant: :solid, theme: { name: :warning } %>
<%= w_button "Info", variant: :solid, theme: { name: :info } %>
<%= w_button "Light", variant: :solid, theme: { name: :light } %>
<%= w_button "Dark", variant: :solid, theme: { name: :dark } %>

<%= w_button "Subtle", variant: :subtle, theme: { name: :primary } %>
<%= w_button "Secondary", variant: :subtle, theme: { name: :secondary } %>
<%= w_button "Success", variant: :subtle, theme: { name: :success } %>
<%= w_button "Danger", variant: :subtle, theme: { name: :danger } %>
<%= w_button "Warning", variant: :subtle, theme: { name: :warning } %>
<%= w_button "Info", variant: :subtle, theme: { name: :info } %>
<%= w_button "Light", variant: :subtle, theme: { name: :light } %>
<%= w_button "Dark", variant: :subtle, theme: { name: :dark } %>
```