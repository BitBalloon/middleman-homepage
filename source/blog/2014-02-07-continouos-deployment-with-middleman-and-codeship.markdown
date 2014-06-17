---
title: "Continuous Deployment with Middleman and Codeship"
author: Mathias Biilmann
description: "Set up fast and easy deployments with Middleman, Codeship and BitBalloon"
tags: ["Middleman", "Codeship", "API", "Continuous Deployment"]
image: /images/posts/github-codeship-bitballoon.png
---

![Github -> Codeship -> BitBalloon](/images/posts/github-codeship-bitballoon.png)

We recently ported the BitBalloon homepage to [Middleman](http://middlemanapp.com/), a ruby based static site generator that'll make you feel right at home if you're used to Ruby on Rails development.

In this post you'll see how we setup continuous deployment for our Middleman site with [Codeship](https://www.codeship.io/), a very affordable hosted continuous integration service.

<!-- excerpt -->

First step is obviously to start a middleman site. If you're starting a new one from scratch, here's how it looks like:

```bash
gem install middleman
middleman init my-site
```

This creates a new Middleman site that you can start working on. Create a new repository for your site on github and push your site there.

Alternatively, you can just fork our homepage from [Github](https://github.com/BitBalloon/middleman-homepage).

## Your first BitBalloon deploy

Before moving on, you'll want to do your first BitBalloon deploy manually.

First add this to your **Gemfile**:

```ruby
gem "bitballoon"
```

Now go grab a BitBalloon API key at [bitballoon.com/applications](https://www.bitballoon.com/applications).

With your API key ready, you can do your first deploy:

```bash
bundle install
bundle exec middleman build
bundle exec bitballoon deploy build
```

This will first install all the dependencies, then run Middleman to build your site and finally deploy the **build** directory to BitBalloon.

Once the site is deployed, the BitBalloon commandline tool stores a file in your Middleman dir called **.bitballoon** with an access token and the ID of the site you deployed. You'll normally want to add this file to your **.gitignore** file.

## Configuring Codeship

Now that your Middleman site is live on BitBalloon, it's time to get continuous deploys setup. Signup for Codeship and then create a new project.

![Step 1 - Choose Your Provider](/images/posts/codeship-choose-provider.png)

Pick GitHub as your provider and select the repository with your Middleman site. Once you've picked your repository, Codeship will ask you to configure your tests.

Pick **Ruby** from the **Select your technology to prepopulate basic commands** dropdown. Then Modify your test command to:

```bash
bundle exec middleman build
```

Instead of clicking the big green "Save and go to dashboard" button, follow the "save and continue your setup" link. Select the **Master** branch of your repository and then make sure to pick the **$script** option.

![Step 2 - Pick the Script Option](/images/posts/codeship-pick-script.png)

In the big deployment commands textbox, just type:

```bash
bundle exec bitballoon deploy build --access-token=YOUR_ACCESS_TOKEN --site-id=YOUR_SITE_ID
```

Replace the access token and site id with the values from your **.bitballoon** file. Save and finish, and Codeship will start building and deploying your site.

It can all be done in just a few minutes and this flow will serve you all the way from prototyping till a production site with millions of visitors.

![Step 3 - Success](/images/posts/codeship-success.png)
