import { Application } from "@hotwired/stimulus";
import ButtonController from "./button_controller";

// Initialize Stimulus
const application = Application.start();
window.Stimulus = application;

// Register the button controller
application.register("button", ButtonController);

// Debug check to ensure Stimulus is loaded
if (window.Stimulus) {
  console.log("✅ Stimulus is loaded and initialized.");
} else {
  console.error("❌ Stimulus failed to load.");
}
