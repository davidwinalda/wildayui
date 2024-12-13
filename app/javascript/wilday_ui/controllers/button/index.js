import { Application } from "@hotwired/stimulus";
import BaseController from "./base_controller";
import LoadingController from "./features/loading";
import DropdownController from "./features/dropdown";
import TooltipController from "./features/tooltip";

// Initialize Stimulus
const application = Application.start();
window.Stimulus = application;

// Register all button-related controllers
application.register("button", BaseController);
application.register("button-loading", LoadingController);
application.register("button-dropdown", DropdownController);
application.register("button-tooltip", TooltipController);

// Debug check
if (window.Stimulus) {
  console.log("✅ Button controllers registered");
} else {
  console.error("❌ Failed to register button controllers");
}
