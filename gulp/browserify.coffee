sourcemaps = require 'gulp-sourcemaps'
buffer = require 'vinyl-buffer'
through = require 'through2'
uglify = require 'gulp-uglify'
rename = require 'gulp-rename'
browserify = require 'gulp-browserify'

buildFiles = [
	'./front/coffee/**/*.coffee'
	'./front/coffee/*.coffee'
	'!./front/coffee/lib/**/*.coffee'
	'!./front/coffee/lib/*.coffee'
]

module.exports = (gulp)->

	gulp.task 'browserify-dev', ->
	  gulp.src(buildFiles, { read: false })
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
	  gulp.src(buildFiles, { read: false })
	  .pipe(browserify(
	    transform: [ 'coffeeify' ]
	    extensions: [ '.coffee' ]))
	  .pipe(rename(extname: '.js'))
	  .pipe(buffer())
	  .pipe(uglify())
	  .pipe(sourcemaps.init(loadMaps: true))
	  .pipe(sourcemaps.write('./'))
	 	.pipe gulp.dest('./public/js/')
