---
title: "Fine Grained HTTP Header Control & Basic Auth"
author: Mathias Biilmann Christensen
description: "BitBalloon now lets you take control over the HTTP headers for your site, including Basic Authentication"
tags: ["BitBalloon", "Features", "Headers", "Authentication"]
image: /images/posts/policeman.svg
---

![Basic Auth](/images/posts/policeman.svg)

Today we're launching a new feature that lets you add fine grained access control through basic auth, and gives you control over all the HTTP headers for URLs within your site.

<!-- excerpt -->

Our new `_headers` file lets you control HTTP headers for specific paths within your site, as well as letting you configure HTTP basic auth.

The format is very simple:

```
## A path:
/templates/*
  # Headers for that path:
  Cache-Control: max-age: 3000
  Expires: 3000
```

Paths can contain `*` or `:placeholders`. A `:placeholder` matches anything except `/` while a `*` matches anything.

Here's an example of settings the `X-Frame-Options` and `X-XSS-Protection` headers for all pages on your site:

```
/*
  X-Frame-Options: DENY
  X-XSS-Protection: 1; mode=block
```

## Basic auth

The headers file can also be used to set basic auth headers. It's a simple way to limit access to particular parts of your site.

```
/something/*
  Basic-Auth: someuser:somepassword anotheruser:anotherpassword
```

This will trigger the built-in basic browser authentication for any URL under `/something`. There's two users defined here, one with the username "someuser" and password "somepassword", the other with "anotheruser" and "anotherpassword".

Unlike other headers in the `_headers` file, the `Basic-Auth` header will obviously not be sent as a standard HTTP header but used to control the appropriate HTTP headers for basic authentication.
