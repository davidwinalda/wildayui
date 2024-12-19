import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["button", "feedback"];
  static values = {
    text: String,
    feedbackText: { type: String, default: "Copied!" },
    feedbackPosition: { type: String, default: "top" },
    feedbackDuration: { type: Number, default: 2000 },
  };

  connect() {
    // Optional: Initialize any necessary setup
  }

  async copy(event) {
    event.preventDefault();

    try {
      await navigator.clipboard.writeText(this.textValue);
      this.showFeedback();
    } catch (err) {
      console.error("Failed to copy text:", err);
      // Fallback for older browsers
      this.fallbackCopy();
    }
  }

  fallbackCopy() {
    const textArea = document.createElement("textarea");
    textArea.value = this.textValue;
    textArea.style.position = "fixed";
    textArea.style.left = "-9999px";
    document.body.appendChild(textArea);
    textArea.select();

    try {
      document.execCommand("copy");
      this.showFeedback();
    } catch (err) {
      console.error("Fallback: Oops, unable to copy", err);
    }

    document.body.removeChild(textArea);
  }

  showFeedback() {
    const feedback = this.hasFeedbackTarget
      ? this.feedbackTarget
      : this.createFeedbackElement();
    feedback.textContent = this.feedbackTextValue;

    // Remove any existing position classes
    feedback.className = "w-button-feedback";

    // Add position-specific classes
    const positionClasses = this.feedbackPositionValue.split("-");
    positionClasses.forEach((pos) => {
      feedback.classList.add(`w-button-feedback-${pos}`);
    });

    feedback.classList.add("w-button-feedback-show");

    setTimeout(() => {
      feedback.classList.remove("w-button-feedback-show");
    }, this.feedbackDurationValue);
  }

  createFeedbackElement() {
    const feedback = document.createElement("div");
    feedback.classList.add("w-button-feedback");
    feedback.setAttribute("data-clipboard-target", "feedback");
    this.element.appendChild(feedback);
    return feedback;
  }
}
