import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["content"];
  static values = {
    text: String,
    position: { type: String, default: "top" },
  };

  connect() {
    this.element.addEventListener("mouseenter", () => this.show());
    this.element.addEventListener("mouseleave", () => this.hide());
  }

  show() {
    this.contentTarget.classList.add("show");
  }

  hide() {
    this.contentTarget.classList.remove("show");
  }
}
