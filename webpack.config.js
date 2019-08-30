const path = require("path");

module.exports =
  [
    "button",
    "card",
    "checkbox",
    "chip",
    "chip-set",
    "dialog",
    "drawer",
    "enhanced-select",
    "fab",
    "form-field",
    "icon",
    "icon-button",
    "image-list",
    "layout-grid",
    "linear-progress",
    "list",
    "list-item",
    "material-components-elm",
    "menu",
    "radio",
    "ripple",
    "select",
    "slider",
    "snackbar",
    "switch",
    "tab-bar",
    "text-field",
    "top-app-bar",
  ].map(name => ({
    entry: `./src/${name}.js`,
    output: {
      path: path.resolve(__dirname, "dist"),
      filename: name === "material-components-elm"
        ? `${name}.min.js`
        : `mdc-${name}.min.js`
    },
    module: {
      rules: [
        { test: /\.js$/, exclude: /node_modules/, loader: "babel-loader" }
      ]
    }
  }));
