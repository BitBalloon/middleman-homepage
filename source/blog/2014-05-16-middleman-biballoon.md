---
title: "The Middleman BitBalloon Extension"
author: Mathias Biilmann Christensen
description: "Deploy your Middleman built site to BitBalloon with the middleman-bitballoon plugin"
tags: ["Middleman", "Static Site Generators", "Plugins", "Continuous Deployment"]
image: /images/posts/middleman.png
---

![Middleman Logo](/images/posts/middleman.png)

[Middleman](http://middlemanapp.com/) is one of our favorite static site generators here at BitBalloon.

This site is built with Middleman and we recently launched [StaticGen](http://www.staticgen.com), a directory of open-source static site generators, powered by Middleman.

Our new [middleman-bitballoon](https://github.com/BitBalloon/middleman-bitballoon) extension now makes it even easier to deploy Middleman built sites to BitBalloon.

<!-- excerpt -->

### Using the Plugin

The `middleman-bitballoon` extension adds a `middleman deploy` command to Middleman.

First add `middleman-bitballoon` to the Gemfile of you Middleman project:

    gem 'middleman-bitballoon'

And then run `bundle install`.

Before you can deploy, you'll need to configure the extension in your config.rb:

    activate :bitballoon do |bitballoon|
      bitballoon.token = ENV["BB_TOKEN"]
      bitballoon.site  = "my-bitballoon-site.bitballoon.com"

      # Optional: always run a build before deploying
      bitballoon.build_before = true
    end

We recommend setting the Access Token from an environment variable, but obviously you can also load it from a file or hardcode it in your config.rb.

To generate a token, just go to [the BitBalloon Applications screen](https://www.bitballoon.com/applications) and create a personal token.

Once the project has been configured right, you can deploy at any time with:

    bundle exec middleman deploy
