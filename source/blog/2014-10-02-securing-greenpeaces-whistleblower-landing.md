---
title: "Securing Greenpeace's Whistleblower Landing"
author: Mathias Biilmann Christensen
description: "When Greenpeace New Zealand launched safesource.org.nz, their anonymous whistleblower platform. We helped them host and secure the landing."
tags: ["Security", "Clients", "Authentication"]
image: /images/posts/safesource.png
---

![SafeSource](/images/posts/safesource.png)

A few weeks ago [Nick Young](https://twitter.com/nickofnz) from [Greenpeace in New Zealand](http://www.greenpeace.org/new-zealand/en/) contacted me with some questions about our SSL solution.

It turned out they were just about to launch an exciting new project with security as a top priority.

The project is called [SafeSource](https://www.safesource.org.nz/), and it allows anyone with important information relating to illegal activity, corruption, poor governance and mismanagement in business or government to safely and securely blow the whistle.

<!-- excerpt -->

It's based on [Aaron Swartz's SecureDrop software](https://pressfreedomfoundation.org/securedrop) and the actual application runs on Greenpeace's own infrastructure and is only accessible via [Tor](https://www.torproject.org/).

The public website for the project, however, now runs on BitBalloon.

## What could possibly go wrong?

Static websites are by default more secure than anything that runs custom code as a part of each request. With a static website there's no moving parts, no database to target with SQL injection, no way to play with the requests to trigger XSS exploits on the site, no admin cookies to fiddle with, etc, etc. The attack surface is much, much smaller than for any dynamic site.

That said, there's still a lot of things you need to consider if you care about the security and privacy of your users. For SafeSource, a whistleblower getting caught could have really serious consequences, so it's no wonder Greenpeace takes security extremely seriously.

So what's the risks when it comes to a public landing for a SecureDrop installation? When securing a landing, what are we protecting against?

Here's a few thing we made very sure to do in order to keep this as safe as possible for potential whistleblowers:

## Force HTTPS

This is the most basic and obvious security consideration: make sure to always serve the site over HTTPS.

Simply encrypting the traffic gives some amount of privacy, and this is a bonus. It's important to realize that even when visiting a site over an encrypted SSL connection, modern browsers will still send the domain name in plain text (required for SNI support) and DNS lookups are not encrypted, so if a company network logs network traffic, they'll potentially be able to see that an employee has visited a whistle blower site. There's currently no way to guard against these information leaks from the browser. So if you're thinking about blowing the whistle, either don't browse on a company connection or make sure to use a VPN (and make sure DNS traffic goes through the VPN, not just the HTTP traffic).

More importantly, HTTPS guards against man in the middle attacks. If you're browsing through any corporate or public network it's quite easy for anybody in control of the network to hijack HTTP requests and either inject unwanted scripts into the pages you're visiting (this could be tracking scripts, adware or even worse) or simply return a fake version of the site.

Anybody impersonating the site can easily replace the instructions for whistleblowers and get them to send their submissions to an inbox they control.

Man-in-the-middle attacks are not just some far fledged theoretical threat, companies operating public Wi-Fi networks such as Comcast with their Xfinity net, have been known to inject adware into every page browsed in plain text.

When you force HTTPS on a BitBalloon site we automatically set a HTTP header called Strict-Transport-Security to a value of 1 year. This tells browsers that for the next year they should never accept an unencrypted version of the site. This helps guarding against man-in-the middle attacks where the attacker simply tries to get the victim to visit an unencrypted and hijacked version of the site.

## Disable Caching

For most sites, speed is one of the most important hosting considerations. The fastest request is a request never made, so out of the box BitBalloon will do a lot of work to make sure your assets get cached as much as possible.

For a site where privacy is key, however, caching suddenly becomes a problem. You don't want the images and JavaScript files from www.safesource.org.nz to stick around in Mr. Whistleblower's browser cache at all, so we added a brand new feature to BitBalloon to give [fine grained control over HTTP headers](https://www.bitballoon.com/blog/2014/09/29/fine-grained-header-control). This allowed Greenpeace to set the following cache headers in a simple "_headers" file:

```
/*
  Cache-Control: no-cache, no-store, must-revalidate
  Pragma:no-cache
  Expires:-1
```

All of these these tells the browser to never cache or store any of the files served from the SafeSource landing.

We also disabled all our usual optimizations related to pushing assets straight onto Akamai and serving them out of their CDN with far future caching headers. Instead we're using our own edge servers and we make sure no assets get cached in browsers.

## Disable Logging

Normally we log everything that happens during a request for a BitBalloon site, but in this case we set up a separate set of CDN nodes specifically for Greenpeace, configured to never log any identifying information.

For the SafeSource site we mask IPs and strip referrers and user-agents so they never show up in any of our logs. This way we make sure not to hold on to any information that could help identify a whistleblower.

## Take Advantage of Modern Browsers

Modern browsers comes with a series of security features that can be enabled via HTTP headers.

One of the most powerful security mechanisms in modern browsers is the `Content-Security-Policy` header. This header limits the allowed domains content will be fetched from. The strictest form is:

```
Content-Security-Policy: default-src 'self'
```

This tells the browser to not load any JavaScript, CSS, images or other assets that don't come from the same domain as the current website. This breaks any attempt at inserting tracking pixels or otherwise sending tracking information to external sites.

The full set of security related HTTP headers for www.safesource.org.nz looks like this:

```
/*
  X-XSS-Protection: 1; mode=block
  X-Content-Type-Options: nosniff
  X-Download-Options: noopen
  X-Permitted-Cross-Domain-Policies: master-only
  X-Frame-Options: DENY
  X-Content-Security-Policy: default-src 'self'
  Content-Security-Policy: default-src 'self'
```

Apart from disallowing external assets, this will make modern browsers refuse to open the site within an iframe, it will active the browsers' built-in Cross-site scripting (XSS) filter, and prevent flash or PDF files from embedding the website.

# Blow the whistle, but be paranoid

We're proud to play our little part in Greenpeace's whistleblower initiative, and we've taken every step to keep our part of the project secure and anonymous.

That said, if you're leaking important information online, be really paranoid. Always use a VPN and make sure all DNS traffic goes through the VPN as well.

> “Just because you're paranoid doesn't mean they aren't after you”
> ― Joseph Heller, Catch-22
