---
title: "Forklet: Editable Web Snapshots"
author: Michael Ruescher
description: Introducing the Forklet Chrome extension, fork any page on the web!
image: /images/posts/forklet.png
tags: ["Forklet", BitBalloon"]
---

Whether you're prototyping a site with the web inspector taking a screen-shot is often not enough. Wouldn't it be great if you could take a code snapshot instead?

Introducing [Forklet](http://forklet.com/), a chrome extension that will clone whatever page you are viewing in Chrome and deploy it to BitBalloon. Forklet, doesn't snapshot an entire site, just the page you are viewing.

<!-- excerpt -->

Once you have your snapshot, you'll get a simple on-site editor for making changes to text & images on the page. When you click "Save" any edits you made to the HTML, including inline CSS edits you made with the Chrome Inspector, will persist.

When you're done editing the page, you can share the public generated URL of your snapshot with whoever you like.

We built Forklet over the weekend at this years Launch Hackathon, and the actual snapshotting of websites is still highly experimental. But it's a great demonstration of how the BitBalloon API can power site publishing and simple HTML editing tools in 3rd party apps.

Forklet is an open source project. You can checkout the repo to learn more about how it works. E.g how the on-site script [saves HTML changes](https://github.com/BitBalloon/forklet/blob/master/src/coffee/on-site.coffee#L127).

We hope you enjoy Forklet! It's an awesome tool to quickly prototype a new look or work on the messaging of a page. Since you can fork a fork, you can easily create multiple variations that each have a unique url. The best part is how easily you can share the url with your friends & co-workers.

It's also great for bug reports & pranks!

![Forklet i #1](/images/forklet-best.png)