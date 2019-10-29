const path = require("path");

module.exports =
  [
    /*
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
    */
    "material-components-web-elm",
  ].map(name => ({
    entry: `./src/${name}.js`,
    output: {
      path: path.resolve(__dirname, "dist"),
      filename: name === "material-components-web-elm"
        ? `${name}.min.js`
        : `mdc-${name}.min.js`
    },
    module: {
      rules: [
        { test: /\.js$/, exclude: /node_modules/, loader: "babel-loader" },
        { test: /\.ts$/, exclude: /node_modules/, loader: "ts-loader" }
      ]
    }
  }));
