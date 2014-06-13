---
title: "Draft Deploys"
author: Mathias Biilmann Christensen
description: "BitBalloon lets you upload a draft deploy and publish it once it's been verified"
tags: ["API", "Features", "BitBalloon"]
image: /images/posts/draft-deploys.png
---

![Deploy Drafts](/images/posts/draft-deploys.png)

Today we're launching a new API feature that'll give you a bit more control over the deployment process, by allowing you to mark a deploy as a draft.

<!-- excerpt -->

A draft deploy won't automatically get published once all the uploaded assets have been prepared on the CDN and processed for max performance.

Instead you'll be able to view the deploy on it's deploy url and then publish it once you've verified that everything looks right.

Here's some small code examples based on the Ruby API client:

```ruby
site = client.get("my-site-id")
deploy = site.deploys.create(:dir => "/path/to/my/folder", :draft => true)
deploy.wait_for_ready

# Verify that everything looks right on deploy.deploy_url before publushing

deploy.publish
```

If you're deploying a single page app, a great usecase for this would be to run an integration test suite against the BitBalloon deployed page as part of a continous deployment process, and only publish the deploy if all tests pass.

If you're doing work for a client, this can be a great way to let your client validate a new version before publishing.
