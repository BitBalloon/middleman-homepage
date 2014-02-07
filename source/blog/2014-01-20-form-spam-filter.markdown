---
title: "Form Spam Filtering"
author: Mathias Biilmann
description: "Get rid of contact form spam. BitBalloon now filters all form submissions."
image: /images/posts/spam.jpg
tags: ["Forms", "BitBalloon", "Spam"]
---

![Spam](/images/posts/spam.jpg)

As a bit of an X-mas gift to all of our users, we rolled out a whole new spam filter over the holidays.

Whenever you upload a site to BitBalloon we'll find any HTML form on the page, and make it work by giving it a little submission database. This is extremely handy when you have a site with a typical contact form.

<!-- excerpt -->

Spammers, however, can never just let the rest of us have our nice things. If you have any experience with exposing a contact form on a site that starts getting some level of traffic, you'll know it doesn't take long before spammers discover it and start sending lots of useless automated form submissions, making you have to sift through the spam to find real contact requests. At best this is just a nuisance, at worst it ends up making you miss important messages.

Now BitBalloon includes a very effective spam filter that will catch the bulk of the spammy submissions. Whenever a new form submission comes in, BitBalloon will run it through the spam filter to determine if it looks like spam. If it look spammy, we'll show the user a Captcha. Spam bots won't be able to fill out the Captcha, while real users will only ever see a Captcha if their form submission looks suspicious.

Since we put the spam filter in place, almost 30% of all the form submissions submitted has been filtered out by the spam filter, and only about 1 in thousand submissions have been wrongly flagged as spam.

<smal>Spam illustration by [Jean Pierre Gallot](http://www.flickr.com/photos/jean_pierre_gallot_69009/8456188320/#)</smal>