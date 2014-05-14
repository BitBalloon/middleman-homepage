---
layout: docs
title: Grunt
position: 4
---

## Using BitBalloon with Grunt

The [Grunt plugin](https://github.com/BitBalloon/grunt-bitballoon) lets you deploy your sites with a [Grunt](http://gruntjs.com/) task.

## Getting Started
```shell
npm install grunt-bitballoon --save-dev
```

Once the plugin has been installed, it may be enabled inside your Gruntfile with this line of JavaScript:

```js
grunt.loadNpmTasks('grunt-bitballoon');
```

## BitBalloon Setup

Before configuring the Gruntfile you'll need to get a BitBalloon API access_token and do an initial manual deploy to create the site.

* Register your [BitBalloon API Client](https://www.bitballoon.com/applications)
* Deploy a site through the [bitballoon.com web ui](https://www.bitballoon.com) or the [commandline tools](/docs/command_line)

## Options

The grunt-bitballoon task is a [multi-task](https://github.com/gruntjs/grunt/wiki/Creating-tasks); meaning you can specify different targets for this task to run as.

A quick reference of options

* **token** - (*string*) Your BitBalloon API access token
* **site** - (*string*) The URL of your BitBalloon site
* **src** - (*string*) Directory to deploy

By default the plugin will look for BB_TOKEN and BB_SITE environment variables. You should **always** keep the access_token out of your Github repository either by using environment variables or by using template strings as in the example below.

### Example

Template strings in grunt will allow you to easily include values from other files. The below example
demonstrates loading BitBalloon settings from another file, Where grunt-bitballoon.json is just a json key:value file like package.json.

This is **important because you should never check in your BitBalloon token to github! Load them from an external file that is outside of the repo.**

```javascript
grunt.initConfig({
  bb: grunt.file.readJSON('./grunt-bitballoon.json'),
  bitballoon: {
    options: {
      token: '<%= bb.token %>',
      src: 'dist'
    },
    dev: {
      site: "http://my-staging-site.bitballoon.com"
    },
    prod: {
      site: "http://my-production-site.bitballoon.com"
    }
  }
});
```
