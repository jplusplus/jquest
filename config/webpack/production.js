// Note: You must restart bin/webpack-watcher for changes to take effect

const webpack = require('webpack')
const merge   = require('webpack-merge')

const sharedConfig = require('./shared.js')

module.exports = function(env) {
  return merge(sharedConfig(env), {
    output: { filename: '[name]-[hash].js' },
    plugins: [
      new webpack.LoaderOptionsPlugin({
        minimize: true
      })
    ]
  });
};
