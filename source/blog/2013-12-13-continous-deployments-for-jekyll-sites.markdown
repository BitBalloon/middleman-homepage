---
title: "Continuous Deployment for Jekyll sites"
author: Mathias Biilmann
description: "Using BitBalloon and TravisCI to get continuous deployments for Jekyll sites without GitHub pages' limitations"
---

A great part of the popularity of [Jekyll](http://jekyllrb.com/) no doubt comes from GitHub Page's Jekyll integration. Every GitHub Page is run through Jekyll when you push content to your repository, so you get continuous deployments out of the box.

This comes with some limitations, however. There's no way to use any Jekyll plugins (since GitHub is not setup to run untrusted ruby code during the deploys) and if you want any forms on your site, you'll need to use a third-party service.

With BitBalloon and Travis-CI you can get the same continuous deployment process for your Jekyll site without these restrictions.

<!-- excerpt -->

As a bonus your JS and CSS will be bundled and minified, your images will be run through a lossless image optimizer and all assets will be served straight out of a CDN with far future caching headers.

## Getting started

The first step is simply to get a Jekyll site up and running. You can obviously skip this step if you already have a Jekyll based site:

{% highlight bash %}
gem install jekyll
jekyll new continuous-deployment-rocks
cd continuous-deployment-rocks
{% endhighlight %}

We'll also create a new GitHub repository and push our new Jekyll site. You can find the example repository [here](https://github.com/BitBalloon/jekyll-continuos-deployment).

## Pushing to BitBalloon

Before we get started on automating our deploys, we'll do a first manual deploy to BitBalloon through the ruby gem.

{% highlight bash %}
gem install bitballoon
jekyll build
bitballoon deploy _site
{% endhighlight %}

The first time you deploy, you'll be prompted for your BitBalloon API credentials. So go [create a BitBalloon API application](https://www.bitballoon.com/applications). Once you're done, enter your client id and secret.

Now your Jekyll site will be up and running on BitBalloon. The `bitballoon deploy` command will store your access token and your site ID in a hidden `.bitballoon` file. Make sure to add this file to your `.gitignore` since you'll never want to share your BitBalloon access token with the world.

With this in place you can run `bitballoon deploy _site` at any time and your site will be updated without any prompt.

## Configuring TravisCI

If you haven't done it already, sign up for [Travis CI](https://travis-ci.org) with your GitHub account. Travis is a hosted continuos integration service that can listen to a GitHub repository of your choice, and run a build every time you push to GitHub.

To get it to listen to your new Jekyll repository, go to your profile page inside Travis, find the new repository and toggle the switch on. Now Travis is ready to run a build when you push to GitHub, but we still need to tell Travis how to build and deploy a Jekyll site.

To do this you need to add a `.travis.yml` configuration file to the root of your repository:

{% highlight yaml %}
language: ruby
before_install:
- travis_retry gem install bitballoon
- travis_retry gem install jekyll
script: jekyll build
after_success: bitballoon deploy _site --access-token=$BB_ACCESS_TOKEN --site-id=$BB_SITE_ID
branches:
  only:
    - master
{% endhighlight %}

Before you're ready to push, you need to add some encrypted variables to the Travis configuration, so you can reference your BitBalloon access token without sharing it with the world:

{% highlight bash %}
gem install travis
travis encrypt BB_ACCESS_TOKEN=<access token from .bitballoon> --add
travis encrypt BB_SITE_ID=<site id from .bitballoon> --add
{% endhighlight %}

This will encrypt both settings and add them to your `.travis.yml` file.

## Enjoy!

That's it. Now check in the changes and push to GitHub:

{% highlight bash %}
git add .
git commit -a -m "configure continous deploys with Travis CI and BitBalloon"
git push origin master
{% endhighlight %}

Travis should register a new commit and start going to work. The free version of Travis doesn't cache dependencies, so it has to install both Jekyll and BitBalloon on each build. Be a little patient. After the built is done, you should see a new version has appeared in the history tab of your BitBalloon dashboard.

Now the rest is up to you. Create a great Jekyll site, use any plugin you want, collaborate with a team or hook up [prose.io](http://prose.io/) to get a friendlier editing experience inside the browser. Each time you push to master, your changes will go live on BitBalloon.
