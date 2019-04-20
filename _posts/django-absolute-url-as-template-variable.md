---
title: "Getting the current absolute URL as a Django variable"
Date: 2016-02-08 00:00:00
Tags: ["django"]
layout: post
---

<p>A quick snippet that may save you some time, as it did this evening:</p>


<p>For blog posts like this and recipes like <a href="/recipes/Manhattan">this</a>, I wanted to add a nice little sharing snippet for Twitter and Facebook for the rote and boring social media/marketing reasons.  (It’s on the bottom of this page.)</p>


<p>I’m not a huge fan of using the standard share buttons that Facebook and Twitter provide: they involve frontloading either an iframe or an external script and break up the aesthetics of the page.</p>


<p>So the answer was just to create a basic link – but you need to seed it with a URL to actually create the link.  This is trivial to do with javascript, but I didn’t want to rely on something client-side since it seems like Django should be able to provide this in the template context.</p>


<p>Turns out they do, and its out of the box!  All you have to do is hit up <code>{{ request.build_absolute_uri }}</code>.</p>


<p>So something like this:</p>


<pre><code>&lt;a href="https://getpocket.com/save?url={{request.build_absolute_uri}}"&gt;save it on pocket&lt;/a&gt;
</code></pre>


<p>Resolves to this:</p>


<pre><code>&lt;a href="https://getpocket.com/save?url=https://getbarback.com/recipes/manhattan"&gt;save it on pocket&lt;/a&gt;
</code></pre>


<p>Hope this saves you some time!</p>
	