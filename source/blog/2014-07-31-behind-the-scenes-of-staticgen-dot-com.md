---
title: "Behind the Scenes of StaticGen.com"
author: Michael Ruescher
description: "Michael Ruescher interviews Mathias Biilmann on the redesign of StaticGen and how to build a dynamic index of Github projects as a static site."
tags: ["BitBalloon", "Middleman", "Interview", "Podcast", "CMS", "Continuous Deployment"]
image: /images/posts/mathias-biilmann.jpg
---

<iframe width="100%" height="166" scrolling="no" frameborder="no" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/157332357&amp;color=0066cc&amp;auto_play=false&amp;hide_related=false&amp;show_artwork=true"></iframe><br/>

Mathias Biilmann, founder of BitBalloon, dives into details about the redesign of staticgen.com. Our listing of [the top, open-source, static site generators](https://www.staticgen.com).

He shares how he used Github's API, Gist, Middleman and Factor.io to build an always up to date, dynamic listing as a static website hosted on BitBalloon.

<!-- excerpt -->

### Transcript:

**Mike:** Hey everybody. I'm Michael Ruescher.

**Mathias:** And I'm Mathias Biilmann.

**Mike:** And this is the BitBalloon podcast number two. And today, we want to talk about the redesign of StaticGen.com.

StaticGen.com was a simple leaderboard that I created about a year ago, when Mathias and I, first were kind of thinking about building a service that was focused on just static sites. And at that time, we were also running the Webpop platform, and I said, "Okay, this is a great opportunity to kind of use what's there at Webpop, and build a simple little site that just gives me a little bit of oversight about what's going on with the static generator, open-source community."

At that time, I sort of looked at static sites as more of this quick, like HTML one-pagers, but quickly discovered that there's this whole world out there, people using static site generators to build much bigger, more interesting, complex sites. And there's hundreds of these generators out there, and a large open-source community building them. So I figured I wanted to figure out how to surface the best ones, and which ones I should be looking at, if I ever need to build those kinds of sites.

So we used the server-side extension framework that Webpop offers to write a little bit of JavaScript that basically looks at each Github repository of a generator that you add to the collection there. And basically, it pulls down the stats of how many stars, how many forks, and how many issues it has. And then puts those together into one big leaderboard, and also keeps a record for each individual generator, so you can see its progression through time.

**Mathias:** Yeah.

**Mike:** When I first put this thing together, it was pretty neat. I mean, you could very quickly see which ones were getting the most action, the most stars. And it definitely gave you a good idea of which languages were popular, and which frameworks had the most contributions going on, and the most plug-ins, etcetera.

But one thing we found out pretty quickly is that all these people who are building these generators, wanted to get on the list. So people started leaving comments in the Disqus on the site. And the problem was kind of that I was pretty busy doing other stuff, and that every time this happened, I said, "Hey, can you add this?" It would just be all this additional work. And at the same time, I also didn't really know how to represent them, necessarily. So if someone asks me to add their generator for them to our listing, it was kind of like, "Well, okay. I guess I'm just going to look at your GitHub page if I have time, and basically copy and paste what you have there, and hope that that works," right?

**Mathias:** Yeah. And you then try to, like dig up stuff that can sometimes not be completely obvious, such as what kind of templates is this generator primarily using, and so on.

**Mike:** Right. And there's all kinds of people going "Hey, can you fix this? This actually uses this kind of template, etcetera." And so it kind of became unscalable in that sense, and we really weren't set up to make this a collaborative process. And another issue that was sort of coming up with it was that we were making a ton of API requests to Github, and that was causing the site to load rather slowly at times.

**Mathias:** We had a bunch of caching underneath it, but still it's just like, just to generate the index page, there's no other way through the Github API, than to make at least one API request for each generator on that index page, and there's just no way that all of those requests were always getting cached, so load times became a real problem.

**Mike:** So this thing kind of sat around for a while, and then you decided you'd give it a refresh.

**Mathias:** Yeah. I really like the site, and I like having a place with just all the static site generators. There was an another list that came up, staticsitegenerators.net I think, and I was actually using that a bit to do research and so on, but that's great resource for, like everything in the static world, but it's just also a very large list with a lot of things on it that's not necessarily static site generators actually. Like a bunch of the stuff there is also flat file CMSs, or even hosting services. And I sort of wanted a list that was really just static site generators, and that also had some more details on each of them. And in the mean time, we launched BitBalloon and had gotten quite a bit of experience ourselves with building sites with static site generators. BitBallon.com is built with Middleman.

So I didn't actually like this whole process of having this, sort of directory with all the ratings and so on as a dynamic site. It makes a lot more sense as a static site because... it doesn't make sense that every time someone goes and see the index, we need to ask Github about all the details of all the repositories. It makes a lot more sense that just once a day or twice a day, we just run a build and find all those statistics and build the leaderboard of the day. I was thinking about that for a while, but also didn't really have the time to set up all of that. And then I ran into the guys from Factor.io, that actually started integrating both BitBalloon and Middleman into their service. And what their service does is that it's simply a deployment service, where you can, sort of use a little DSL that they've written, to plot together different types of services and data sources. And so in this case, once they had added BitBalloon and Middleman, it was easy for us to say "take a time resource and make sure that every six hours you fetch this source code from Github, and then you run the Middleman build, and then you push the result to BitBalloon". All just in five little lines of their DSL. And that's a really nice way of skipping the whole process of also having to keep tabs on some server somewhere that needs to run a crontab and so on, and just automate it all. So once I saw that that was possible, I just started to hack on a new version of static based on Middleman.

So for those who don't know, Middleman is a static site generator in Ruby that has a feel, kind of like, Rails for static sites. If you come from Rails development, you'll immediately feel very familiar with how Middleman, sort of organizes stuff, and with the Asset Pipeline of Middleman, and with the way you can use the typical template languages that you were used to from Rails, by default ERB, but you could also use HAML or the like and it's easy to create CoffeeScript and get Sass and those kind of things working. And the way a typical Middleman site works is that you have, sort of different collections of content. What each collection is just a folder with markdown files in them, and each markdown file is a piece of content with a body text and some metadata of data called frontmatter, that you write in the very start of the file in YAML.

So what I did with Middleman was making a folder with a collection of Github projects. Each project is a static site generator. There's some metadata in the beginning that just tells us what the Github repository is, what the title is, and a little short description, and the data for what language it's in, what kind of template it uses. And then there's just a body text with the description of that static site generator.

And then just from that, I could sort of start just building up the whole design of the new StaticGen. Sort of taking elements from the old one and rewriting them a bit, and making some JavaScript based filters and authoring, and just get the whole site to work as a completely normal Middleman project that would just list all the site generators I had added there.

To transition, I made like a quick little Ruby script that just fetched all the data we already had in Webpop, from the old version of StaticGen, and just put each of those into a Markdown file, and then actually just grabbed the Readme from the repository from each of them, and put it as the body text. And then I could just go in and sort of edit out the stuff that I didn't really want to have in StaticGen.com. I didn't want to have like the whole, all the set up instructions, and how to build and install and that stuff. I just edited out anything that wasn't just the pure description of what is the static site generator, what's the philosophy of it, and what's the idea of it. And then once I sort of actually kind of done most of the design and got the whole site just functioning, and got the list working, I then started to work on this little extension to Middleman that would... Like Middleman allows you to sort of hook into its representation of the pages you have in a site. So during build time, you can add all the information to those pages. So in this case, I...

**Mike:** Are you just operating on the HTML there, for the output?

**Mathias:** No. It's operating on sort of the... like each page is an object that has,  different fields: A title...

**Mike:** Got you. Right.

**Mathias:** And in the case of StaticGen,  in the projects folder, each project is a markdown file, and it then has, front end matter, where each of them has a title, a repo, a homepage, a language, a license, a list of templates, and a description. So the object I would operate on would have all of those fields.

**Mike:** Right.

**Mathias:** And that means that what the Github extension would do is that it would look at the repo field.

**Mike:** Right.

**Mathias:** And then will speak to the Github API, and fetch the data on that repo from Github, then add to that object, methods for accessing, like the number of stars, the number of forks, the number of issues. And then obviously, I could easily, include those into the page, and even with Middleman, it's easy enough to just write stuff to sort all the output, show all the repositories, but sort it by number of stars in Github. And of course, below the scenes, this has sort of the same issue as Webpop, like to build the index page, you do need to make an API request to Github for every single static site generator, to get the data. But the big difference with this flow is just that, since this happens at the build time, it really doesn't matter. I mean, it doesn't matter if it takes 15 seconds or something like that, to fetch all the data.

**Mike:** And you get what? Like 5,000 requests a day, or something, so...

**Mathias:** Yeah. And the beauty of this here is that it's just at build time, so when I run the Middleman build, it will do all these queries to Github, but then it will push the site to BitBalloon as a completely static site. And then once it's live, there are no dynamic actions going on there. So it really doesn't matter at all how many API requests we need to do, and how much work we need to do. We don't have to worry about being especially efficient or any thing, because it's really just being run once a day.

**Mike:** Absolutely.

**Mathias:** And then one thing I needed to solve was: what would I do with... like one thing we already did in the first version was to sort of keep track of... keep a little archive for each static site generator, where we could have, the historical data on how many...  making it easy to go in and see, like how is this static site generator trending at the moment? Is it getting more stars? Is it getting less stars?

**Mike:** Yeah. And that's something I added at that time because I didn't see any way in Github to kind of get this historical record, and I was thinking, you know, what's something we can add beyond what you can just see in the Github repo. So this isn't just basically reproducing what's already on Github. And so I kind of figured, well I might as well start logging this, and who knows what kind of interesting thing we can pull out of it later. As long as we have the data, it creates opportunities down the road.

**Mathias:** Absolutely. So I definitely wanted to have that as well for our static version. But of course, I have to think about, so what am I going to do? I don't want to have to run a database somewhere. I mean, I really wanted this simple system, where build could just run on Factor. Where there's actually no server somewhere running the build, it's just this service called Factor that just builds it and push it to BitBalloon. So I definitively didn't want to have to host a database somewhere, and I also just wanted to keep it really simple, for people to... I mean, one of the big ideas with doing this as a static site, apart just from the fact that it fits the model really well because you get away from the problem of having to do all those API requests in real time, it's also just ideal that the whole site can just be open-source on Github, and when people want to add a new static site generator, instead of leaving us comments and discuss and asking to do it, they can just send in a pull request and say, "Hey, here's a new static site generator." So I also wanted to make it really easy for people to be able to just download the repositories and run a Middleman build. So I also don't... I didn't want to have some weird database running, and stuff like that.

**Mike:** Right.

**Mathias:** It needed to just be really simple. So one of the things that are really nice is that, again, since this is just a process that's supposed to run once a day, you really don't have to worry about typical things, such as latency to a database, or speed, or stuff like that. You can be much more lenient with those kinds of things. So the solution that I'm using now is that, what you need to do to run Middleman in a way that stores the stats and everything, is just to set up an empty Gist. And then when you run the build, you need to have this environment variables, your access token to, an access token for the Github API, and the ID of that Gist. And then during the build, the Middleman extension will actually use the Github API to use that Gist as kind of JSON database.

**Mike:** Oh wow.

**Mathias:** So it just, like generates a big fat JSON with all the stats of the  the stats of the static site generators, and then just stores that in the Gist. So I actually have like a Gist that has like the archive for StaticGen.

**Mike:** Right.

**Mathias:** And just with the whole history of how many stats of each of these had and so on.

**Mike:** Yeah.

**Mathias:** And I mean it's not terribly efficient or anything. It's not like the recommended database solution for dynamic site for sure.

**Mike:** Right.

**Mathias:** But it's just really simple for this, and the beauty of it is that it really doesn't need to be very efficient. I mean, I can just store it and grab it, and then that Gist also kind of works as a cache. So if the data for the day is already in that Gist, we don't need to make new API requests. So in the end, it kind of speeds up also the build process a bit. But it's just also an example of how we can just do things in a different way, when you move the site generation from run time to compile time, actually.

**Mike:** Is that something you came up with yourself?

**Mathias:** Yeah.

**Mike:** Or is that something you saw somewhere else? Because I've never heard of such a thing.

**Mathias:** No. This is definitely my own... my own invention.

**Mike:** Wow.

**Mathias:** And it's working great.

**Mike:** Sure, yeah. Gist don't go away, I guess you can rely on them, right?

**Mathias:** Yeah, it's there. And the beauty is that you can even roll it back and roll it forward or whatever.

**Mike:** Perfect.

**Mathias:** Each Gist is like a little Github repository in its own way.

**Mike:** I think after this podcast, you're going to get a phone call from Github saying, "What have you done?" It's going to be the new, like hipster database.

**Mathias:** Absolutely. But I mean, I was thinking of various options, but it was just easy because the API I was working with was already Github. So I was already reading all this data from Github, so it was sort of natural that I would also just use Github as my database for writing data. But you could imagine many ways. Another option I was considering was just having a Google Doc spreadsheet with the historical data. And they also have a JSON, OAuth2-based API for that.

**Mike:** Right.

**Mathias:** So that's another thing that you can totally use for a database in these kind of static sites.

**Mike:** Yeah.

**Mathias:** But you would never really want to use as a database in a dynamic site. But again, in this case, the whole requirement... the requirements for a database change fundamentally when you just care about it, being up and being there, but you don't really care about latency.

**Mike:** Right. So let's go back to, you know, one of the things you mentioned, I think we kind of crossed over earlier, is the fact that this is now an open-source project.

**Mathias:** Yeah.

**Mike:** What are some of the implications of that now? Like what have we seen that's different from when it was just a private project on Webpop?

**Mathias:** Yeah. Obviously, the big difference is, that since we launched it we've gotten a bunch of pull requests. Where people have been... especially adding new static site generators, some corrected, some data in existing ones, and some pull requests just to help us with things, like we have some rules that used to say that it had to be open source, and under that point that it had to be accessible on Github. Someone made a really good point of, open source and "accessible on Github" being two completely different things. And made a pull request just correcting that in the rules. And it's a really awesome flow, actually. You just get a pull request with a new static site generator. You can just go in and look it over. And then if everything is fine with that pull request, I just merge it in. Then Factor will pick up that there's a new commit to staticgen, and it will just run the build. And once it's done, it will deploy to BitBalloon. So it makes the whole process of having people contribute and getting new static site generators added and then making sure that the information we have on the static site generators are up to date, really smooth and really easy, and very collaborative.

A great example also of how nice this kind of process can be, is also that, again, since the end result is always just a static site, and due to the way BitBalloon works, where we really have atomic deploys and so on. I didn't have to worry at all when we were on the front page in Hacker News, and a bunch of pull requests were coming in, about just merging those in and let Factor deploy it. I'm sure that if this had been more of a dynamic site, I would have been a little more nervous of sort of tampering with it while it was getting tons of traffic. But it's a nice bonus now that you can just do this, then the new version will just roll out once the build has been working fine and everything is good.

**Mike:** So as you were considering what to rebuild the site in, you obviously ended up with picking Middleman, are there any other generators that caught your eye?

**Mathias:** Yeah. I mean, I've lately been diving into various of them, and it's such an interesting field just because there are more and more of them coming out all the time. And one of the nice things is that you can sort of pick very much, based on what kind of project you're making. And a lot of them will have different strong points.

I could have considered Jekyll as well. That's obviously one of the default choices, and it's really nice as well and it's quite easy to make plug-ins for as well. It just doesn't have as much of a... like a nice thing with Middleman is this way that it has an idea of this sitemap that your extensions can interact with, that made it a really good fit for this because I just wanted to sort of add stuff to that sitemap. And with this project, I was also just pragmatic, and since we already built BitBalloon that common Middleman I was familiar and it was easy to jump into.

**Mike:** Right.

**Mathias:** Some of the other like... there are also static site generators that are more suited to specific things like,  Assemble is a nice grunt-based static site generator. I know that, for example, the guys from ZURB use it to build foundation's documentation with. But it's not like, as simple as... in my opinion, it's not very good for anything with more of a content model or something like that. But it's really nice that it's just like it integrates into Grunt. So Assemble is great for building documentation and stuff like that, for project where you already have your Grunt file and everything, you can just likehook in a little static site generator to build part of the project as a static site.

**Mike:** That makes sense.

**Mathias:** I've been looking quite a bit on Hugo lately.

**Mike:** Oh yeah.

**Mathias:** And it looks really interesting. It's one of the new Go-based static site generators. And that's kind of like, it has some... just being Go, it's just a download. It doesn't have any dependencies and so on. And of course Go is really fast, and it looks like it has a really interesting model as well. So that's one of the ones I'm sort of following with interest. And then apart from that, it's also really like, the nice thing with static site generators, that there are several in just about any language you want. So for many projects, picking a static site generator is also just a question of, what languages are we already using. If people are using Python and Django, it will probably be obvious to pick something like Cactus that, just like Middleman, sort of feels like a Rails for static sites, then Cactus sort of feels like a Django for static sites.

**Mike:** And I see that Pelican is consistently in the top three of static site generators. Python.

**Mathias:** Yeah. Pelican is also sort of one of those that's been around for a long time. Like just about as long as...

**Mike:** Imports from WordPress.

**Mathias:** Yeah. It's also cool.

**Mike:** Nice. What do you think motivates people to make all these generators? I mean, there's hundreds of them out here.

**Mathias:** Yeah. I think there's a lot of different motivations. I think, in general, every developer at some point has made their own blogging engine. And with static site generators, it's a little the same. A lot of people will just start saying, "I'm a developer, I want my own site. I want it to generate some way, so let me just build my own static site generator and generate it". So a bunch of them are like very personal projects, with just like, "Okay, I'll do this to scratch an itch" And then some of those gets popular with a lot of people. Then you can see that some of them are more architected. Some of them comes out of... like Cactus came out of an agency... Assemble really came out of this idea, of let's just use Grunt and create some grunt helpers help us that can basically build static sites from a directory. And then there's also just the fact that some of them are focused on different things. Jekyll was from the start, like really focused on blogging, and just made it really simple to make a static blog. Whereas others are much more based on building landing pages, or documentation. And of course, once Jekyll came out, there was also a bunch of them that people built to have something like Jekyll, but in their language of choice.

**Mike:** Absolutely. Yeah, there's quite a few of those.

**Mathias:** Yeah. Which makes sense. I mean, it's one of the reasons for building BitBalloon in a way that this process just makes a lot of sense, where you don't, move all the building to the compile time side of things. And then you use something like BitBalloon to just deploy them.

**Mike:** Yeah.

**Mathias:** And all the choice around, like what kind of tools and workflow, and so on, do we want to use? Well, it really doesn't matter. I mean, it's just what suits you best during the compile time phase. And if you use, if you're a start up and you're building a tech product, I imagine that it would always makes the most sense to have the static site generator that was as similar as possible to the stack you're already using to build your technology with.

**Mike:** So I've got one last question for you while I got you on the horn here. So one thing I've been kind of... I've got a few friends that are photographers, and I've seen their solution. They're not web developers, and they ended up with some sort of plug-in on their WordPress site, to serve their photography. But it's basically like killing them. Like their site just kind of grinds to a halt as soon as they get traffic. And I've really been thinking that a static site on BitBalloon would be the ideal solution for them. The only kind of disconnect is, that they're not hackers, they've never run a command line. But I feel like they would cross that chasm if they could get a result, where they could just kind of like load a folder of files in, and that would sort of create a new, tab or thing of photos that people can check out. Basically a new post, right? And so I don't know if you've looked into this, or just through your perusing of these generators. If you have one that sort of stands out. I mean, you could probably do something like this with Middleman, I would assume.

**Mathias:** Yeah. But actually, it's a fun question because one of the pull requests we got for StaticGen after we launched was a very unknown, like it just has two stars on Github, a small static site generator called ThumbsUp that basically does that. It's actually... I haven't really tried it, but it looks like it's really cool idea. The input is just a directory, where for each photo album you just have  photos, and then you just run one command line, and it will build you a photogallery website with different albums, and so on.

**Mike:** Yeah, right on. This might be it.

**Mathias:** So that's definitively a good starting point, I think. And it's something I only know about because we got that pull request for Static Gen.

**Mike:** So that'll be one to explore. I'll give it a star right now.

**Mathias:** Yeah. I'll give it one as well.

**Mike:** Well, right on man. This has been really fun. I hope that people learned a little something, and definitely check out [StaticGen on Github](https://github.com/bitballoon/staticgen), if you're curious. All that how it works, pull it down.

**Mathias:** Yeah. Send pull requests!

**Mike:** Absolutely. And I will catch you guys next time.
