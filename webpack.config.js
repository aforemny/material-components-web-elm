const path = require("path");
const UglifyJsPlugin = require("uglifyjs-webpack-plugin");

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
    entry: {
      [`${name}`]: `./src/${name}.js`,
      [`${name}.min`]: `./src/${name}.js`
    },
    devtool: "source-map",
    output: {
      path: path.resolve(__dirname, "dist"),
      filename: name === "material-components-web-elm" ? `[name].js` : `mdc-[name].js`
    },
    module: {
      rules: [
        { test: /\.js$/, exclude: /node_modules/, loader: "babel-loader" },
        { test: /\.ts$/, exclude: /node_modules/, loader: "ts-loader" }
      ]
    },
    optimization: {
      minimize: true,
      minimizer: [new UglifyJsPlugin({
        include: /\.min\.js$/,
        sourceMap: true
      })]
    },
  }));
