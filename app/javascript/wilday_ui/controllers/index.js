import { Application } from "@hotwired/stimulus";
import ButtonController from "./button_controller";
import DropdownController from "./dropdown_controller";
import ClipboardController from "./clipboard_controller";
// Initialize Stimulus
const application = Application.start();
window.Stimulus = application;

// Register the button controller
application.register("button", ButtonController);
application.register("dropdown", DropdownController);
application.register("clipboard", ClipboardController);
// Debug check to ensure Stimulus is loaded
// if (window.Stimulus) {
//   console.log("✅ Stimulus is loaded and initialized.");
// } else {
//   console.error("❌ Stimulus failed to load.");
// }
