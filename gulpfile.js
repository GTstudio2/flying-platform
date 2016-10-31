var gulp = require('gulp'),
    sass = require('gulp-sass'),
    sourcemaps = require('gulp-sourcemaps')
    //bSync = require('browser-sync').create();
    //miniCss = require('gulp-minify-css'),
    //concat = require('gulp-concat'),
    //rename = require('gulp-rename')
    //var reload      = bSync.reload;
    //del = require('del');

gulp.task('sass', function() {
    return gulp.src('grails-app/assets/scss/*.scss')
        .pipe(sourcemaps.init())
        .pipe(sass().on('error', sass.logError))
        .pipe(sourcemaps.write('./maps'))
        .pipe(gulp.dest('grails-app/assets/stylesheets'))
});
//gulp.task('miniCss', function() {
//    return gulp.src('app/css/*.css')
//        .pipe(miniCss())
//        .pipe(rename({suffix: '.min'}))
//        .pipe(gulp.dest('dist/css'))
//});
//gulp.task('clean', function(cb) {
//    del(['dist/css', 'dist/js'], cb)
//});
gulp.task('watch', function () {
    var watcher = gulp.watch('grails-app/assets/scss/**/*.scss', ['sass']);
    watcher.on('change', function(event) {
        console.log('File ' + event.path + ' was ' + event.type + ', running tasks...');
    });
})

//gulp.task('js-watch', function (done) {
//    bSync.reload();
//    done();
//});
//
//// use default task to launch bSync and watch JS files
//gulp.task('serve', function () {
//
//    // Serve files from the root of this project
//    bSync.init({
//        proxy: "localhost:9001"
//    });
//
//    //bSync.files = [
//    //    '*'
//    //    //assets + '/css/*.css',
//    //    //assets + '/js/*.js',
//    //    //assets + '/images/**',
//    //    //assets + '/fonts/*'
//    //]
//    //gulp.watch("*").on("change", reload);
//
//    // add bSync.reload to the tasks array to make
//    // all browsers reload after tasks are complete.
//    //gulp.watch("js/*.js", ['js-watch']);
//});