import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    console.log("AnimationController connected");
    this.setupAnimation();
  }

  setupAnimation() {
    const animationData = JSON.parse(this.element.dataset.animation || "{}");
    if (!animationData.name) return;

    const {
      name,
      trigger,
      duration = 0.3,
      timing = "ease",
      delay = 0, // Add default value here
      iteration = 1,
      direction = "normal",
      fill_mode = "none",
      properties,
    } = animationData;

    // Set up CSS custom properties
    this.element.style.setProperty("--animation-name", name);
    this.element.style.setProperty("--animation-duration", `${duration}s`);
    this.element.style.setProperty("--animation-delay", `${delay}s`); // This will now be "0s" instead of "undefineds"
    this.element.style.setProperty(
      "--animation-timing",
      this.getTimingFunction(timing, properties)
    );
    this.element.style.setProperty(
      "--animation-iteration",
      iteration === "infinite" ? "infinite" : iteration || 1
    );
    this.element.style.setProperty(
      "--animation-direction",
      direction.replace(/_/g, "-")
    );
    this.element.style.setProperty(
      "--animation-fill-mode",
      fill_mode.replace(/_/g, "-")
    );

    // Handle custom properties
    if (properties && name === "custom") {
      Object.entries(properties).forEach(([key, value]) => {
        this.element.style.setProperty(`--animation-custom-${key}`, value);
      });
    }

    if (trigger === "click") {
      this.element.addEventListener("click", () => this.animate());
    } else if (trigger === "load") {
      this.animate();
    }
  }

  animate() {
    const animationData = JSON.parse(this.element.dataset.animation || "{}");
    if (!animationData.name) return;

    // Remove existing animation class to allow re-triggering
    this.element.classList.remove("is-animating");
    // Force a reflow to ensure the animation runs again
    void this.element.offsetWidth;
    // Add animation class
    this.element.classList.add("is-animating");
  }

  getTimingFunction(timing, properties) {
    if (!timing) return "ease";

    if (timing === "cubic_bezier" && properties?.cubic_bezier) {
      const [x1, y1, x2, y2] = properties.cubic_bezier;
      return `cubic-bezier(${x1}, ${y1}, ${x2}, ${y2})`;
    }
    return timing.replace(/_/g, "-");
  }

  disableAfterAnimation() {
    const animationConfig = JSON.parse(this.element.dataset.animation || "{}");
    if (!animationConfig.disabled) return; // Only disable if config says so

    const duration =
      parseFloat(this.element.style.getPropertyValue("--animation-duration")) *
      1000;
    const delay =
      parseFloat(this.element.style.getPropertyValue("--animation-delay")) *
      1000;

    setTimeout(() => {
      this.element.disabled = true;
    }, duration + delay);
  }
}
