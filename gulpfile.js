const gulp = require('gulp');
const elm  = require('gulp-elm');
const uglify = require('gulp-uglify');
const fs = require('fs');

gulp.task('elm-init', elm.init);

gulp.task('elm', ['elm-init'], () =>
    gulp.src('src/TodoStoreBroker.elm')
        .pipe(elm())
        .on('error', console.log.bind(this))
        .pipe(gulp.dest('dist/'))   //elm-todomvc.js?
);

gulp.task('watch', ['elm'], () =>
    gulp.watch('src/**/*.elm', ['elm'])
        .on('change', event => console.log('File ' + event.path + ' was ' + event.type + ', running tasks...'))
);

// gulp.task('elm-dist', ['elm-init'], () =>
//     gulp.src('src/**/*.elm')
//         .pipe(elm())
//         .pipe(uglify())
//         .pipe(gulp.dest('dist/'))
// );

gulp.task('build', ['elm']);

gulp.task('default', ['elm']);
