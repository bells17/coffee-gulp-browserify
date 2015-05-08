gulpif = require 'gulp-if'
sourcemaps = require 'gulp-sourcemaps'
buffer = require 'vinyl-buffer'
through = require 'through2'
uglify = require 'gulp-uglify'
rename = require 'gulp-rename'
browserify = require 'gulp-browserify'

dest = './public/js/'
buildFiles = [
	'./front/coffee/**/*.coffee'
	'./front/coffee/*.coffee'
	'!./front/coffee/lib/**/*.coffee'
	'!./front/coffee/lib/*.coffee'
]

module.exports = (gulp, env)->
	gulp.task 'browserify', ->
	  gulp.src(buildFiles, { read: false })
	  .pipe(browserify(
	    transform: [ 'coffeeify' ]
	    extensions: [ '.coffee' ]))
	  .pipe(rename(extname: '.js'))
	  .pipe(gulpif((do env.isRelease), buffer()))
	  .pipe(gulpif((do env.isRelease), uglify({preserveComments: 'some'})))
	  .pipe(gulpif((do env.isRelease), sourcemaps.init(loadMaps: true)))
	  .pipe(gulpif((do env.isRelease), sourcemaps.write('./')))
	 	.pipe gulp.dest(dest)
