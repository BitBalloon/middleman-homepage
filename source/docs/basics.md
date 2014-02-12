---
layout: docs
title: The Basics
position: 2
---

## The Basics

BitBalloon deploys static sites from your local development into production in a single "site aware" step. When you deploy a site, BitBalloon automatically optimizes all the CSS, JavaScript & images your site references.

It also sets up a database to process any submissions to forms in your HTML.

There are two ways to deploy a site:

 1. Drag it onto a drop-zone
 2. Make a call to the API

When a site is first deployed, a public URL is generated for it. Here's the url of our demo site: [http://cowboy-system-73843.bitballoon.com](http://cowboy-system-73843.bitballoon.com)


### The Dashboard

Every site has its own dashboard which can be accessed from a url similar to:
https://www.bitballoon.com/sites/cowboy-system-73843

It provides tools for managing various aspects of your site, such as:

* deploys
* site name
* custom domain
* form submissions
* password protection
* footer code snippets


<a name="form-handling"/></a>
### Form Handling

Here's an example of a regular web form that will automatically work on BitBalloon.


```html
<form name="signup" action="thank-you.html">
  First Name: <input type="text" name="first_name">
  Email: <input type="email" name="email">
  <button>Sign me up</button>
</form>
```

The <strong>name</strong> attributes on the form and input tags tell the database how to label the data.

The <strong>action</strong> attribute on the form tag specifies a url path to show a custom success page when the form is submitted. Use a full path with a .html suffix file to easily test out your form success page in local development. When you deploy the site, BitBalloon will automatically "prettify" the url.

If the form action is left blank, or the html page you are pointing it to does not exist, a default BitBalloon form success page will be shown.

Form submissions are accessible from the "Forms" tab in your site dashboard. Here you can also setup email notifications and export the form submissions as a .csv file.

As with every other BitBalloons feature, form submissions are accessible from the <a href="https://github.com/BitBalloon/bitballoon-api">API</a>. Checkout our <a href="/docs/zapier">Zapier integration</a> to connect your BitBalloon forms to hundreds of useful cloud services without doing any programming!


### Custom 404 Pages

To configure a custom 404 page, just make sure your site folder has a file called `404.html` in the root. This page will be used whenever there's a page not found.


### Redirects and Rewrite Rules

You can configure redirects and rewrite rules by adding a `_redirects` file in the root of your site folder. The simplest possible `_redirects` file is just a list of redirects like this:

/news /blog
/some/old/url /the/new/url

Read the [Redirects and Rewrite Rules](/docs/redirects_and_rewrites) guide for all the details on what the `_redirects` can do.


### Snippets

Code snippets can be injected into the footer of every page of a site. The snippets can be premade templates for popular 3rd party scripts like Google Analytics or your own custom code.


### Versions

Every time a site is updated, a new version is created. The "Versions" tab in your site dashboard lets you view and rollback to any version, anytime.