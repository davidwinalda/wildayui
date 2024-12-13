import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    console.log("Button base controller connected");
    // Handle disabled state
    if (this.element.disabled) {
      this.element.style.pointerEvents = "none";
    }
  }

  click(event) {
    console.log("Button base controller click");
    // Prevent click if disabled
    if (this.element.disabled) {
      event.preventDefault();
      return;
    }
  }
}
