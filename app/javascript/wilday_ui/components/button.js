document.addEventListener("DOMContentLoaded", () => {
  document.querySelectorAll(".w-button").forEach((button) => {
    button.addEventListener("click", (event) => {
      if (button.disabled) {
        event.preventDefault();
      }
    });
  });
});
