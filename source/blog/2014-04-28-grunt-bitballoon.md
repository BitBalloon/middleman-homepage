---
title: "Grunt BitBalloon Deploy Task"
author: Mathias Biilmann Christensen
description: "The grunt-bitballoon plugin lets you add a bitballoon deploy task to your Gruntfile."
tags: ["Grunt", "Continuous Deployment", "Plugins"]
image: /images/posts/grunt-logo.png
---

![Grunt Logo](/images/posts/grunt-logo.png)

Grunt has quickly become the standard build-tool for the front-end world, with a huge ecosystem with hundreds of plugins you can use to automate just about anything.

Today we're adding one more to the list: [grunt-bitballoon](https://github.com/BitBalloon/grunt-bitballoon).

<!-- excerpt -->

The BitBalloon Grunt plugin makes it straight forward to deploy to BitBalloon straight from your Gruntfile. It's a multi-task plugin, so you can easily setup development, staging and production targets.

Here's a simple example of a Gruntfile using the plugin to setup a separate dev and prod target:

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

grunt.registerTask('deploy', [
  'bitballoon:prod'
]);
```

Get all the details in our [grunt-bitballoon docs](/docs/grunt)
