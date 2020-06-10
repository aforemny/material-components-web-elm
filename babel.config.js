const presets = [[
  "@babel/env",
  {
    targets: {
      browsers: ["last 2 versions", "ie >= 11"]
    },
    useBuiltIns: "usage",
    corejs: "2",
  }
]];

module.exports = { presets };
