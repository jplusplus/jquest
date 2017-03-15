/* eslint global-require: 0 */
// Note: You must restart bin/webpack-watcher for changes to take effect

const webpack = require('webpack');
const merge = require('webpack-merge');
const sharedConfig = require('./shared.js');
const { dev_server, publicPath } = require('./configuration.js');

module.exports = function() {
  return merge(sharedConfig(), {
    devtool: 'sourcemap',
    devServer: {
      host: dev_server.host,
      port: dev_server.port,
      compress: dev_server.compress,
      publicPath
    },
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
