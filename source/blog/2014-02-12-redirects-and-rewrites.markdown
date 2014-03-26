---
title: "We can do Better than htaccess: Redirects and Rewrite Rules"
author: Mathias Biilmann
description: "Announcing straight forward redirects and rewrite rules for BitBalloon. Much simpler than htaccess"
tags: ["BitBalloon", "Single Page Apps", "Angular", "Features"]
image: /images/posts/redirects.jpg
---
![Redirects and Rewrite Rules](/images/posts/redirects.jpg)

If you've been doing websites for a while you've no doubt run into `.htaccess` files. It's a common directory level configuration file supported by various webservers.

For historical reasons the format of .htaccess is the same as the Apache web server's global configuration file and can be used to configure lots of different settings ranging from access permissions to character sets and CGI handlers.

But lets face it, 99% of the times you've opened up an .htaccess file its no doubt been to setup some redirects or configure a rewrite rule.

We've been thinking long and hard about how to let our users do that in a far more straight forward way. Making sure that the most typical use case (redirecting a bunch of old paths to new paths) is as simple as possible, without giving up on more advanced use cases.

Today we're really happy to launch our new support for [redirects and rewrite rules](/docs/redirects_and_rewrites).

To configure redirects or rewrites for your site, just make sure your root folder includes a file named `_redirects`.

Here's a commented example with a bit of everything thrown in for good meassure:

```
# Redirect from /news to /blog
/news   /blog

# Redirect /google to google
/google https://www.google.com

# Redirect from /store to /temporarily-disabled with a 302
/store  /temporarily-disabled  302

# Redirect URLs like /news/2004/2/12/a-blogpost to /blog/a-blogpost
/news/:year/:month/:day/:slug  /blog/:slug

# Redirect URLs like /blog?slug=a-blogpost to /blog/a-blogpost
/blog slug=:slug /blog/:slug

# Redirect anything under /news to start with /blog instead of /news
/news/*  /blog/:splat

# Rewrite any url under /angular/... to use the same path but display /angular.html
/angular/*  /angular.html  200
```

That's pretty much all you need to know to handle just about any redirect or rewrite you'll commonly run into.

Check out the [full documentation](/docs/redirects_and_rewrites) and let us know if you got questions or comments on this new format.
