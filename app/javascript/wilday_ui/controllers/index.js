import { Application } from "@hotwired/stimulus";
import ButtonController from "./button_controller";
import DropdownController from "./dropdown_controller";
import ClipboardController from "./clipboard_controller";
import ConfirmationController from "./confirmation_controller";
import TooltipController from "./tooltip_controller";
import AnimationController from "./animation_controller";
// Initialize Stimulus
const application = Application.start();
window.Stimulus = application;

// Register the button controller
application.register("button", ButtonController);
application.register("dropdown", DropdownController);
application.register("clipboard", ClipboardController);
application.register("confirmation", ConfirmationController);
application.register("tooltip", TooltipController);
application.register("animation", AnimationController);
// Debug check to ensure Stimulus is loaded
// if (window.Stimulus) {
//   console.log("✅ Stimulus is loaded and initialized.");
// } else {
//   console.error("❌ Stimulus failed to load.");
// }
