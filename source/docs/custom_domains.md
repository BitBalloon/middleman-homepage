---
layout: docs
title: Custom Domains
position: 2
---

## Using a custom domain

<p class="lead">Often you'll want to configure a custom domain (like www.example.com) for your BitBalloon site. Here's the steps you need to follow to get that done.</p>

### Buying a new domain

If you haven't bought the domain yet, you can register it straight through the BitBalloon interface.

Navigate to the site in the BitBalloon backend and click "Edit Domain", type in the domain you want your site on and click "Next".

If the domain is available, you'll get the option to buy and configure it with 1 click. Just follow the instructions.

You can also use any 3rd party domain registrant. If you prefer this option, we recommend [iwantmyname](https://iwantmyname.com/services/developer/bitballoon-custom-domain). They'll automatically configure your new domain for BitBallloon.

### Using an Existing Domain

To use an existing domain with BitBalloon, go to your site in the BitBalloon backend and click "Edit Domain", type in the domain you want for your site on and click "Next".

* Create a CNAME that will "alias" your site to "www.bitballoon.com". If your domain is example.com, you might alias www.example.com to www.bitballoon.com.
* Create an A record for the raw domain (example.com) pointing to 104.198.14.52

If your DNS provider supports CNAME or ALIAS records for apex domains you can instead alias the raw domain to www.bitballoon.com

Depending on your DNS provider changes to DNS records can take several hours to propagate, so be patient.

### To www or not www

We recommend you always use the www version of the domain (eg. www.example.com) for your site, since this makes it easier to take advantage of BitBalloon's powerful CDN.

If you prefer the non-www domain, we recommend you use a DNS provider that supports CNAME or ALIAS records for apex domains such as Cloudflare or DNSimple.
