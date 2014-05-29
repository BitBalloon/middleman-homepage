---
layout: docs
title: HTTPS
position: 5
---

## HTTPS with BitBalloon

<p class="lead">Today more and more users will expect to be able to access your site securely over HTTPS. With BitBalloon you can add a CDN backed SSL certificate to your site that works in all browsers.</p>


### Why HTTPS?

Using HTTPS gives your users a guarantee that the website they see on their browsers are really the website you want them to see.

Today it's common to browse through untrusted Wi-Fi connections at coffee-shops, airports, etc, where a so called "man in the middle" can all to easily manipulate and collect the data you are viewing.

In more bening cases this is quite often abused to inject foreign ads into websites. As a website publisher it's in your interest to make sure that what your users see is really what you intended it to be,
without any slow-loading ads or banners to degrade the experience and reflect badly on your brand.

In less bening cases 3rd parties might swap out links to 3rd party scripts like Stripe or Facebook Connect with their own fishing widgets.

HTTPS protects your site against any kind of tampering, and seeing the green lock in their browser can give users a higher sense of trust in your website.

### HTTPS with BitBalloon

Sites using `<yoursite>.bitballoon.com` domains will support HTTPS out of the box with no extra configuration.

For sites with a custom domain, BitBalloon let you provision, configure and install a certificate with just a click.

Once you've upgraded to a premium site and have a custom domain configured, you can click "Enable HTTPS" when viewing your site in the admin UI.

You can pay either monthly or yearly for your certificate. Once you pick a plan and buy the certificate, BitBalloon will provision a new certificate for your domain, verify your domain, and distribute the certificate to all the edge servers in our content delivery network.

Once the certificate is installed, you can choose to force all visits to your site to use HTTPS. This will configure your site to use [Strict Transport Security](http://en.wikipedia.org/wiki/HTTP_Strict_Transport_Security) for your domain and force browsers to only allow access over HTTPS.

### HTTPS and performance

Accessing a site over HTTPS does come with some cost to performance, especially on the first connection where a "handshake" takes place between the browser and the server to verify the certificate.

We recommend that you take full advantage of BitBalloon's built-in CDN when using HTTPS, by either using a www. domain that you can configure with a CNAME or a DNS service like DNSimple that allow ALIAS records for apex domains. This will make the handshake take place at an edge server closer to the end user and minimizes the performance overhead of the handshake.

### Browser Support

BitBalloon's HTTPS certificates works in all browsers. Any modern browser will use a technique called Server Name Indication (SNI) to serve a unique SSL certificate for your domain. Older browsers or other HTTP clients that don't support SNI will be served a shared certificate including your domain. This lets us offer CDN backed HTTPS without the usual high cost for provisioning a unique IP address on each of our edge-nodes.

### Using your own certificate with BitBalloon

If you need to use your own certificate with BitBalloon (e.g. you have an Extended Validation certificate), please contact [team@bitballoon.com](mailto:team@bitballoon.com).
