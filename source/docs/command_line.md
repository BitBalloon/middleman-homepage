---
layout: docs
title: Commandline
position: 5
---

## Command Line Utility

The BitBalloon gem comes with a handy command line utility for deploying and redeploying sites.

To install the gem run:

```shell
gem install bitballoon
```

To deploy the site in the current working directory:

```ruby
bitballoon deploy
```

The first time you deploy, you will be asked for your `client id` and `client secret`. After the deploy the tool will store an `access_token` and the `site_id` in `.bitballoon`. Next time you run the command the tool will redeploy the site using the stored `access_token`.

You can also deploy a specific path:

```ruby
bitballoon deploy /path/to/my/site
```

Or a zip file:

```ruby
bitballoon deploy /path/to/my/site.zip
```

If there is no .bitballoon file yet, you can deploy to an existing site by passing in the ID:

```ruby
bitballoon deploy /path/to/my/site.zip --site-id YOUR_SITE_ID
```
