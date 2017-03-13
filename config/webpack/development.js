/* eslint global-require: 0 */
// Note: You must restart bin/webpack-watcher for changes to take effect

const webpack = require('webpack');
const merge = require('webpack-merge');
const sharedConfig = require('./shared.js').config;
const { webpacker } = require('../../package.json');

module.exports = function(env) {
  let config = sharedConfig(env);

  if (webpacker.assets) {
    config = merge(config, require('./assets.js'));
  }

  return merge(config, {
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
