gulp = require 'gulp'
gutil = require 'gulp-util'
webpack = require("webpack")
WebpackDevServer = require("webpack-dev-server")
webpackConfig = require("./webpack.config.js")
webpackProductionConfig = require("./webpack.production.config.js")
map = require 'map-stream'
touch = require 'touch'

# Load plugins
$ = require('gulp-load-plugins')()

gulp.task "webpack:build", (callback) ->
  # Run webpack.
  webpack webpackProductionConfig, (err, stats) ->
    throw new gutil.PluginError("webpack:build", err)  if err
    gutil.log "[webpack:build]", stats.toString(colors: true)
    callback()
    return

# Create a single instance of the compiler to allow caching.
devCompiler = webpack(webpackConfig)
gulp.task "webpack:build-dev", (callback) ->
  # Run webpack.
  devCompiler.run (err, stats) ->
    throw new gutil.PluginError("webpack:build-dev", err)  if err
    gutil.log "[webpack:build-dev]", stats.toString(colors: true)
    callback()
    return
  return

devServer = {}
gulp.task "webpack-dev-server", (callback) ->
  # Start a webpack-dev-server.
  devServer = new WebpackDevServer(webpack(webpackConfig),
    contentBase: './public/'
    hot: true
    watchOptions:
        aggregateTimeout: 100
        poll: 300
    noInfo: true
  )
  devServer.listen 8080, "0.0.0.0", (err) ->
    throw new gutil.PluginError("webpack-dev-server", err) if err
    gutil.log "[webpack-dev-server]", "http://localhost:8080"
    callback()
  return

csp = (req, res, next) ->
  res.setHeader 'Content-Security-Policy', "frame-ancestors 'none'"
  next()

gulp.task 'prod-server', ['webpack:build'], ->
  $.connect.server
    root: ['./public'],
    port: process.env.PORT || 5000,
    livereload: false
    middleware: (connect, opt) ->
      if process.env.NODE_ENV != 'production' then [connect.basicAuth('dev','dev'),csp] else [csp]

gulp.task 'default', -> gulp.start 'build'

gulp.task 'build', ['webpack:build']
gulp.task 'watch', ['webpack-dev-server']
