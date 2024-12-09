const esbuild = require("esbuild");

const options = {
  entryPoints: ["app/javascript/wilday_ui/index.js"],
  bundle: true,
  outdir: "app/assets/builds",
  sourcemap: process.env.NODE_ENV === "development",
  minify: process.env.NODE_ENV === "production",
};

// Check if running in watch mode
if (process.env.NODE_ENV === "development") {
  esbuild
    .context(options)
    .then((ctx) => {
      ctx.watch().then(() => {
        console.log("Watching for changes...");
      });
    })
    .catch((error) => {
      console.error("Error during build:", error);
      process.exit(1);
    });
} else {
  // Build in production mode
  esbuild.build(options).catch((error) => {
    console.error("Error during build:", error);
    process.exit(1);
  });
}
