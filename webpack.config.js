const path = require("path");

module.exports = [
  {
    entry: './src/button.js',
    output: {
      path: path.resolve(__dirname, "dist"),
      filename: "mdc-button.min.js"
    },
    module: {
      rules: [
        { test: /\.js$/, exclude: /node_modules/, loader: "babel-loader" }
      ]
    }
  },
  {
    entry: './src/checkbox.js',
    output: {
      path: path.resolve(__dirname, "dist"),
      filename: "mdc-checkbox.min.js"
    },
    module: {
      rules: [
        { test: /\.js$/, exclude: /node_modules/, loader: "babel-loader" }
      ]
    }
  },
  {
    entry: './src/chip-set.js',
    output: {
      path: path.resolve(__dirname, "dist"),
      filename: "mdc-chip-set.min.js"
    },
    module: {
      rules: [
        { test: /\.js$/, exclude: /node_modules/, loader: "babel-loader" }
      ]
    }
  },
  {
    entry: './src/chip.js',
    output: {
      path: path.resolve(__dirname, "dist"),
      filename: "mdc-chip.min.js"
    },
    module: {
      rules: [
        { test: /\.js$/, exclude: /node_modules/, loader: "babel-loader" }
      ]
    }
  },
  {
    entry: './src/dialog.js',
    output: {
      path: path.resolve(__dirname, "dist"),
      filename: "mdc-dialog.min.js"
    },
    module: {
      rules: [
        { test: /\.js$/, exclude: /node_modules/, loader: "babel-loader" }
      ]
    }
  }
];
