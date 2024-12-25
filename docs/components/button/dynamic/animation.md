---
layout: default
title: Animation
parent: Dynamic Button
nav_order: 6
---

## Animation

The animation feature allows you to add various motion effects to components including buttons. It supports predefined animations, custom animations, and different trigger methods.

## Configuration Options

The `animation` parameter accepts either a symbol (predefined animation name) or a hash with the following properties:

### Animation Options

| Option       | Type          | Default   | Description                   |
| ------------ | ------------- | --------- | ----------------------------- |
|  `name`      | Symbol/String | `required`  | Animation name or :custom     |
|  `trigger`   | Symbol        |  `:hover`   | When to start animation       |
|  `duration`  | Number        |  `1.0`      | Duration in seconds           |
|  `delay`     | Number        |  `0`        | Delay before start in seconds |
|  `timing`    | Symbol        |  `:ease`    | Timing function               |
|  `iteration` | Symbol/Number |  `1`        | Number of repeats             |
|  `direction` | Symbol        |  `:normal`  | Animation direction           |
|  `fill_mode` | Symbol        |  `:none`    | End state behavior            |
|  `properties` | Hash          | ` nil `     | Custom animation properties   |

### Predefined Animations
```
# Available animation names:
:bounce    :pulse     :scale     :shake
:fade      :slide     :ripple    :rotate
:swing     :pop       :jello     :wobble
:heartbeat :rubberBand :flash    :tada
```

### Trigger Options
```
:hover  # Animate on mouse hover (default)
:click  # Animate on button click
:load   # Animate when component loads
```

### Timing Functions
```
:linear      # Constant speed
:ease        # Default easing
:ease_in     # Start slow, end fast
:ease_out    # Start fast, end slow
:ease_in_out # Slow at both ends
:cubic_bezier # Custom timing curve
```

### Direction Options
```
:normal            # Play forward
:reverse           # Play backward
:alternate         # Forward then backward
:alternate_reverse # Backward then forward
```

### Fill Mode Options
```
:none      # Return to initial state
:forwards  # Keep final state
:backwards # Apply first keyframe during delay
:both      # Combine forwards & backwards
```

## Basic Usage

The simplest way to use animations is to pass the animation name directly:

```erb
# Simple predefined animation
<%= w_button "Animate", animation: :bounce %>

# Animation with trigger
<%= w_button "Click Me", animation: { name: :bounce, trigger: :click } %>
```

## Basic Usage - Custom

If you not enough with predefined animations, you can customize the animation properties:

```erb
<%= w_button "Custom Effect", 
  animation: {
    name: :custom,
    trigger: :hover,
    properties: {
      transform: "scale(1.1) rotate(5deg)",
      background: "linear-gradient(45deg, #ff6b6b, #4ecdc4)"
    }
  }
%>
```

## Custom Animation Properties
### Transform Properties
```
transform: "translateX(10px)"    /* Move horizontally */
transform: "translateY(-10px)"   /* Move vertically */
transform: "scale(1.1)"         /* Scale size */
transform: "rotate(45deg)"      /* Rotate */
transform: "skew(10deg)"        /* Skew/tilt */
```

### Color & Background
```
color: "#ff0000"                /* Text color */
background: "#0000ff"           /* Background color */
background: "linear-gradient()" /* Gradient background */
border_color: "#00ff00"        /* Border color */
opacity: "0.8"                 /* Transparency */
```
### Size & Position
```
width: "120%"                  /* Element width */
height: "auto"                 /* Element height */
margin: "10px"                /* Outer spacing */
padding: "5px 10px"           /* Inner spacing */
```
### Visual Effects
```
box_shadow: "0 4px 6px rgba(0,0,0,0.1)"  /* Shadow */
filter: "blur(2px)"                       /* Visual filters */
backdrop_filter: "blur(5px)"              /* Background blur */
```

### Examples

```erb
<%= w_button "3D Flip Effect",
    animation: {
        name: :custom,
        trigger: :click,           # Triggers on click
        duration: 0.6,             # Quick flip
        delay: 0.1,                # Slight delay
        timing: :cubic_bezier,     # Custom timing
        iteration: 1,              # Once per click
        direction: :normal,        # One direction only
        fill_mode: :both,          # Smooth start/end
        properties: {
            transform: "perspective(1000px) rotateY(180deg)",  # 3D rotation
            background: "#2dd4bf",                             # Teal background
            color: "#ffffff",                                  # White text
            box_shadow: "0 15px 25px rgba(45, 212, 191, 0.3)", # Depth shadow
            border_color: "#14b8a6",                           # Border color
            cubic_bezier: [0.4, 0, 0.2, 1]                     # Smooth curve
        }
    }
%>

<%= w_button "Glowing Button",
    animation: {
        name: :custom,
        trigger: :load,             # Starts automatically on load
        duration: 2.0,              # Slower animation
        delay: 0,                   # No delay
        timing: :ease_in_out,       # Smooth transition
        iteration: :infinite,       # Never stops
        direction: :alternate,      # Pulse in and out
        fill_mode: :forwards,       # Keep end state
        properties: {
            transform: "scale(1.05)",                               # Subtle scale
            background: "linear-gradient(90deg, #4f46e5, #7c3aed)", # Moving gradient
            box_shadow: "0 0 20px rgba(79, 70, 229, 0.6)",          # Glow effect
            filter: "brightness(1.2)",                              # Brightness boost
            opacity: "0.9"                                          # Slight transparency
        }
    }
%>
```
