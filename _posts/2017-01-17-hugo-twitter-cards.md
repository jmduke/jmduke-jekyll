---
title: "Setting up Twitter Cards in Hugo"
Date: 2017-01-17 00:00:00
Tags: ["hugo"]
layout: post
---

<p>Okay, brief primer for those unaware (and, tbh, if you don’t know what Hugo is this post is probably not for you): Hugo is a super-fast static site generator (like Jekyll or Pelican) built in Go.  It’s persnickety but powerful.</p>


<p>I’m not going to go in depth into what Hugo is: <a href="http://gohugo.io/">here’s the main site</a> if you want to learn more, but this post is targeted at folks who already have a basic Hugo site up and running that want to set up Twitter Cards for their Hugo site.</p>


<p><a href="https://dev.twitter.com/cards/overview">Twitter Cards</a> are a semi-fancy name for a thing you’ve probably seen a bajillion times.  To quote Twitter themselves:</p>


<blockquote>
<p>With Twitter Cards, you can attach rich photos, videos and media experience to Tweets that drive traffic to your website. Simply add a few lines of HTML to your webpage, and users who Tweet links to your content will have a “Card” added to the Tweet that’s visible to all of their followers.</p>
</blockquote>


<p>Basically: Twitter cards are all the rich metadata attached to a tweet that shows on web, mobile, and embedded tweets.  For example, the video here is on a Twitter card:</p>


<p></p>
<blockquote class="twitter-tweet" data-lang="en"><p dir="ltr" lang="en">Connect &amp; discover: The Twitter story in 1:40 <a href="http://t.co/TRRiDAbkUR">http://t.co/TRRiDAbkUR</a></p>— Twitter Advertising (@TwitterAds) <a href="https://twitter.com/TwitterAds/status/398826034499698688">November 8, 2013</a></blockquote>


<script async="" charset="utf-8" src="//platform.twitter.com/widgets.js"></script>


<p>Obviously you can attach videos, photos, and links to tweets, but let’s focus on that last one for a second – <strong>links</strong>.</p>


<p>Notice the difference between these two tweets:</p>


<p></p>
<blockquote class="twitter-tweet" data-lang="en"><p dir="ltr" lang="en">100 Days Without the App Store - <a href="https://t.co/sws4IWbpoO">https://t.co/sws4IWbpoO</a>.</p>— Kapeli (@kapeli) <a href="https://twitter.com/kapeli/status/819592854196654081">January 12, 2017</a></blockquote>


<script async="" charset="utf-8" src="//platform.twitter.com/widgets.js"></script>


<p></p>
<blockquote class="twitter-tweet" data-lang="en"><p dir="ltr" lang="en">i wrote a small post about being proud of your tools because i saw a tweet that bothered me 🏄🏽 🌊<a href="https://t.co/goHIloU6yX">https://t.co/goHIloU6yX</a></p>— Justin Duke (@justinmduke) <a href="https://twitter.com/justinmduke/status/818843654638825472">January 10, 2017</a></blockquote>


<script async="" charset="utf-8" src="//platform.twitter.com/widgets.js"></script>


<p>Notice how they both have links, but the first one looks kinda drab and boring while the second one has a dope image?  That’s the power of Twitter Cards – and the power of a couple <code>meta</code> tags.</p>


<p>If you’re looking to have a strong social media presence, making sure your site generates awesome Twitter Cards is <em>huge</em>.</p>


<p>And it’s honestly super easy!  <a href="https://dev.twitter.com/cards/getting-started">Twitter’s docs gives you the lowdown</a> but I’ll show you the only tags you really need to worry about.</p>


<h2 id="what-you-need-for-twitter-cards">What you need for Twitter Cards</h2>


<p>This is for another blog post on this very site, my <a href="http://villageblacksmith.consulting/december-2016/">December 2016 update</a>:</p>


<pre><code>&lt;meta name="twitter:site" content="@justinmduke"&gt;
&lt;meta name="twitter:creator" content="@justinmduke"&gt;
&lt;meta name="twitter:description" content="December 2016 Update for Village Blacksmith, Justin Duke's small tech consultancy." /&gt;
&lt;meta name="twitter:title" content="Update: December 2016" /&gt;
&lt;meta name="twitter:card" content="summary_large_image" /&gt;
&lt;meta name="twitter:image" content="http://i.imgur.com/lTSHXfp.png" /&gt;
</code></pre>


<p>Let’s go through each piece one by one:</p>


<ol>
<li><code>twitter:site</code> is the Twitter account that corresponds to the site.  I just use my personal Twitter account, because Village Blacksmith doesn’t have it’s own twitter presence.</li>
<li><code>twitter:creator</code> is the Twitter account that corresponds with the writer.  Same thing there.</li>
<li><code>twitter:description</code> is a quick, one or two line description of the content that may be displayed in the card.</li>
<li><code>twitter:title</code> is the title of the content (basically the same thing that should show up in the <code>title</code> tag.)</li>
<li><code>twitter:card</code> is the <em>type</em> of card we want to display: here, we specify that we want the big ol’ image.</li>
<li>Lastly, <code>twitter:image</code> specifies the image we want displayed.</li>
</ol>


<p>All of that makes sense, right?  But, naturally, we don’t want to have to write out all of this each time, so let’s leverage the power of Hugo’s variables to handle this for us.</p>


<h2 id="twitter-cards-in-hugo">Twitter Cards in Hugo</h2>


<p>Here’s what Village Blacksmith’s meta tags <em>really</em> look like, using Hugo variables instead of actual values:</p>

{% raw %}
<pre><code>&lt;meta name="twitter:site" content="@justinmduke"&gt;
&lt;meta name="twitter:creator" content="@justinmduke"&gt;
{{ if .IsPage }}
&lt;meta name="twitter:description" content="{{ .Summary }}" /&gt;
&lt;meta name="twitter:title" content="{{ .Title }}" /&gt;
&lt;meta name="twitter:card" content="summary_large_image" /&gt;
&lt;meta name="twitter:image" content="{{ .Params.image }}" /&gt; {{ else }}
&lt;meta name="twitter:title" content="{{ .Site.Title }}" /&gt;
&lt;meta name="twitter:description" content="{{ .Description }}" /&gt; {{ end }}
</code></pre>


<p>Let’s break down each one:</p>


<table>
<thead>
<tr>
<th>Key</th>
<th>Value</th>
<th>Explanation</th>
</tr>
</thead>
<tbody>
<tr>
<td>twitter:site</td>
<td>@justinmduke</td>
<td>I just hardcoded this because I was lazy.</td>
</tr>
<tr>
<td>twitter:creator</td>
<td>@justinmduke</td>
<td>Same thing here.</td>
</tr>
<tr>
<td>twitter:description</td>
<td>{{ .Summary }}</td>
<td>A Hugo-generated content snippet for the page.  This is a standard variable and you can read more about it <a href="http://gohugo.io/templates/variables/">here</a>.</td>
</tr>
<tr>
<td>twitter:title</td>
<td>{{ .Title }}</td>
<td>The title for this page, of course!  Another standard variable, and you can read about it here.</td>
</tr>
<tr>
<td>twitter:image</td>
<td>{{ .Params.image }}</td>
<td>Params checks the <em>front matter</em> of your Hugo page for an <code>image</code> value, and plops it in here.</td>
</tr>
<tr>
<td>twitter:card</td>
<td>summary_large_image</td>
<td>We wanna have the same card type for all of our posts, so this is constant.</td>
</tr>
</tbody>
</table>

<p>The only super interesting thing here is that <code>{{ .Params.image }}</code> piece, since it’s not a builtin Hugo variable – but it’s super easy to set up!  All you need to do is specify the <code>image</code> in your Hugo post’s front matter, like so:</p>


{% endraw %}

<pre><code>---
title: "Update: December 2016"
date: 2016-12-31
image: http://i.imgur.com/lTSHXfp.png
---
(Content)
</code></pre>


<p>Lastly, once you have your Hugo site up and running with Twitter cards, you can validate that they look great using <a href="https://cards-dev.twitter.com/validator">Twitter’s Card Validator tool</a>.</p>


<hr/>


<p>That’s it!  Hugo front matter is super powerful and with this setup your static site will look <strong>great</strong> on Twitter.  Feel free to <a href="mailto:me@jmduke.com">email me</a> or <a href="http://twitter.com/justinmduke">find me on Twitter</a> if you have any questions.</p>


<p>(And, if there was any doubt – yep, this page has a Twitter card :)).</p>
	