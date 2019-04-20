---
title: "In praise of bloat"
Date: 2017-07-01 00:00:00
Tags: ["development"]
layout: post
---

<p>Ben Sandofsky, the creator of <a href="http://halide.cam/">Halide</a> (and erstwhile lead of Twitter’s iOS/Mac apps) wrote a worthwhile piece about <a href="https://blog.halide.cam/one-weird-trick-to-lose-size-c0a4013de331">getting his new app’s size to a mere 11MB</a>.  <sup class="footnote-ref" id="fnref:2"><a href="#fn:2" rel="footnote">1</a></sup> There are a bunch of solid, universal pieces of advice (don’t create your own layout engine; compress and catalog assets), some trickier ones (avoid library bloat; eschew analytics), and a questionable kicker:</p>


<blockquote>
<p>There really is one weird trick to lose size: focus on your customers.</p>
</blockquote>


<p>I am skeptical about this last point in much the same way I am skeptical of folks saying the best way to lose weight is to eat healthy foods: well, sure, but what does that look like in practice?</p>


<p>Obviously focusing on your customers is very good, but I don’t think the truism of <strong>customer needs is paramount</strong> necessarily translates to <strong>slimming down your app is paramount</strong>.</p>


<p>This piece reminded me of an experiment Segment did last October, where they <a href="https://segment.com/blog/mobile-app-size-effect-on-downloads/">bought a random app and experimented with the app size to see how it affected downloads</a>:</p>


<p><img alt="" src="https://assets.contents.io/asset_YgHf1uEe.png"/></p>


<p>The first data point is insignificant (you can’t meaningfully compare download numbers between 2012 and 2016), but the latter three are pretty interesting, and suggest a linear (albeit tenuous) relationship between app size and install rate, to the tune of <strong>each megabyte costing the developer 0.45% of conversion rate.</strong></p>


<p>That’s non-trivial!  But if you’re an indie developer (or even just a pragmatic one), you have so much on your plate.  You’ve got to build out features, you’ve got to iron out bugs, you’ve got to build out a marketing pipeline.  All of these things are important, and some of these things might be solveable with a library or framework, which frees up your time to work on (potentially more important) other things.</p>


<p>Let’s take a completely arbitrary and abstract example of what I’m saying.</p>


<p>It’s four weeks before launch and you unexpectedly have a week of slack time.  You can do one of these two things with your free time:</p>


<ul>
<li>Removing a 5MB library and replacing it with a home-brew version (bumping up install rate by, according to Segment, ~2.5%)</li>
<li>Implementing a feature that bumps up install rate by 5%</li>
</ul>


<p>The choice should be obvious, right?</p>


<p>Obviously nothing’s this clear cut: you’re never deciding between two things, you’re deciding between twenty things, and the time and value of these tasks are never quite as apparent as you’d like them to be.</p>


<p>But if you’re a small developer, every task you work on is a question of ROI: you only have so many battles you can pick.  Sometimes fighting bloat is the right choice (and hey, it lets you write blog posts about how you fought bloat, which always makes for good marketing); sometimes it’s not. <sup class="footnote-ref" id="fnref:1"><a href="#fn:1" rel="footnote">2</a></sup></p>


<p>I am skeptical that fighting app bloat is always the battle worth picking, but I think we can all agree that it’s at least a battle worth <em>considering.</em></p>


<p></p>


<div class="footnotes">
<hr/>
<ol>
<li id="fn:2">Halide is great, by the way.  I really love the app.
 <a class="footnote-return" href="#fnref:2"><sup>[return]</sup></a></li>
<li id="fn:1">One caveat to this entire thing: I think the drop-off from hitting 100MB is definitely worth fighting for, since after 100MB users can’t download your app over cellular data.
 <a class="footnote-return" href="#fnref:1"><sup>[return]</sup></a></li>
</ol>
</div>
	