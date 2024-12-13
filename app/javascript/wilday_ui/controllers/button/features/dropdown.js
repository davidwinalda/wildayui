import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["button", "menu"];
  static values = {
    trigger: { type: String, default: "click" },
    position: { type: String, default: "bottom" },
    align: { type: String, default: "start" },
  };

  connect() {
    this.setupEventListeners();
    this.updatePosition();
  }

  disconnect() {
    document.removeEventListener("click", this.handleClickOutside);
  }

  setupEventListeners() {
    if (this.triggerValue === "hover") {
      this.element.addEventListener("mouseenter", () => this.show());
      this.element.addEventListener("mouseleave", () => this.hide());
    }

    this.handleClickOutside = this.handleClickOutside.bind(this);
    document.addEventListener("click", this.handleClickOutside);
    this.element.addEventListener("keydown", this.handleKeydown.bind(this));
  }

  toggle(event) {
    if (this.triggerValue === "click") {
      event.preventDefault();
      event.stopPropagation();
      this.isOpen ? this.hide() : this.show();
    }
  }

  show() {
    this.menuTarget.classList.add("show");
    this.buttonTarget.classList.add("active");
    this.buttonTarget.setAttribute("aria-expanded", "true");
    this.focusFirstItem();
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

  focusFirstItem() {
    const firstItem = this.menuTarget.querySelector(".w-button-dropdown-item");
    if (firstItem) firstItem.focus();
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
    this.menuTarget.setAttribute("data-position", this.positionValue);
    this.menuTarget.setAttribute("data-align", this.alignValue);
  }

  get isOpen() {
    return this.menuTarget.classList.contains("show");
  }
}
