---
layout: docs
title: Gulp
position: 7
---

## Using BitBalloon with Gulp

The [BitBalloon node client](https://github.com/BitBalloon/bitballoon-js) makes it very easy to add a `deploy` task to your Gulpfile.

## Example Gulpfile

```js
'use strict';

var gulp = require('gulp'),
    bb   = require('bitballoon');

gulp.task('build', [], function() {
  // Your build task
});

gulp.task('deploy', ['build'], function() {
  bb.deploy({
    access_token: process.env.BB_ACCESS_TOKEN,
    site_id: "your-site-id",
    dir: "dist"
  }, function(err, deploy) {
    if (err) { throw(err) }
  });
});
```

We recommend using an environment variable for your access_token rather than including it directly in the gulpfile.js. The site id can either be an API id or simply the domain of your site.
