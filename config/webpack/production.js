/* eslint global-require: 0 */
// Note: You must run bin/webpack for changes to take effect

const webpack = require('webpack');
const merge = require('webpack-merge');
const CompressionPlugin = require('compression-webpack-plugin');
const sharedConfig = require('./shared.js').config;
const { webpacker } = require('../../package.json');

module.exports = function(env) {
  let config = sharedConfig(env);

  if (webpacker.assets) {
    config = merge(config, require('./assets.js'));
  }

  return merge(config, {
    output: { filename: '[name]-[chunkhash].js' },
    plugins: [
      new webpack.optimize.UglifyJsPlugin(),
      new CompressionPlugin({
        asset: '[path].gz[query]',
        algorithm: 'gzip',
        test: /\.(js|css|svg|eot|ttf|woff|woff2)$/
      })
    ]
  });
};
