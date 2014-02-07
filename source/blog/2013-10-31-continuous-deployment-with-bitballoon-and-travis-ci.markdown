---
title: Building and Deploying BitBalloon.com with Travis CI and Punch
author: Mathias Biilmann
description: Setting up Continuous Deployments with GitHub, Travis CI and BitBalloon
image: /images/posts/continuous-deployment.png
---

At BitBalloon we like to eat our own dog-food, so while our public website started out as just a part of our Rails application, we always wanted to build it as a static site and host it with BitBalloon.

![Punch](/images/posts/punch.png)

When you have a somewhat complex site, you'll quickly outgrow a bunch of HTML files, and that's when a static site generator comes in handy. After [looking at a whole bunch of them](http://staticgen.com) we settled on a node.js based generator called [Punch](http://laktek.github.io/punch/).

<!-- excerpt -->

Punch lets us use mustache for templating and handles Sass and CoffeeScript for us. When working on the content, we use Markdown with our text editors of choice.

We host the repository for bitballoon.com as an open-source project on [GitHub](https://github.com/BitBalloon/homepage), so if you spot a typo in this post, feel free to fork and send a pull request.

![Travis](/images/posts/travis-mascot-200px.png)

The process of working with Git, a good text editor and Markdown works incredibly well when you're a small technical team, but there's still the part left of actually coordinating deploys.

Initially we would simply use the [BitBalloon Ruby gem](https://github.com/BitBalloon/bitballoon-ruby) and do `bitballoon deploy output` locally after building the site.

This works, but it was far from ideal. Sometimes I would miss pulling down Mike's latest changes before deploying, sometimes we would forget to run `punch g` before a deploy or we would deploy a broken build because we forgot to wipe out the `output` dir before building.

[Travis CI](https://travis-ci.org/) is a really neat continuous integration service that integrates with Github and runs a build script on a clean VM each time you push to GitHub.

All it takes to configure Travis is a [.travis.yml](https://github.com/BitBalloon/homepage/blob/master/.travis.yml) configuration file in the root of the repository.

Ours looks like this:


```yaml
language: node_js
node_js:
- '0.11'
env:
  global:
  - secure: QfCYJKFDlbdThkglYQveCG6S/8L77fsBy8k9lh89WDNm4C6pGfyczi/jtULZZXp0FS4uVs/4bI8xHLZL5Ne4vP380Mjl9RDefpE7Qhplt+ot4MKX3aHcKWpKNMMnxv85qRJ28vUyQbd+R+fcNyjwOtuHOQ6EErgjpL3VjUtxQ2I=
  - secure: Am2989lFfvpv/V8NRTCoiJZf6had0JZOVdkK4++pDD31w6ftSTqWIzWkQu9vSd6Vg3+QsnOisaH0jOA5GIddFrg4w+rS9BiMJkAXaqSV8sILalRAH+S62/3yVRTSlPsRDBsna2zopZQW6ZDeKC/WImAcY8At+ndR2WP9giyEbHA=
before_install:
- travis_retry gem install bitballoon
script: node_modules/punch/bin/punch g
after_success: bitballoon deploy output --access-token=$BB_ACCESS_TOKEN --site-id=$BB_SITE_ID
branches:
  only:
    - master
```

Some things to pay attention to:

### Secure variables
We obviously don't want to expose our bitballoon access_token for all the world to see. Travis lets you encrypt variables. Running `travis encrypt BB_ACCESS_TOKEN=secrettoken` will output a string you can use to set an encrypted environment variable.

### before_install
We use the BitBalloon ruby gem, so we need to install that. All other dependencies are installed automatically by Travis with `npm install`.

### after_success
This is where the magic happens. If the build is successfull, we'll deploy the newly created output dir with bitballoon. BitBalloon deploys are atomic, so we're guaranteed that our site won't be left hanging in a broken state if the Travis VM should go down in the middle of the deploy or loses network access.

![Continuous Deployment](/images/posts/continuous-deployment.png)

All in all this makes for a great way to collaborate and work on our public website. We work in branches whenever we make changes, and as soon as we push to master, Travis will go to work, do a clean build and launch the new version of our site.

To grab an API key, just head to [bitballoon.com/applications](https://www.bitballoon.com/applications) and create a new API application.