---
layout: docs
title: Redirects
position: 4
---


## Redirects and Rewrites

Configuring redirects or rewrites for your BitBalloon site is as easy as adding a file called `_redirects` to the root directory of your site folder.

Setting up basic redirects is dead simple:

    /home              /
    /blog/my-post.php  /blog/my-post
    /news              /blog
    /google            https://www.google.com

Just list the original path followed by the new path or URL.


### Status Codes

You can specify the HTTP status code for the rewrite. The default is 301 which will do a permanent redirect.

    /home         /              301
    /my-redirect  /              302
    /pass-through /index.html    200
    /ecommerce    /store-closed  404

When the status code is 301, 302 or 303 BitBalloon will redirect to the target url. With any other status code BitBalloon will render the target url with the specified status code.

This means that you can define **rewrite** rules as well as **redirects** by specifying 200 as the status code.


### Using Placeholders

You can use placeholders in the origin and target paths:

    /news/:year/:month:/:date/:slug  /blog/:year/:month/:date/:story_id

This would redirect a url like `/news/2004/02/12/my-story` to `/blog/2004/02/12/my-story`


### Splats

An asterisk indicates a **splat** that will match anything that follows:

    /*    /index.html   200

Will serve the home page for any path with 200 as status code. This can be really useful for angular apps or other one-page apps using history pushstate.

You can use the splat in your rewrites or redirects like this:

    /news/*  /blog/:splat

This would redirects paths like `/news/2004/01/10/my-story` to `/blog/2004/01/10/my-story`


### Matching on Query Parameters

You can also match on query parameters:

    /blog  post=:slug  /blog/:slug

In this case the path `/blog?post=my-blog-post` would redirect to `/blog/my-blog-post`


### Note on shadowing

You currently can't shadow a URL that actually exists within the site. This means that even if you've setup the following rewrite rule:

    /*   /index.html   200

The path `/partials/chat.html` would still render the contents of that file, if that file actually exists.
