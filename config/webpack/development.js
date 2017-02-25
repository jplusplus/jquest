// Note: You must restart bin/webpack-watcher for changes to take effect

const webpack = require('webpack')
const merge   = require('webpack-merge')

const sharedConfig = require('./shared.js')

module.exports = function(env) {
  return merge(sharedConfig(env), {
    devtool: 'sourcemap',
    stats: {
      errorDetails: true
    },
    output: {
      pathinfo: true
    },
    plugins: [
      new webpack.LoaderOptionsPlugin({
        debug: true
      })
    ]
  });
};
