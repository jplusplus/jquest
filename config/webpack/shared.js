// Note: You must restart bin/webpack-watcher for changes to take effect
const webpack = require('webpack')
const path = require('path')
const process = require('process')
const glob = require('glob')
const extname = require('path-complete-extname')
const ManifestPlugin = require('webpack-manifest-plugin')
const ExtractTextPlugin = require('extract-text-webpack-plugin')

const { dev_server, env, paths, publicPath, production } = require('./configuration.js')

module.exports = function(env) {
  const entries = env.entries.split(',').reduce(function(map, dir) {
    // Pattern to find entry for this dir
    const needle = path.join(dir, paths.src_path, 'packs', '**', 'index?(-lite).js*');
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
    output: { filename: '[name].js', path: path.resolve(paths.dist_path) },
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
        },
        {
          test: /\.coffee(.erb)?$/,
          loader: [
            'ng-annotate-loader',
            'coffee-loader'
          ]
        },
        {
          test: /\.js(.erb)?$/,
          exclude: /node_modules/,
          loader: [
            'ng-annotate-loader',
            'babel-loader'
          ]
        },
        {
          test: /\.scss?$/,
          loaders: ExtractTextPlugin.extract({
            fallback: 'style-loader',
            loader: [
              'css-loader',
              'sass-loader',
              'import-glob-loader'
            ]
          })
        },
        {
          test: /\.(jpeg|jpg|png|gif|svg|eot|svg|ttf|woff|woff2)$/i,
          use: [{
            loader: 'file-loader',
            options: {
              name: production ? '[name]-[hash].[ext]' : '[name].[ext]',
              publicPath
            }
          }]
        }
      ]
    },

    plugins: [
      new webpack.EnvironmentPlugin({
        // use 'development' unless process.env.NODE_ENV is defined
        NODE_ENV: 'development'
      }),
      new ExtractTextPlugin(production ? '[name]-[hash].css' : '[name].css'),
      new ManifestPlugin({
        fileName: 'manifest.json',
        publicPath: `/${paths.dist_dir}/`
      })
    ],

    resolve: {
      extensions: [ '.js', '.coffee' ],
      modules: [
        path.resolve(paths.src_path),
        path.resolve(paths.node_modules_path)
      ],
      alias: {
        bootstrap: path.resolve(paths.src_path, 'packs/components/bootstrap/'),
        utils: path.resolve(paths.src_path, 'packs/components/utils/'),
        images: path.resolve(paths.src_path, 'packs/images/')
      }
    },

    resolveLoader: {
      modules: [ path.resolve(paths.node_modules_path) ]
    }
  };
};
