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
      duration,
      timing,
      delay = 0, // Add default value here
      iteration,
      direction,
      fill_mode,
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

    if (trigger === "load") {
      this.animate();
    }
  }

  animate() {
    const animationData = JSON.parse(this.element.dataset.animation || "{}");
    if (!animationData.name) return;

    this.element.classList.add("is-animating");
  }

  getTimingFunction(timing, properties) {
    if (timing === "cubic_bezier" && properties?.cubic_bezier) {
      const [x1, y1, x2, y2] = properties.cubic_bezier;
      return `cubic-bezier(${x1}, ${y1}, ${x2}, ${y2})`;
    }
    return timing.replace(/_/g, "-");
  }
}
