// const esbuild = require("esbuild");

// const watchMode = process.argv.includes("--watch");

// const options = {
//   entryPoints: ["app/javascript/wilday_ui/index.js"],
//   bundle: true,
//   outdir: "app/assets/builds/wilday_ui",
//   format: "esm",
//   globalName: "WildayUi",
//   sourcemap: process.env.NODE_ENV === "development",
//   minify: process.env.NODE_ENV === "production",
//   logLevel: "info",
//   external: ["@hotwired/stimulus"],
//   loader: {
//     ".js": "jsx",
//   },
// };

// // Stimulus setup by ensuring all controllers are loaded
// const controllers = require("path").resolve(
//   "app/javascript/wilday_ui/controllers"
// );

// // Check if running in watch mode
// // if (process.env.NODE_ENV === "development") {
// if (watchMode) {
//   esbuild
//     .context(options)
//     .then((ctx) => {
//       // Log Stimulus controller loading for debugging
//       console.log(`Loading Stimulus controllers from: ${controllers}`);
//       return ctx.watch();
//     })
//     .then(() => {
//       console.log("👀 Watching for changes...");
//     })
//     .catch((error) => {
//       console.error("Error during build:", error);
//       process.exit(1);
//     });
// } else {
//   // Build in production mode
//   esbuild
//     .build(options)
//     .then(() => {
//       console.log(
//         `Successfully bundled Stimulus controllers from: ${controllers}`
//       );
//     })
//     .catch((error) => {
//       console.error("Error during build:", error);
//       process.exit(1);
//     });
// }

const esbuild = require("esbuild");
const path = require("path");

// Check for watch mode from command line args
const watchMode = process.argv.includes("--watch");

// Define paths
const controllersPath = path.resolve("app/javascript/wilday_ui/controllers");
const entryPoint = "app/javascript/wilday_ui/index.js";
const outputDir = "app/assets/builds/wilday_ui";

// Base build options
const options = {
  entryPoints: [entryPoint],
  bundle: true,
  outdir: outputDir,
  format: "esm",
  globalName: "WildayUi",
  sourcemap: process.env.NODE_ENV === "development",
  minify: process.env.NODE_ENV === "production",
  logLevel: "info",
  loader: {
    ".js": "jsx",
  },
};

// Build function
async function build() {
  try {
    console.log("🎯 Wilday UI: Starting build process...");
    console.log(`📁 Loading controllers from: ${controllersPath}`);

    if (watchMode) {
      // Watch mode
      console.log("👀 Watching for changes...");
      console.log(`   Entry: ${entryPoint}`);
      console.log(`   Output: ${outputDir}`);
      console.log(`   Mode: ${process.env.NODE_ENV}`);

      const context = await esbuild.context(options);
      await context.watch();
    } else {
      // Production build
      console.log("🏗 Building for production...");
      const result = await esbuild.build(options);
      console.log("✅ Build completed successfully");
    }
  } catch (err) {
    console.error("❌ Build failed:", err);
    process.exit(1);
  }
}

// Execute build
build().then(() => {
  if (!watchMode) {
    console.log("🎉 Wilday UI: Build process completed");
  }
});
