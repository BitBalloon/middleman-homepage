---
title: "Best of Both Worlds: A CMS for Static Sites"
author: Mathias Biilmann Christensen
description: "Lightning fast static sites with a powerful CMS: it's the best of both worlds!"
tags: null
---

What if you could get the best of both worlds?

Static websites are awesome. They're super fast, they basically never go down, they're cheap to scale, they are very secure and don't require any maintenance or security updates once they are live.

Static site generators makes static sites even more awesome! As developers we get a powerful asset pipeline, we get all the benefits of includes and layouts that we're used to from dynamic sites. We can write the content in Markdown from our text editor of choice and everything is just flat files in version control. No binary blobs stored in a database.

There's a catch though: typically we need non-coders to work on our sites as well. We need our marketing guy to update the blog, we need HR to update the team page, etc, etc.

Out with the static site and in comes Wordpress. Welcome malware infections, hello PHP, hi there good old database, hola security updates, goodbye flat-files and farewell performance :(

Stop! It doesn't have to be like this! This blog post is written with a brand new CMS that works with most static site generator and can be used by anybody (my dad use it for his website!).

Say hello to Netlify CMS - a whole new approach to content management.

With Netlify CMS you build your site with your static site generator of choice. You then setup a simple YAML configuration file describing the structure of your site, and then Netlify CMS gives your content editors are clean and beautiful writing experience that plugs into Github.

They'll work straight from their browsers with a user-friendly UI, but behind the scenes they're actually making Git commits! Pretty awesome, right?