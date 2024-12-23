import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["trigger"];
  static values = {
    content: String,
    position: { type: String, default: "top" },
    align: { type: String, default: "center" },
    trigger: { type: String, default: "hover" },
    showDelay: { type: Number, default: 0 },
    hideDelay: { type: Number, default: 0 },
    offset: { type: Number, default: 8 },
    theme: { type: String, default: "light" },
    size: { type: String, default: "md" },
    arrow: { type: Boolean, default: false },
    customStyle: String,
  };

  connect() {
    this.tooltipElement = null;
    this.showTimeoutId = null;
    this.hideTimeoutId = null;
    this.setupTooltip();

    // Add scroll handler
    this.scrollHandler = () => {
      if (this.tooltipElement.style.display !== "none") {
        // Check if trigger is in viewport
        const triggerRect = this.triggerTarget.getBoundingClientRect();
        const isInViewport =
          triggerRect.top >= 0 &&
          triggerRect.left >= 0 &&
          triggerRect.bottom <=
            (window.innerHeight || document.documentElement.clientHeight) &&
          triggerRect.right <=
            (window.innerWidth || document.documentElement.clientWidth);

        if (isInViewport) {
          // Update position if trigger is visible
          this.position();
        } else {
          // Hide tooltip if trigger is not visible
          this.hide();
        }
      }
    };
    window.addEventListener("scroll", this.scrollHandler);
  }

  disconnect() {
    if (this.clickOutsideHandler) {
      document.removeEventListener("click", this.clickOutsideHandler);
    }
    window.removeEventListener("scroll", this.scrollHandler);
    this.removeTooltip();
  }

  setupTooltip() {
    this.tooltipElement = this.createTooltipElement();
    document.body.appendChild(this.tooltipElement);

    if (this.triggerValue === "hover") {
      this.triggerTarget.addEventListener("mouseenter", () => this.show());
      this.triggerTarget.addEventListener("mouseleave", () => this.hide());
      this.triggerTarget.addEventListener("focusin", () => this.show());
      this.triggerTarget.addEventListener("focusout", () => this.hide());
    } else if (this.triggerValue === "click") {
      // Check if dropdown or clipboard is present
      const hasDropdown =
        this.element.hasAttribute("data-controller") &&
        this.element.getAttribute("data-controller").includes("dropdown");
      const hasClipboard =
        this.element.hasAttribute("data-controller") &&
        this.element.getAttribute("data-controller").includes("clipboard");

      if (hasDropdown || hasClipboard) {
        // Force hover behavior for dropdown/clipboard buttons
        this.triggerTarget.addEventListener("mouseenter", () => this.show());
        this.triggerTarget.addEventListener("mouseleave", () => this.hide());
      } else {
        // Normal click behavior
        this.triggerTarget.addEventListener("click", (e) => {
          e.stopPropagation();
          this.toggle();
        });

        this.clickOutsideHandler = (e) => {
          if (
            !this.triggerTarget.contains(e.target) &&
            !this.tooltipElement.contains(e.target)
          ) {
            this.hide();
          }
        };
        document.addEventListener("click", this.clickOutsideHandler);
      }
    }
  }

  createTooltipElement() {
    const tooltip = document.createElement("div");
    tooltip.id = this.triggerTarget.getAttribute("aria-describedby");
    tooltip.className = `w-tooltip w-tooltip-${this.themeValue} w-tooltip-size-${this.sizeValue}`;
    if (this.arrowValue) tooltip.classList.add("w-tooltip-arrow"); // Add arrow class if enabled
    tooltip.setAttribute("role", "tooltip");
    tooltip.setAttribute("data-position", this.positionValue);
    tooltip.setAttribute("data-align", this.alignValue);
    tooltip.innerHTML = this.contentValue;

    // Apply custom styles if present
    if (this.hasCustomStyleValue && this.customStyleValue) {
      tooltip.style.cssText += this.customStyleValue;
    }

    tooltip.style.display = "none";
    return tooltip;
  }

  show() {
    clearTimeout(this.hideTimeoutId);
    this.showTimeoutId = setTimeout(() => {
      // Reset any existing transforms and make tooltip visible but hidden
      this.tooltipElement.style.transform = "none";
      this.tooltipElement.style.visibility = "hidden";
      this.tooltipElement.style.display = "block";

      // Force a reflow to ensure dimensions are calculated correctly
      this.tooltipElement.offsetHeight;

      // Position the tooltip
      this.position();

      // Make visible with transition
      this.tooltipElement.style.visibility = "visible";
      requestAnimationFrame(() => {
        this.tooltipElement.classList.add("w-tooltip-visible");
      });
    }, this.showDelayValue);
  }

  hide() {
    clearTimeout(this.showTimeoutId);
    this.hideTimeoutId = setTimeout(() => {
      this.tooltipElement.classList.remove("w-tooltip-visible");
      setTimeout(() => {
        this.tooltipElement.style.display = "none";
      }, 150); // Match transition duration
    }, this.hideDelayValue);
  }

  toggle() {
    if (this.tooltipElement.style.display === "none") {
      this.show();
    } else {
      this.hide();
    }
  }

  position() {
    const triggerRect = this.triggerTarget.getBoundingClientRect();
    const tooltipRect = this.tooltipElement.getBoundingClientRect();
    const viewportHeight = window.innerHeight;
    const viewportWidth = window.innerWidth;
    const arrowOffset = this.arrowValue ? 2 : 0;

    // Calculate scroll position
    const scrollX = window.pageXOffset || document.documentElement.scrollLeft;
    const scrollY = window.pageYOffset || document.documentElement.scrollTop;

    let position = this.positionValue;
    let top, left;

    // Calculate available space in viewport
    const spaceBelow = viewportHeight - triggerRect.bottom;
    const spaceAbove = triggerRect.top;
    const spaceRight = viewportWidth - triggerRect.right;
    const spaceLeft = triggerRect.left;
    const requiredSpaceVertical =
      tooltipRect.height + this.offsetValue + arrowOffset;
    const requiredSpaceHorizontal =
      tooltipRect.width + this.offsetValue + arrowOffset;

    // Determine position based on available viewport space
    if (position === "right" && spaceRight >= requiredSpaceHorizontal) {
      position = "right";
    } else if (position === "left" && spaceLeft >= requiredSpaceHorizontal) {
      position = "left";
    } else if (position === "top" && spaceAbove >= requiredSpaceVertical) {
      position = "top";
    } else if (position === "bottom" && spaceBelow >= requiredSpaceVertical) {
      position = "bottom";
    } else if (spaceBelow >= requiredSpaceVertical) {
      position = "bottom";
    } else {
      position = "top";
    }

    // Calculate viewport-relative position
    switch (position) {
      case "top":
        // Position above trigger
        top =
          triggerRect.top - tooltipRect.height - this.offsetValue - arrowOffset;
        if (this.alignValue === "end") {
          left = triggerRect.right - tooltipRect.width;
        } else if (this.alignValue === "center") {
          left =
            triggerRect.left + triggerRect.width / 2 - tooltipRect.width / 2;
        } else {
          // start
          left = triggerRect.left;
        }
        break;
      case "bottom":
        // Position below trigger
        top = triggerRect.bottom + this.offsetValue + arrowOffset;
        if (this.alignValue === "end") {
          left = triggerRect.right - tooltipRect.width;
        } else if (this.alignValue === "center") {
          left =
            triggerRect.left + triggerRect.width / 2 - tooltipRect.width / 2;
        } else {
          // start
          left = triggerRect.left;
        }
        break;
      case "left":
        // Position to the left of trigger
        left =
          triggerRect.left - tooltipRect.width - this.offsetValue - arrowOffset;
        if (this.alignValue === "end") {
          top = triggerRect.bottom - tooltipRect.height;
        } else if (this.alignValue === "center") {
          top =
            triggerRect.top + triggerRect.height / 2 - tooltipRect.height / 2;
        } else {
          // start
          top = triggerRect.top;
        }
        break;
      case "right":
        // Position to the right of trigger
        left = triggerRect.right + this.offsetValue + arrowOffset;
        if (this.alignValue === "end") {
          top = triggerRect.bottom - tooltipRect.height;
        } else if (this.alignValue === "center") {
          top =
            triggerRect.top + triggerRect.height / 2 - tooltipRect.height / 2;
        } else {
          // start
          top = triggerRect.top;
        }
        break;
    }

    // Ensure tooltip stays within viewport
    if (top < 0) {
      top = this.offsetValue; // Keep some padding from top
    } else if (top + tooltipRect.height > viewportHeight) {
      top = viewportHeight - tooltipRect.height - this.offsetValue;
    }

    if (left < 0) {
      left = this.offsetValue; // Keep some padding from left
    } else if (left + tooltipRect.width > viewportWidth) {
      left = viewportWidth - tooltipRect.width - this.offsetValue;
    }

    // Add scroll position to final coordinates
    top += scrollY;
    left += scrollX;

    // Update tooltip position and data attribute
    this.tooltipElement.setAttribute("data-position", position);
    this.tooltipElement.style.top = `${top}px`;
    this.tooltipElement.style.left = `${left}px`;
  }

  removeTooltip() {
    if (this.tooltipElement) {
      this.tooltipElement.remove();
      this.tooltipElement = null;
    }
  }
}
