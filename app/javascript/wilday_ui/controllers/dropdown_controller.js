import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["button", "menu"];
  static values = {
    trigger: { type: String, default: "click" },
    position: { type: String, default: "bottom" },
    align: { type: String, default: "start" },
  };

  connect() {
    console.log("Dropdown controller connected:", this.element);
    console.log("Menu Target:", this.menuTarget);
    console.log("Button Target:", this.buttonTarget);

    const position = this.element.dataset.dropdownPositionValue;
    const align = this.element.dataset.dropdownAlignValue;

    if (position) this.positionValue = position;
    if (align) this.alignValue = align;

    console.log("Dropdown connected with:", {
      position: this.positionValue,
      align: this.alignValue,
    });

    // Set up hover events if trigger is hover
    if (this.triggerValue === "hover") {
      this.element.addEventListener("mouseenter", () => this.show());
      this.element.addEventListener("mouseleave", () => this.hide());
    }

    // Set up keyboard navigation
    this.element.addEventListener("keydown", this.handleKeydown.bind(this));

    // Close on click outside
    document.addEventListener("click", this.handleClickOutside.bind(this));
  }

  disconnect() {
    document.removeEventListener("click", this.handleClickOutside.bind(this));
  }

  toggle(event) {
    console.log("Toggle method triggered");
    console.log("Menu target:", this.menuTarget);

    if (this.triggerValue === "click") {
      event.preventDefault();
      event.stopPropagation();

      if (this.isOpen) {
        this.hide();
      } else {
        this.show();
      }
    }
  }

  show() {
    console.log("Show method triggered");
    this.updatePosition();
    this.menuTarget.classList.add("show");
    this.buttonTarget.classList.add("active");
    this.buttonTarget.setAttribute("aria-expanded", "true");

    // Apply position and alignment
    this.menuTarget.dataset.position = this.positionValue || "bottom";
    this.menuTarget.dataset.align = this.alignValue || "start";

    console.log(
      "Setting position:",
      this.positionValue,
      "align:",
      this.alignValue
    );

    // Focus first menu item
    const firstItem = this.menuTarget.querySelector(".w-button-dropdown-item");
    if (firstItem) firstItem.focus();
  }

  hide() {
    this.menuTarget.classList.remove("show");
    this.buttonTarget.classList.remove("active");
    this.buttonTarget.setAttribute("aria-expanded", "false");
  }

  handleClickOutside(event) {
    if (!this.element.contains(event.target) && this.isOpen) {
      this.hide();
    }
  }

  handleKeydown(event) {
    if (!this.isOpen && event.key === "Enter") {
      this.show();
      return;
    }

    if (this.isOpen) {
      switch (event.key) {
        case "Escape":
          this.hide();
          this.buttonTarget.focus();
          break;
        case "ArrowDown":
          event.preventDefault();
          this.focusNextItem();
          break;
        case "ArrowUp":
          event.preventDefault();
          this.focusPreviousItem();
          break;
        case "Tab":
          this.hide();
          break;
      }
    }
  }

  focusNextItem() {
    const items = this.getMenuItems();
    const currentIndex = items.indexOf(document.activeElement);
    const nextIndex = currentIndex + 1 < items.length ? currentIndex + 1 : 0;
    items[nextIndex].focus();
  }

  focusPreviousItem() {
    const items = this.getMenuItems();
    const currentIndex = items.indexOf(document.activeElement);
    const previousIndex =
      currentIndex > 0 ? currentIndex - 1 : items.length - 1;
    items[previousIndex].focus();
  }

  getMenuItems() {
    return Array.from(
      this.menuTarget.querySelectorAll(".w-button-dropdown-item")
    );
  }

  updatePosition() {
    const position = this.hasPositionValue ? this.positionValue : "bottom";
    const align = this.hasAlignValue ? this.alignValue : "start";

    console.log("Setting position:", position, "align:", align); // Debug log

    this.menuTarget.setAttribute("data-position", position);
    this.menuTarget.setAttribute("data-align", align);
  }

  get isOpen() {
    return this.menuTarget.classList.contains("show");
  }
}
