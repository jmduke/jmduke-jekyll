---
Title: "App sizes are under control, they just aren't under scrutiny"
Date: 2017-08-01 00:00:00
Tags: ["development"]
---

<p>I wrote at the first of last month <a href="http://jmduke.com/posts/in-praise-of-bloat/">about bloat in apps</a>, in response to a <a href="https://blog.halide.cam/one-weird-trick-to-lose-size-c0a4013de331">thoughtful piece by Ben Sandofsky</a> about how he minimized bloat in Halide.</p>


<p>I had some misgivings with the post and the ideas it espoused — namely, that “bloat is bad” is a reductionist truism — but still admired the approach Sandofsky took and the clear tradeoffs and sacrifices he discussed.</p>

<!--more-->

<p><a href="https://trevore.com/blog/posts/app-sizes-are-out-of-control/">This post by Trevor Elkins</a> making the rounds today has the same message, though it lacks the nuance and pragmatism:</p>


<blockquote>
<p>As app developers, we should be more conscious of the space we use. Take some time to remove the cruft that builds up and push back against needless waste.</p>
<p>So really, how does an app that occasionally sends me a connection request and recruiter spam take up 275MB? Maybe I’ll do an analysis at some point, but for now it’s deleted.</p>
</blockquote>


<p>Trevor works for Kayak, whose <a href="https://itunes.apple.com/us/app/kayak-flights-hotels-cars/id305204535?mt=8">iOS app</a> weighs in at 176 MB.</p>


<p>Perhaps Trevor is actively working on reducing the size of the app bundle, in which case he knows how difficult it is to make decisions like <em>do we spend two weeks reimplementing this framework or just eat the 5MB it adds to our final app size</em>?</p>


<p>Or perhaps he isn’t, but he’s talked with fellow Kayak engineers who have determined that the bloat is worth the cost — maybe they’ve got a lot of high-resolution assets, or have decided that the development velocity a framework-heavy approach enables is worth the drop-off in installs.</p>


<p>Or perhaps he didn’t even know Kayak’s app size is so large in the first place, because it’s a factor that doesn’t impact the majority of users after the initial download. <sup class="footnote-ref" id="fnref:1"><a href="#fn:1" rel="footnote">1</a></sup></p>


<p>Either way, it’s kinda shitty to insiniuate that an app is bloated due to incompetence; it’s kinda shitty to insiniuate that an app is bloated due to indifference.</p>


<p>Everything is a trade-off.  Some companies don’t think it’s worth it to slim down their bundle sizes; some companies do.  It’s disingenuous to pretend otherwise.</p>


<p>(For what it’s worth, I think the Kayak iOS app is great.)</p>


<p></p>


<div class="footnotes">
<hr/>
<ol>
<li id="fn:1">Which isn’t to say that it doesn’t impact users — it’s to say that the surface area of the impact is pretty small.
 <a class="footnote-return" href="#fnref:1"><sup>[return]</sup></a></li>
</ol>
</div>
	