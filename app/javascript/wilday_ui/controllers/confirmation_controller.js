import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["dialog", "confirmButton", "cancelButton"];
  static values = {
    title: String,
    message: String,
    iconColor: String,
    confirmText: String,
    cancelText: String,
    confirmStyles: String,
    cancelStyles: String,
  };

  // Store the original event to be used later
  originalEvent = null;

  connect() {
    // Create and append dialog if it doesn't exist
    if (!this.hasDialogTarget) {
      this.element.insertAdjacentHTML("beforeend", this.dialogHTML);
    }
  }

  disconnect() {
    this.originalEvent = null;
    this.isConfirmed = false;
  }

  showDialog(event) {
    // Don't show dialog if already confirmed
    if (this.isConfirmed) {
      this.isConfirmed = false;
      return;
    }

    // console.log("Show dialog triggered", event);
    event.preventDefault();
    // Store the original event and element
    this.originalEvent = {
      type: event.type,
      element: event.currentTarget,
      ctrlKey: event.ctrlKey,
      metaKey: event.metaKey,
    };
    // console.log("Original event stored:", this.originalEvent);
    this.dialogTarget.showModal();
    this.focusConfirmButton();
  }

  confirm(event) {
    // console.log("Confirm clicked");
    event.preventDefault();
    this.dialogTarget.close();

    if (this.originalEvent?.element) {
      const element = this.originalEvent.element;
      // console.log("Processing element:", element);

      // Let Turbo handle its own elements
      if (
        this.hasTurbo &&
        !element.hasAttribute("data-turbo") &&
        !element.hasAttribute("data-turbo-method")
      ) {
        this.resumeOriginalEvent();
        return;
      }

      // Dispatch standard DOM custom event
      const confirmEvent = new CustomEvent("confirm", {
        bubbles: true,
        cancelable: true,
        detail: {
          element: element,
          originalEvent: this.originalEvent,
        },
      });

      const wasHandled = !element.dispatchEvent(confirmEvent);
      if (wasHandled) return;

      // If not handled by custom event, resume original event
      this.resumeOriginalEvent();
    }
  }

  resumeOriginalEvent() {
    if (!this.originalEvent) return;

    const element = this.originalEvent.element;
    // console.log("Resuming original event for:", element);

    // Set flag before triggering the event
    this.isConfirmed = true;

    // Handle form submissions
    if (element.closest("form")) {
      const form = element.closest("form");
      // console.log("Submitting form:", form);
      const submitEvent = new Event("submit", {
        bubbles: true,
        cancelable: true,
      });
      form.dispatchEvent(submitEvent); // This will trigger the event listener
      this.originalEvent = null;
      return;
    }

    // Handle links
    if (element.tagName === "A" || element.hasAttribute("href")) {
      // console.log("Processing link click");
      const click = new MouseEvent("click", {
        bubbles: true,
        cancelable: true,
        ctrlKey: this.originalEvent.ctrlKey,
        metaKey: this.originalEvent.metaKey,
      });
      element.dispatchEvent(click);
      this.originalEvent = null;
      return;
    }

    // Handle regular button click
    if (
      !element.closest("form") &&
      !(element.tagName === "A" || element.hasAttribute("href"))
    ) {
      // console.log("Processing button click");
      element.click();
      this.originalEvent = null;
      return;
    }
  }

  cancel(event) {
    event.preventDefault();
    this.closeDialog();
  }

  closeDialog() {
    this.dialogTarget.close();
    this.originalEvent = null;
  }

  handleKeydown(event) {
    if (event.key === "Escape") {
      this.cancel(event);
    }
  }

  handleClickOutside(event) {
    if (event.target === this.dialogTarget) {
      this.cancel(event);
    }
  }

  focusConfirmButton() {
    this.confirmButtonTarget.focus();
  }

  get hasTurbo() {
    return typeof Turbo !== "undefined";
  }

  get dialogHTML() {
    return `
      <dialog class="w-button-confirmation-dialog" 
              data-confirmation-target="dialog"
              data-action="click->confirmation#handleClickOutside keydown->confirmation#handleKeydown">
        <div class="w-button-confirmation-dialog-content">
          <div class="w-button-confirmation-dialog-icon ${this.iconColorValue}">
            ${this.iconHTML}
          </div>
  
          <h3 class="w-button-confirmation-dialog-title">
            ${this.titleValue}
          </h3>
  
          <div class="w-button-confirmation-dialog-message">
            ${this.messageValue}
          </div>
  
          <div class="w-button-confirmation-dialog-actions">
            <button data-confirmation-target="cancelButton"
                    data-action="click->confirmation#cancel"
                    class="w-button w-button-subtle w-button-medium w-button-rounded"
                    style="${this.cancelStylesValue}">
              ${this.cancelTextValue}
            </button>
  
            <button data-confirmation-target="confirmButton"
                    data-action="click->confirmation#confirm"
                    class="w-button w-button-solid w-button-medium w-button-rounded"
                    style="${this.confirmStylesValue}">
              ${this.confirmTextValue}
            </button>
          </div>
        </div>
      </dialog>
    `;
  }

  get iconHTML() {
    const icons = {
      info: '<svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" /></svg>',
      success:
        '<svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" /></svg>',
      warning:
        '<svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" /></svg>',
      danger:
        '<svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" /></svg>',
    };
    return icons[this.iconColorValue] || icons.info;
  }
}
