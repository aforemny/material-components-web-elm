const path = require("path");

module.exports = {
  entry: './src/button.js',
  mode: "development", // TODO
  output: {
    path: path.resolve(__dirname, "dist"),
    filename: "mdc-button.min.js"
  },
  module: {
    rules: [
      { test: /\.js$/, exclude: /node_modules/, loader: "babel-loader" }
    ]
  }
};
