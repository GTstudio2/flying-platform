var gulp = require('gulp'),
    sass = require('gulp-sass'),
    //miniCss = require('gulp-minify-css'),
    //concat = require('gulp-concat'),
    rename = require('gulp-rename')
    //del = require('del');

gulp.task('sass', function() {
    return gulp.src('grails-app/assets/scss/*.scss')
        .pipe(sass())
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