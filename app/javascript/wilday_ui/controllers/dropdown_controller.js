import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["button", "menu", "submenu"];
  static values = {
    trigger: { type: String, default: "click" },
    position: { type: String, default: "bottom" },
    align: { type: String, default: "start" },
  };

  connect() {
    const position = this.element.dataset.dropdownPositionValue;
    const align = this.element.dataset.dropdownAlignValue;

    if (position) this.positionValue = position;
    if (align) this.alignValue = align;

    // Set up hover events if trigger is hover
    if (this.triggerValue === "hover") {
      this.element.addEventListener("mouseenter", () => {
        console.log("Mouse enter - showing menu");
        this.handleHover(true);
      });

      this.element.addEventListener("mouseleave", () => {
        console.log("Mouse leave - hiding menu");
        this.handleHover(false);
      });
    }

    // Set up keyboard navigation
    this.element.addEventListener("keydown", this.handleKeydown.bind(this));

    // Close on click outside
    document.addEventListener("click", this.handleClickOutside.bind(this));

    // Set up parent dropdown items to handle submenus
    this.setupSubmenus();
  }

  disconnect() {
    document.removeEventListener("click", this.handleClickOutside.bind(this));
  }

  handleHover(show) {
    if (show) {
      this.menuTarget.classList.add("show");
      this.buttonTarget.classList.add("active");
      this.buttonTarget.setAttribute("aria-expanded", "true");
    } else {
      this.menuTarget.classList.remove("show");
      this.buttonTarget.classList.remove("active");
      this.buttonTarget.setAttribute("aria-expanded", "false");
    }
  }

  toggle(event) {
    event.preventDefault();
    event.stopPropagation();

    if (this.isOpen) {
      this.menuTarget.classList.remove("show");
    } else {
      this.menuTarget.classList.add("show");
    }
  }

  show() {
    const menuElement = this.element.querySelector(".w-button-dropdown-menu");
    const buttonElement = this.element.querySelector(
      "[data-dropdown-target='button']"
    );

    this.updatePosition();
    menuElement.classList.add("show");
    buttonElement.classList.add("active");
    buttonElement.setAttribute("aria-expanded", "true");

    // Apply position and alignment
    menuElement.dataset.position = this.positionValue || "bottom";
    menuElement.dataset.align = this.alignValue || "start";

    // Focus first menu item
    const firstItem = menuElement.querySelector(".w-button-dropdown-item");
    if (firstItem) firstItem.focus();
  }

  hide() {
    const menuElement = this.element.querySelector(".w-button-dropdown-menu");
    const buttonElement = this.element.querySelector(
      "[data-dropdown-target='button']"
    );

    menuElement.classList.remove("show");
    buttonElement.classList.remove("active");
    buttonElement.setAttribute("aria-expanded", "false");
  }

  handleClickOutside(event) {
    if (!this.element.contains(event.target)) {
      console.log("Click outside detected. Closing all dropdowns.");
      this.closeAllSubmenus();
      this.hide(); // Close the main dropdown
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
        case "ArrowRight":
          this.openSubmenu(event.target);
          break;
        case "ArrowLeft":
          this.closeSubmenu(event.target);
          break;
        case "Tab":
          this.hide();
          break;
      }
    }
  }

  setupSubmenus() {
    this.element
      .querySelectorAll(".w-button-dropdown-parent")
      .forEach((parent) => {
        const submenu = parent.querySelector(".w-button-dropdown-menu");
        const arrow = parent.querySelector(".w-button-dropdown-arrow");

        if (!submenu) {
          return;
        }

        // Determine the trigger (hover or click)
        const trigger =
          parent.closest(".w-button-wrapper")?.dataset.dropdownTriggerValue ||
          "click";

        if (trigger === "hover") {
          parent.addEventListener("mouseenter", () => {
            this.showSubmenu(submenu, arrow);
          });
          parent.addEventListener("mouseleave", () => {
            this.hideSubmenu(submenu, arrow);
          });
        } else if (trigger === "click") {
          parent.addEventListener("click", (event) => {
            event.stopPropagation(); // Prevent closing parent dropdown
            this.toggleSubmenu(submenu, arrow);
          });

          // Close the submenu when clicking outside
          document.addEventListener("click", (event) => {
            if (!parent.contains(event.target)) {
              this.hideSubmenu(submenu, arrow);
            }
          });
        }
      });
  }

  toggleSubmenu(submenu, arrow) {
    if (submenu.classList.contains("show")) {
      this.hideSubmenu(submenu, arrow);
    } else {
      this.showSubmenu(submenu, arrow);
    }
  }

  showSubmenu(submenu, arrow) {
    submenu.classList.add("show");
    submenu.setAttribute("aria-expanded", "true");

    // Rotate arrow if present
    if (arrow) {
      arrow.classList.add("active");
    }
  }

  hideSubmenu(submenu, arrow) {
    submenu.classList.remove("show");
    submenu.setAttribute("aria-expanded", "false");

    // Reset arrow rotation if present
    if (arrow) {
      arrow.classList.remove("active");
    }
  }

  isParentOpen(parent) {
    const parentMenu = parent.closest(".w-button-dropdown-menu");
    return parentMenu && parentMenu.classList.contains("show");
  }

  closeAllSubmenus() {
    this.element
      .querySelectorAll(".w-button-dropdown-menu.show")
      .forEach((menu) => {
        menu.classList.remove("show");
        menu.setAttribute("aria-expanded", "false");
      });
  }

  openSubmenu(parentItem) {
    const submenu = parentItem.querySelector(".w-button-dropdown-menu");
    if (submenu) {
      this.showSubmenu(submenu);
      submenu.querySelector(".w-button-dropdown-item").focus();
    }
  }

  closeSubmenu(parentItem) {
    const submenu = parentItem.closest(".w-button-dropdown-menu");
    if (submenu) {
      this.hideSubmenu(submenu);
      parentItem.closest(".w-button-dropdown-parent").focus();
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
    const menuElement = this.element.querySelector(".w-button-dropdown-menu");
    const position = this.hasPositionValue ? this.positionValue : "bottom";
    const align = this.hasAlignValue ? this.alignValue : "start";

    menuElement.setAttribute("data-position", position);
    menuElement.setAttribute("data-align", align);
  }

  get isOpen() {
    return this.menuTarget.classList.contains("show");
  }
}
