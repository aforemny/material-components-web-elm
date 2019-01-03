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
  },
  {
    entry: './src/fab.js',
    output: {
      path: path.resolve(__dirname, "dist"),
      filename: "mdc-fab.min.js"
    },
    module: {
      rules: [
        { test: /\.js$/, exclude: /node_modules/, loader: "babel-loader" }
      ]
    }
  },
  {
    entry: './src/form-field.js',
    output: {
      path: path.resolve(__dirname, "dist"),
      filename: "mdc-form-field.min.js"
    },
    module: {
      rules: [
        { test: /\.js$/, exclude: /node_modules/, loader: "babel-loader" }
      ]
    }
  },
  {
    entry: './src/list.js',
    output: {
      path: path.resolve(__dirname, "dist"),
      filename: "mdc-list-progress.min.js"
    },
    module: {
      rules: [
        { test: /\.js$/, exclude: /node_modules/, loader: "babel-loader" }
      ]
    }
  },
  {
    entry: './src/linear-progress.js',
    output: {
      path: path.resolve(__dirname, "dist"),
      filename: "mdc-linear-progress.min.js"
    },
    module: {
      rules: [
        { test: /\.js$/, exclude: /node_modules/, loader: "babel-loader" }
      ]
    }
  },
  {
    entry: './src/menu.js',
    output: {
      path: path.resolve(__dirname, "dist"),
      filename: "mdc-menu.min.js"
    },
    module: {
      rules: [
        { test: /\.js$/, exclude: /node_modules/, loader: "babel-loader" }
      ]
    }
  },
  {
    entry: './src/radio.js',
    output: {
      path: path.resolve(__dirname, "dist"),
      filename: "mdc-radio.min.js"
    },
    module: {
      rules: [
        { test: /\.js$/, exclude: /node_modules/, loader: "babel-loader" }
      ]
    }
  },
  {
    entry: './src/ripple.js',
    output: {
      path: path.resolve(__dirname, "dist"),
      filename: "mdc-ripple.min.js"
    },
    module: {
      rules: [
        { test: /\.js$/, exclude: /node_modules/, loader: "babel-loader" }
      ]
    }
  },
  {
    entry: './src/select.js',
    output: {
      path: path.resolve(__dirname, "dist"),
      filename: "mdc-select.min.js"
    },
    module: {
      rules: [
        { test: /\.js$/, exclude: /node_modules/, loader: "babel-loader" }
      ]
    }
  },
  {
    entry: './src/slider.js',
    output: {
      path: path.resolve(__dirname, "dist"),
      filename: "mdc-slider.min.js"
    },
    module: {
      rules: [
        { test: /\.js$/, exclude: /node_modules/, loader: "babel-loader" }
      ]
    }
  },
  {
    entry: './src/snackbar.js',
    output: {
      path: path.resolve(__dirname, "dist"),
      filename: "mdc-snackbar.min.js"
    },
    module: {
      rules: [
        { test: /\.js$/, exclude: /node_modules/, loader: "babel-loader" }
      ]
    }
  },
  {
    entry: './src/switch.js',
    output: {
      path: path.resolve(__dirname, "dist"),
      filename: "mdc-switch.min.js"
    },
    module: {
      rules: [
        { test: /\.js$/, exclude: /node_modules/, loader: "babel-loader" }
      ]
    }
  }
];
