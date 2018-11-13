---
Title: "Liquid trinkets"
Date: 2015-07-30 00:00:00
Tags: ["development"]
---

<p>I’ve been messing around with a lot of Shopify development the past couple months.  It’s a pretty neat platform that I want to talk about more in depth at some point in the future, but the number one cause of frustration <sup class="footnote-ref" id="fnref:1"><a href="#fn:1" rel="footnote">1</a></sup> is dealing with <a href="http://liquidmarkup.org/">Liquid</a>, their in-house template rendering engine which seems to pride itself on straddling the line between “holy shit this is awesome” and “holy shit why can’t you do this basic task.”</p>


<p>Below is a smattering of one-liners and helpful patterns/tricks to do common things with Liquid.  Feel free to <a href="mailto:me@jmduke.com">email me</a> if you have more – I’ll be updating this post as I find more useful stuff.</p>


<h3 id="instantiating-arrays-with-assign">Instantiating arrays with <code>assign</code></h3>


<p>The grossest – and easiest – way of doing this to my knowledge is using the <code>split</code> command on a delimited list.  Like so:</p>


<pre><code>{% assign anArray = "orange,blue,crimson" | split: "," %}
{% for item in anArray %}
  {{ item }}
{% endfor %}
</code></pre>


<p>Which, should compile to:</p>


<pre><code>{{ orange }}
{{ blue }}
{{ crimson }}
</code></pre>


<h3 id="adding-or-removing-from-a-date">Adding or removing from a date</h3>


<p>Basically – get a given timestamp (in this example, <code>{{ 'now' }}</code>, which returns the current timestamp), convert it into unix time, and then add or remove milliseconds from that and recast it into a date.</p>


<p>This, for example, would go back a week from right now:</p>


<pre><code>{{ 'now' | date: "%s" | minus : 604800 | date: "%b %d, %Y" }}
</code></pre>


<p>Whereas this would jump forward a month <sup class="footnote-ref" id="fnref:2"><a href="#fn:2" rel="footnote">2</a></sup>:</p>


<pre><code>{{ 'now' | date: "%s" | plus : 2592000 | date: "%b %d, %Y" }}
</code></pre>


<p>(The final result is a parsed date, so you can do the <a href="https://docs.shopify.com/themes/liquid-documentation/filters/additional-filters#date">standard</a> stuff with it at that point.)</p>


<h3 id="getting-more-than-ten-search-results">Getting more than ten search results</h3>


<p>Just wrap everything in a <code>{% paginate %}</code> block:</p>


<pre><code>{% paginate search.results by 9999 %}
  // All of your actual search.liquid code.
{% endpaginate %}
</code></pre>


<p>As one might expect, this basically “breaks” pagination, which is generally a UX win for user discovery anyway.  Instead of just throwing the first ten search results out there, you’ll grab up to <code>9999</code> <sup class="footnote-ref" id="fnref:3"><a href="#fn:3" rel="footnote">3</a></sup>.</p>


<h3 id="pinterest-complaining-about-invalid-data-uri">Pinterest complaining about “invalid data uri”</h3>


<p>Okay, this isn’t even a Liquid issue exactly, just a Shopify one.  If you’re constructing images using Liquid tags so that it gets picked up by the Shopify CDN, which is (generally) a great idea, it might look something like this:</p>


<pre><code>{{ product.featured_image | product_img_url: 'grande' }}
</code></pre>


<p>So setting the image metadata for the page might look something like this:</p>


<pre><code>&lt;meta property="og:image" content="{{ product.featured_image | product_img_url: 'grande' }}" /&gt;
</code></pre>


<p>This resolves to Shopify’s CDN, which is dope for same-domain stuff, making it look like something like this:</p>


<pre><code>&lt;meta property="og:image" content="//cdn.shopify.com/s/files/1/0270/4491/products/quote-5-2_grande.jpg?v=1431971498" /&gt;
</code></pre>


<p>The problem here is that if Pinterest tries to pick that up, it can’t resolve the <code>//cdn</code> part of the equation since it’s on a different domain.  The clumsy but easy way to fix this is to just prefix the whole thing with <code>http:</code> –</p>


<pre><code>&lt;meta property="og:image" content="http:{{ product.featured_image | product_img_url: 'grande' }}" /&gt;
</code></pre>


<p>There are more elegant ways to fix this problem then just hard-coding in the protocol, but you get the basic idea.  Hope this saved you a bunch of random adding-and-removing of <code>GET</code> parameters!</p>


<div class="footnotes">
<hr/>
<ol>
<li id="fn:1">Well, besides the  local development options (and lack thereof.)  It would <em>hugely</em> benefit from a Wordpress-esque local staging solution.
 <a class="footnote-return" href="#fnref:1"><sup>[return]</sup></a></li>
<li id="fn:2">Okay, not a month <em>exactly</em>, just thirty days.  But you get my point.
 <a class="footnote-return" href="#fnref:2"><sup>[return]</sup></a></li>
<li id="fn:3">Or some other suitably large number.
 <a class="footnote-return" href="#fnref:3"><sup>[return]</sup></a></li>
</ol>
</div>
	