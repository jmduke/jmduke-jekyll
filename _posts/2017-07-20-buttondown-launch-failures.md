---
title: "Everything I got wrong with Buttondown's launch"
Date: 2017-07-20 00:00:00
Tags: ["buttondown","projects"]
layout: post
---

<p>I want to do an earnest, thorough analysis of <a href="https://buttondown.email">Buttondown’s</a> launch at some point in the future: what the traffic was like, conversion rates, et cetera.  (Truth be told, I haven’t even looked at those numbers yet — there were a bunch of visitors, there were a bunch of signups, and that’s pretty much all I know because I’ve been so in the weeds with work the past week and a half.)</p>


<!--more-->

<p>That’s not what this post is, though that post is coming!  Instead, I wanted to talk about the question that I always wished more people talked about during launch postmortems:</p>


<p><strong>Where did I mess up?</strong></p>


<p></p>


<p>And oh man, there are so many answers:</p>


<ol>
<li><strong>I didn’t do any automated lifecycle emails.</strong>  (I thought about it, but I decided it wasn’t necessary and I could do all of the welcome emails manually.). Holy shit this was a bad idea — as soon as the registrations started rolling in I got lost in the deluge and failed to reach out very quickly.  You can’t manually send hundreds of emails a day. <sup class="footnote-ref" id="fnref:1"><a href="#fn:1" rel="footnote">1</a></sup></li>
<li><strong>I broke my analytics stack.</strong> I didn’t audit my analytics stack particularly thoroughly.  I’m using <a href="fullstory.com">FullStory</a> and <a href="https://segment.com">Segment</a>.  Both are great: both had a 1K events/mo hard cap.  That’s fine for the short term (especially because the next price tier after “free” is <em>non-trivial</em>, to put it mildly), but it means I lost the lions’ share of events.</li>
<li><strong>I shipped some critical path bugs.</strong> Registration was straight up broken for like…. Five hours on the fourth day after launch, because I added some server-side email validation with <a href="https://mailboxlayer.com/">Mailboxlayer</a> and I was parsing the responses incorrectly.</li>
<li><strong>I had shitty alarming.</strong> I didn’t even know registration was broken until someone emailed me about it because my alarming was improperly configured.</li>
<li><strong>I didn’t have a thorough plan.</strong> I didn’t really have a rollout strategy beyond “have a friend post on HN and PH”  and maybe tweet about it a little. <sup class="footnote-ref" id="fnref:2"><a href="#fn:2" rel="footnote">2</a></sup>. I <em>still</em> don’t really have a post-launch strategy beyond “put out all the fires”.</li>
</ol>


<h3 id="despite-all-this">Despite all this…</h3>


<p>Like, I’m probably only scratching the surface of stuff I <em>could</em> or <em>should</em> have done.  And looking at it in numbered list format, it seems like it was a catastrophe.</p>


<p>But the launch went really well!  It could have gone better, sure, but it could have gone much worse:</p>


<ul>
<li>I have hundreds of new users.</li>
<li>They all seem reasonably happy, even with the rough edges.  (It is <em>wild</em> to get so many positive comments.)</li>
<li>The app is in much better shape than it was two weeks ago.</li>
</ul>


<p>I guess what I’m saying is that even though I messed up a lot, it was definitely the right time to launch and it went well: and, even if things go awry, they probably won’t go <em>too</em> awry.</p>


<p>Anyhoo, back to bugfixes.</p>


<div class="footnotes">
<hr/>
<ol>
<li id="fn:1">Literally, you can’t.  G Suite will stop you after a certain point.
 <a class="footnote-return" href="#fnref:1"><sup>[return]</sup></a></li>
<li id="fn:2">Thanks, <a href="https://twitter.com/iheanyi">Iheanyi</a>.  (Naturally, he has a <a href="https://buttondown.email/iheanyi">newsletter</a>.)
 <a class="footnote-return" href="#fnref:2"><sup>[return]</sup></a></li>
</ol>
</div>
	