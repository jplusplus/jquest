// Note: You must restart bin/webpack-watcher for changes to take effect

const webpack = require('webpack')
const path = require('path')
const process = require('process')
const glob = require('glob')
const extname = require('path-complete-extname')
const { webpacker, devServer } = require('../../package.json')
const distDir = process.env.WEBPACK_DIST_DIR || webpacker.distDir || 'packs';
const srcPath = webpacker.srcPath;
const distPath = webpacker.distPath;
const nodeModulesPath = webpacker.nodeModulesPath
const digestFileName = webpacker.digestFileName

const config = function(env) {
  const entries = env.entries.split(',').reduce(function(map, dir) {
    // Pattern to find entry for this dir
    const needle = path.join(dir, srcPath, 'packs', '**', 'index.js*');
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
    output: { filename: '[name].js', path: path.resolve(distPath) },
    module: {
      rules: [
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
        }
      ]
    },

    plugins: [
      new webpack.EnvironmentPlugin(Object.keys(process.env))
    ],

    resolve: {
      extensions: [ '.js', '.coffee' ],
      modules: [
        path.resolve(srcPath),
        path.resolve(nodeModulesPath)
      ],
      alias: {
        bootstrap: path.resolve(srcPath, 'packs/components/bootstrap/'),
        utils: path.resolve(srcPath, 'packs/components/utils/')
      }
    },

    resolveLoader: {
      modules: [ path.resolve(nodeModulesPath) ]
    }
  };
};

module.exports = {
  srcPath,
  distDir,
  distPath,
  nodeModulesPath,
  config
}
