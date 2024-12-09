(() => {
  // app/javascript/wilday_ui/components/button.js
  document.addEventListener("DOMContentLoaded", () => {
    document.querySelectorAll(".w-button").forEach((button) => {
      button.addEventListener("click", (event) => {
        if (button.disabled) {
          event.preventDefault();
        }
      });
    });
  });
})();
//# sourceMappingURL=index.js.map
