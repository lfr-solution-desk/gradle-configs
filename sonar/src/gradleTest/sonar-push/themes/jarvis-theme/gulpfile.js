'use strict';

const del = require('del');
const gulp = require('gulp');
const liferayThemeTasks = require('liferay-theme-tasks');
const path = require('path');
const rename = require('gulp-rename');
const runSequence = require('run-sequence');
const svgmin = require('gulp-svgmin');
const svgstore = require('gulp-svgstore');

const baseThemePath = __dirname;

const buildPath = path.join(baseThemePath, 'build');
const srcPath = path.join(baseThemePath, 'src');
const jarvisAllSvgPath = '/images/jarvis/icons';

const SUFFIX_REGEX = /(-regular|-solid|-light)/i;

const svgMinConfig = file => {
	const prefix = path.basename(file.relative, path.extname(file.relative));
	return {
		plugins: [
			{
				cleanupIDs: {
					prefix: prefix + '-',
					minify: true
				}
			}
		]
	};
};

gulp.task('clean-icons', () => del(`${buildPath}${jarvisAllSvgPath}/*.svg`));

gulp.task(
	'compile-svgs',
	() => (
		gulp
		.src(`${srcPath}${jarvisAllSvgPath}/*.svg`)
		.pipe(rename(path => {
			path.basename = path.basename.replace(SUFFIX_REGEX, '');
			return path;
		}))
		.pipe(svgmin(svgMinConfig))
		.pipe(svgstore())
		.pipe(gulp.dest(`${buildPath}${jarvisAllSvgPath}`))
	)
);

liferayThemeTasks.registerTasks({
	gulp: gulp,
	hookFn: function(gulp) {
		gulp.hook('after:build:src', done =>
			runSequence('clean-icons', done)
		);

		gulp.hook('before:build:war', done =>
			runSequence('compile-svgs', done)
		);
	}
});