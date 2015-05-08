gulp = require 'gulp'
recursive = require 'recursive-readdir'

# set env
env =
	env: process.env.NODE_ENV
	isRelease: ->
		(@env is 'production')

# require gulp tasks
gulp.task 'recursiveTask', (callback) ->
  recursive './gulp', (err, files) ->
    files.forEach (path, index, arry) ->
      path = './' + path.replace('\\', '/')
      require(path) gulp, env
    do callback

# set build task
gulp.task 'build', ['recursiveTask'], ->
	gulp.start [ 'browserify' ]

# set watch task
watchFiles = [
	'./front/coffee/**/*.coffee'
	'./front/coffee/*.coffee'
]
gulp.task 'watch', ->
  gulp.watch watchFiles, [ 'build' ]

# set default task
gulp.task 'default', [ 'build' ]
