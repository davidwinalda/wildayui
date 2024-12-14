import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["button", "menu", "submenu"];
  static values = {
    trigger: { type: String, default: "click" },
    position: { type: String, default: "bottom" },
    align: { type: String, default: "start" },
  };

  connect() {
    console.log("Dropdown controller connected:", this.element);
    console.log("Menu Target:", this.menuTarget);
    console.log("Button Target:", this.buttonTarget);

    console.log("Initial position value:", this.positionValue);
    console.log("Initial align value:", this.alignValue);

    // Check if targets are accessible
    if (this.menuTarget) {
      console.log("Menu Target Found:", this.menuTarget);
    } else {
      console.error("Menu Target Missing");
    }

    if (this.buttonTarget) {
      console.log("Button Target Found:", this.buttonTarget);
    } else {
      console.error("Button Target Missing");
    }

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

    // Set up parent dropdown items to handle submenus
    this.setupSubmenus();
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
    console.log("Setting up submenus...");

    this.element
      .querySelectorAll(".w-button-dropdown-parent")
      .forEach((parent) => {
        const submenu = parent.querySelector(".w-button-dropdown-menu");
        const arrow = parent.querySelector(".w-button-dropdown-arrow");

        if (!submenu) {
          console.warn("No submenu found for parent:", parent);
          return;
        }

        console.log("Submenu found for parent:", parent);

        // Determine the trigger (hover or click)
        const trigger =
          parent.closest(".w-button-wrapper")?.dataset.dropdownTriggerValue ||
          "click";

        if (trigger === "hover") {
          parent.addEventListener("mouseenter", () => {
            console.log("Hovering over parent:", parent);
            this.showSubmenu(submenu, arrow);
          });
          parent.addEventListener("mouseleave", () => {
            console.log("Leaving parent:", parent);
            this.hideSubmenu(submenu, arrow);
          });
        } else if (trigger === "click") {
          parent.addEventListener("click", (event) => {
            event.stopPropagation(); // Prevent closing parent dropdown
            console.log("Click event on parent:", parent);
            this.toggleSubmenu(submenu, arrow);
          });

          // Close the submenu when clicking outside
          document.addEventListener("click", (event) => {
            if (!parent.contains(event.target)) {
              console.log("Click outside detected");
              this.hideSubmenu(submenu, arrow);
            }
          });
        }
      });
  }

  toggleSubmenu(submenu, arrow) {
    console.log("Toggling submenu:", submenu);
    if (submenu.classList.contains("show")) {
      this.hideSubmenu(submenu, arrow);
    } else {
      this.showSubmenu(submenu, arrow);
    }
  }

  showSubmenu(submenu, arrow) {
    console.log("Showing submenu:", submenu);
    submenu.classList.add("show");
    submenu.setAttribute("aria-expanded", "true");

    // Rotate arrow if present
    if (arrow) {
      arrow.classList.add("active");
    }
  }

  hideSubmenu(submenu, arrow) {
    console.log("Hiding submenu:", submenu);
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

  // showSubmenu(submenu) {
  //   console.log("Showing submenu:", submenu);

  //   // Log the inner HTML of the submenu
  //   console.log("Submenu innerHTML:", submenu.innerHTML);
  //   submenu.classList.add("show");
  //   submenu.setAttribute("aria-expanded", "true");

  //   // Log computed styles for debugging
  //   const styles = window.getComputedStyle(submenu);
  //   console.log("Submenu styles:", {
  //     display: styles.display,
  //     visibility: styles.visibility,
  //     position: styles.position,
  //     top: styles.top,
  //     left: styles.left,
  //     zIndex: styles.zIndex,
  //   });

  //   // Debug bounding box
  //   const boundingBox = submenu.getBoundingClientRect();
  //   console.log("Submenu bounding box:", boundingBox);
  // }

  // hideSubmenu(submenu) {
  //   console.log("Hiding submenu:", submenu);
  //   submenu.classList.remove("show");
  //   submenu.setAttribute("aria-expanded", "false");
  // }

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
    const position = this.hasPositionValue ? this.positionValue : "bottom";
    const align = this.hasAlignValue ? this.alignValue : "start";

    console.log("Dropdown Update Position Triggered");
    console.log("Dropdown position value:", position);
    console.log("Dropdown align value:", align);

    this.menuTarget.setAttribute("data-position", position);
    this.menuTarget.setAttribute("data-align", align);

    console.log(
      "Dropdown menu current styles:",
      window.getComputedStyle(this.menuTarget)
    );
  }

  get isOpen() {
    return this.menuTarget.classList.contains("show");
  }
}
