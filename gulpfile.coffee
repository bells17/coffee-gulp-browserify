gulp = require 'gulp'
sourcemaps = require 'gulp-sourcemaps'
buffer = require 'vinyl-buffer'
through = require 'through2'
uglify = require 'gulp-uglify'
rename = require 'gulp-rename'
browserify = require 'gulp-browserify'

gulp.task 'browserify-dev', ->
  gulp.src([
  	'./front/coffee/**/*.coffee'
  	'./front/coffee/*.coffee'
  	'!./front/coffee/lib/**/*.coffee'
  	'!./front/coffee/lib/*.coffee'
  ], {
  	read: false
  })
  .pipe(browserify(
    transform: [ 'coffeeify' ]
    extensions: [ '.coffee' ]))
  .pipe(rename(extname: '.js'))
  .pipe(buffer())
  # .pipe(uglify())
  .pipe(sourcemaps.init(loadMaps: true))
  .pipe(sourcemaps.write('./'))
 	.pipe gulp.dest('./public/js/')

gulp.task 'browserify', ->
  gulp.src([
  	'./front/coffee/**/*.coffee'
  	'./front/coffee/*.coffee'
  	'!./front/coffee/lib/**/*.coffee'
  	'!./front/coffee/lib/*.coffee'
  ], {
  	read: false
  })
  .pipe(browserify(
    transform: [ 'coffeeify' ]
    extensions: [ '.coffee' ]))
  .pipe(rename(extname: '.js'))
  .pipe(buffer())
  .pipe(uglify())
  .pipe(sourcemaps.init(loadMaps: true))
  .pipe(sourcemaps.write('./'))
 	.pipe gulp.dest('./public/js/')

gulp.task 'watch-dev', ->
  gulp.watch [
  	'./front/coffee/**/*.coffee'
  	'./front/coffee/*.coffee'
  ], [ 'browserify-dev' ]

gulp.task 'watch', ->
  gulp.watch [
  	'./front/coffee/**/*.coffee'
  	'./front/coffee/*.coffee'
  ], [ 'browserify' ]
