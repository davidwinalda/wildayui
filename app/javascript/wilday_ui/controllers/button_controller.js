import { Controller } from "@hotwired/stimulus";

export default class ButtonController extends Controller {
  static values = {
    loadingDuration: { type: Number, default: 2000 },
  };

  initialize() {}

  connect() {}

  toggleLoading(event) {
    const button = this.element;
    const isLink = button.tagName.toLowerCase() === "a";
    const hasLoadingText = button.dataset.buttonLoadingText;

    // Always prevent default if we have loading text
    if (hasLoadingText) {
      event.preventDefault();

      if (button.disabled || button.classList.contains("w-button-loading")) {
        return;
      }

      this.startLoading(button);

      setTimeout(() => {
        this.stopLoading(button);

        // Only navigate if it's a link with href
        if (isLink && button.href) {
          window.location.href = button.href;
        }
      }, this.loadingDurationValue);
    }
  }

  startLoading(button) {
    this.originalContent = button.innerHTML;
    const loadingText = button.dataset.buttonLoadingText;

    button.classList.add("w-button-loading");
    button.setAttribute("aria-busy", "true");
    button.style.pointerEvents = "none";
    button.disabled = true;
    button.innerHTML = `<span class="w-button-spinner"></span> ${loadingText}`;
  }

  stopLoading(button) {
    button.classList.remove("w-button-loading");
    button.removeAttribute("aria-busy");
    button.style.pointerEvents = "";
    button.disabled = false;
    button.innerHTML = this.originalContent;
  }
}
