gulp = require 'gulp'
recursive = require('recursive-readdir')
gulp.task 'recursiveTask', (callback) ->
  recursive './gulp', (err, files) ->
    files.forEach (path, index, arry) ->
      path = './' + path.replace('\\', '/')
      require(path) gulp
    do callback

gulp.task 'build-dev', ['recursiveTask'], ->
	gulp.start [ 'recursiveTask', 'browserify-dev' ]
gulp.task 'build', ['recursiveTask'], ->
	gulp.start [ 'browserify' ]

watchFiles = [
	'./front/coffee/**/*.coffee'
	'./front/coffee/*.coffee'
]

gulp.task 'watch-dev', ->
  gulp.watch watchFiles, [ 'build-dev' ]
gulp.task 'watch', ->
  gulp.watch watchFiles, [ 'build' ]

gulp.task 'default', [ 'build-dev' ]
gulp.task 'release', [ 'build' ]
