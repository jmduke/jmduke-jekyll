---
Title: "Coalesce"
Date: 2015-01-28 00:00:00
Tags: ["projects"]
---

<p>I made a theme for Tumblr!  It is called <a href="coalescetheme.tumblr.com">Coalesce</a> and I’m fairly proud of it.  It’s running live on my <a href="jmduke.tumblr.com">own thing</a> and open source on <a href="https://github.com/jmduke/Coalesce">GitHub</a>.</p>


<p>I’m not actually convinced that there’s any real pragmatism associated with this: there are approximately thirty thousand active themes, the vast majority <sup class="footnote-ref" id="fnref:1"><a href="#fn:1" rel="footnote">1</a></sup> of which are free.  Furthermore, the biggest chunks of browsing Tumblr happen in the dashboard on mobile, neither of which are privy to the actual custom theme.</p>


<p>Still, it was a fun exercise and gave me an excuse to work on some of my front-end skills.</p>


<p>The process of creating a theme is pretty straightforward: if you’ve used Jinja, Liquid, or ERB, you won’t really see any surprises: it’s a matter of inserting contextual tags with the <code>{ TagName }</code> format.  (You can also create arbitrary variables and have them exposed to the user, which is nice.)</p>


<p>To their credit, Tumblr does a great job of exposing what little documentation is needed: their <a href="https://www.tumblr.com/docs/en/custom_themes">main tag writeup</a> and <a href="https://www.tumblr.com/docs/en/theme_submission_guidelines">submission guidelines</a> should be plenty.</p>


<p>There were only two stumbling blocks I encountered that weren’t answered by either:</p>


<p>First, inline JavaScript that relies on the assumption that posts are rendered is pretty wonky.  I wanted to hide all note count labels that were zero <sup class="footnote-ref" id="fnref:2"><a href="#fn:2" rel="footnote">2</a></sup> but I ended up having to embed it in a bunch of <code>onReady</code> blocks.</p>


<p>Second, I spent a couple hours trying to figure out why Tumblr was complaining about <strong>Invalid Theme HTML</strong>.  Turns out you need a bunch of custom tags or else it’ll fail to validate:</p>


<ul>
<li><p><code>{RSS}</code></p></li>
<li><p><code>{Favicon}</code></p></li>
<li><p><code>{CustomCSS}</code></p></li>
<li><p><code>{LinkOpenTag}</code></p></li>
<li><p><code>{MetaDescription}</code></p></li>
<li><p><code>{PhotoAlt}</code></p></li>
</ul>


<p>Anyway, that’s all I have to say about <strong>Coalesce</strong>.  Check it out live <a href="http://jmduke.tumblr.com">here</a>.</p>


<div class="footnotes">
<hr/>
<ol>
<li id="fn:1">I’m assuming here, but I also am uber curious about what that economy actually looks like.  I can’t imagine the market for premium Tumblr themes is anywhere as lucrative as, say, WordPress or Shopify.
 <a class="footnote-return" href="#fnref:1"><sup>[return]</sup></a></li>
<li id="fn:2">Seeing <strong>0 notes</strong> is a serious cut on my self-esteem, okay?
 <a class="footnote-return" href="#fnref:2"><sup>[return]</sup></a></li>
</ol>
</div>
	