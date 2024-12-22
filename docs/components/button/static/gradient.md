---
layout: default
title: Gradient
parent: Static Button
nav_order: 2
---

## Gradient

```erb
<%# Predefined gradients %>
<%= w_button "Blue Gradient", gradient: :blue %>
<%= w_button "Purple Gradient", gradient: :purple %>
<%= w_button "Green Gradient", gradient: :green %>
<%= w_button "Sunset Gradient", gradient: :sunset %>
<%= w_button "Indigo Gradient", gradient: :indigo %>
<%= w_button "Slate Gradient", gradient: :slate %>
<%= w_button "Ocean Gradient", gradient: :ocean %>
<%= w_button "Rose Gradient", gradient: :rose %>
<%= w_button "Amber Gradient", gradient: :amber %>
<%= w_button "Emerald Gradient", gradient: :emerald %>

<%# Custom gradients - Two colors gradient %>
<%= w_button "Custom - Coral Reef", gradient: { from: "#ff6b6b", to: "#4ecdc4" } %>
<%= w_button "Custom - Ocean Breeze", gradient: { from: "#2193b0", to: "#6dd5ed" } %>

<%# Custom gradients - Three colors gradient %>
<%= w_button "Custom - Coral Reef", gradient: { from: "#ff6b6b", to: "#4ecdc4", via: "#4ecdc4" } %>
<%= w_button "Custom - Forest Mist", gradient: { from: "#2AF598", via: "#08AEEA", to: "#02CCBA" } %>
```
