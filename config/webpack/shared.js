// Note: You must restart bin/webpack-watcher for changes to take effect

const webpack = require('webpack')
const path = require('path')
const process = require('process')
const glob = require('glob')
const extname = require('path-complete-extname')
const distDir = process.env.WEBPACK_DIST_DIR || 'packs';

module.exports = function(env) {
  const entries = env.entries.split(',').reduce(function(map, dir) {
    // Pattern to find entry for this dir
    const needle = path.join(dir, 'app', 'javascript', 'packs', '**', 'index.js*');
    // Iterates over every file match within the current dir
    glob.sync(needle).forEach(function(entry) {
      const basename = path.basename(entry, extname(entry));
      const parent = path.basename(path.dirname(entry));
      const name = parent === 'packs' ? basename : parent + '/' + basename;
      map[name] = path.resolve(entry);
    }, {});
    return map;
  }, {});

  return {
    entry: entries,
    output: { filename: '[name].js', path: path.resolve('public', distDir) },
    module: {
      rules: [
        {
          test: /\.coffee(.erb)?$/,
          loader: "coffee-loader"
        },
        {
          test: /\.js(.erb)?$/,
          exclude: /node_modules/,
          loader: 'babel-loader',
          options: {
            presets: [
              [ 'latest', { 'es2015': { 'modules': false } } ]
            ]
          }
        },
        {
          test: /\.erb$/,
          enforce: 'pre',
          exclude: /node_modules/,
          loader: 'rails-erb-loader',
          options: {
            runner: 'bin/rails runner'
          }
        },
        {
          test: /\.html(.erb)?$/,
          loaders: [
            'html-loader'
          ]
        },
        {
          test: /\.scss(.erb)?$/,
          loader: [
            'style-loader',
            'css-loader',
            'sass-loader',
            'import-glob-loader'
          ]
        },
      ]
    },

    plugins: [
      new webpack.EnvironmentPlugin(Object.keys(process.env))
    ],

    resolve: {
      extensions: [ '.js', '.coffee' ],
      modules: [
        path.resolve('app/javascript'),
        path.resolve('node_modules')
      ]
    },

    resolveLoader: {
      modules: [ path.resolve('node_modules') ]
    }
  };
};
