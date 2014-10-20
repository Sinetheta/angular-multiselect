gulp = require('gulp')
gulpif = require('gulp-if')
lazypipe = require('lazypipe')
config = require('./package.json')

###
Build task.

* Precompile templates.
* Lint Coffee.
* Compile coffee.
* Concat scripts.
* Compile sass.
* Output to dist.
###
rimraf = require('rimraf')
gulp.task 'clean', (cb) ->
  rimraf('./dist', cb)

templateCache = require('gulp-angular-templatecache')
templateTasks = lazypipe()
  .pipe(templateCache, {standalone: true, module: 'ams-templates'})

coffeelint = require('gulp-coffeelint')
coffeelintTasks = lazypipe()
  .pipe(coffeelint)
  .pipe(coffeelint.reporter)

coffee = require('gulp-coffee')
coffeeTasks = lazypipe()
  .pipe(coffee, {bare: true})

concat = require('gulp-concat')
concatTasks = lazypipe()
  .pipe(concat, config.main)

sass = require('gulp-ruby-sass')
sassTasks = lazypipe()
  .pipe(sass)

gulp.task 'build', ['clean'], ->
  gulp.src('src/*')

    .pipe(gulpif(/[.]html$/, templateTasks()))

    .pipe(gulpif(/[.]coffee$/, coffeelintTasks()))
    .pipe(gulpif(/[.]coffee$/, coffeeTasks()))

    .pipe(gulpif(/[.]js$/, concatTasks()))

    .pipe(gulpif(/[.]sass$/, sassTasks()))

    .pipe(gulp.dest('dist'))


karma = require('gulp-karma')
gulp.task 'test', ->
  gulp.src('./see-karma-conf')
    .pipe karma
      configFile: 'test/karma.conf.coffee'
      action: 'run'
    .on 'error', (err) ->
      # Make sure failed tests cause gulp to exit non-zero
      throw err

###
Demo webserver.
###
webserver = require('gulp-webserver')
gulp.task 'serve', ['build'], ->
  gulp.src([
    'bower_components'
    'demo'
    'dist'
  ])
    .pipe webserver
      livereload: true
      open: true

###
Watch task.
###
gulp.task 'watch', ->
  gulp.watch('src/*', ['build'])

###
Default development task.
###
gulp.task('default', ['serve', 'watch']);
