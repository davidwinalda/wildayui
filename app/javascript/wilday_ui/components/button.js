document.addEventListener("DOMContentLoaded", () => {
  console.log("Button component loaded heah");
  document.querySelectorAll(".w-button").forEach((button) => {
    button.addEventListener("click", (event) => {
      if (button.disabled) {
        event.preventDefault();
        return;
      }
    });
  });
});
