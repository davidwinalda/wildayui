import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = {
    buttonLoadingText: String,
  };

  connect() {
    // Store original content and classes
    this.originalContent = this.element.innerHTML;
    this.originalClasses = this.element.className;

    // Log exactly matching the debug output format
    console.log("🔵 Loading Controller connected:", {
      element: this.element.className,
      hasText: false,
      text: null,
      dataset: this.element.dataset,
    });

    // Check for initial loading state
    if (this.element.dataset.loading === "true") {
      requestAnimationFrame(() => this.startLoading());
    }
  }

  toggle(event) {
    if (event) event.preventDefault();
    if (this.element.hasAttribute("aria-busy")) return;

    this.startLoading();

    setTimeout(() => {
      this.stopLoading();
    }, 2000);
  }

  startLoading() {
    this.element.setAttribute("aria-busy", "true");
    this.element.disabled = true;

    // Preserve original classes
    const loadingText = this.buttonLoadingTextValue;

    this.element.innerHTML = `
      <span class="w-button-spinner"></span>
      <span class="w-button-content">${loadingText}</span>
    `;
  }

  stopLoading() {
    this.element.removeAttribute("aria-busy");
    this.element.disabled = false;
    this.element.innerHTML = this.originalContent;
  }
}
