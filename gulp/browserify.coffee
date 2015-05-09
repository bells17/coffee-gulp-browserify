gulpif = require 'gulp-if'
sourcemaps = require 'gulp-sourcemaps'
buffer = require 'vinyl-buffer'
uglify = require 'gulp-uglify'
rename = require 'gulp-rename'
browserify = require 'browserify'
through2 = require 'through2'

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
    .pipe(through2.obj((file, enc, next)->
	    browserify(file.path,
	      debug: true
	      transform: [ 'coffeeify' ]
	      extensions: [ '.coffee' ]
	    )
	    .bundle((err, res)->
	    	file.contents = res
	    	next err, file
	    )
	  ))
	  .pipe(rename(extname: '.js'))
	  .pipe(buffer())
	  .pipe(gulpif((do env.isRelease), uglify({preserveComments: 'some'})))
	  .pipe(sourcemaps.init(loadMaps: true))
	  .pipe(sourcemaps.write('./'))
	 	.pipe gulp.dest(dest)
