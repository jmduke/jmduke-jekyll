---
Title: "Time is money, friend"
Date: 2017-02-23 00:00:00
Tags: ["personal"]
---

<p><a href="https://cushionapp.com/running-costs/">Cushion, a SaaS for freelancers</a>, has a transparent log of its running costs and expenses that recently got posted to HN and spun up a lot of <a href="https://news.ycombinator.com/item?id=13688844">positive discussion</a>.</p>


<p>(This page has been around for at least a year, and I think it’s <em>awesome</em> – it’s what inspired me to similarly start tracking expenses for <a href="http://villageblacksmith.consulting/january-2017/">Village Blacksmith</a>.)</p>


<p>One of the fairly common discussion points on the post was about how the accumulation of so many ‘small’ costs – in the $10-$50 a month range – can add up to such a substantial amount.</p>


<p></p>


<p>One commenter wrote:</p>


<blockquote>
<p>This info is actually very useful for me as it confirms my (rational) fear of accumulating expenses. It’s way too easy to just spend $10-$50 here and there and before you know it you are spending $1000 a month, while the core service is still running on a single triad of web-server/worker-server/database-server combo with no redundancy.</p>
</blockquote>


<p>To which another replied:</p>


<blockquote>
<p>I literally use none of any such paid services. Zero. It’s really not that hard. Just automate what can be automated.</p>
</blockquote>


<p>As someone who’s starting to accumulate these costs in the processing of spinning up ‘legitimate’ businesses, I don’t love this line of thinking.</p>


<p>It’s true that a lot of common paid services can be spun up by a developer rather than vended as a SaaS.  I’m talking about things like:</p>


<ul>
<li>email marketing like <strong>MailChimp</strong></li>
<li>user analytics (and analytics analysis) like <strong>Segment</strong> and <strong>Google Analytics</strong></li>
<li>logging and exception tracking like <strong>Sentry</strong> and <strong>BugSnag</strong></li>
<li>support platforms like <strong>Intercom</strong></li>
<li>basic surveys and customer insights like <strong>TypeForm</strong></li>
<li>web hooks and automation like <strong>Zapier</strong></li>
<li>revenue analytics like <strong>ChartMogul</strong></li>
</ul>


<p>None of these are particularly technically challenging, on the surface.  They’re definitely not trivial to implement, but there are no prohibitively complex barriers that stops a developer from rolling their own solution to the problem.</p>


<p>So why shouldn’t you create your own solution to these problems?</p>


<p>Hell, I’ll take the simplest example I can think of: <a href="http://briefmetrics.com">BriefMetrics</a>, a simple (and lovely) service I use that sends me weekly digests of Google Analytics data.  The data isn’t subject to any complex analysis or munging: it just saves me the effort of having to dive into the labyrinthine Google Analytics dashboard to grab the data I care about.</p>


<p>Two notes about the cost of this service:</p>


<ul>
<li>This service saves me around five minutes a week.</li>
<li>This service costs me $10 a month, so over three years it’ll cost me $360.</li>
<li>This service – for my uses – is easily replaceable with, like, fifty lines of Python. A hundred, tops.</li>
</ul>


<p>So why haven’t I written my own version of it, and lowered my expenses?</p>


<p>I know I could spend maybe two hours <sup class="footnote-ref" id="fnref:1"><a href="#fn:1" rel="footnote">1</a></sup> writing a replacement for it and set it on an EC2 host and probably never worry about it again.</p>


<p>I value my time at $200 an hour.  (In fact, I value my time a little more than this, but $200 is a nice round number and it’s roughly my consulting rate).  That means the two hours I spend costs me $400 in labor.</p>


<p>This brings me to a straightforward decision, right?  If I think I’m going to use this for more than three years I should just spin it up myself – the investment in time ($400) will pay for itself over the long haul end up being cheaper than me shelling out for the service each month ($360 for three years).</p>


<p>Except that’s not counting all of the other little pieces:</p>


<ul>
<li>What happens if the API changes?</li>
<li>What happens if I run into a new edge case a year down the line?</li>
<li>Where does this new cron get deployed? What happens if that host goes down?</li>
<li>etc etc</li>
</ul>


<p>If there’s one thing that I’ve learned as a developer, there’s no such thing as a <em>true</em> one-time-fee when it comes to development: everything carries technical debt, and you’re going to have to hit it sooner or later.</p>


<p>So I let BriefMetrics handle everything there.  Maybe, at some point down the line, my needs will change or the price will increase and the calculus will work out differently.</p>


<p>But my engineering time is sacred – I want to spend it as smartly as possible, and if I can save a couple hours by coughing up a paltry monthly sum, I will.  There are bigger fish to fry.</p>


<p>Truth be told, I feel like I’m the type of person who <em>wants</em> to roll my own dependencies most of the time.  Building stuff is fun, and the endorphin rush of completing a component that saves me a monthly bill is great.</p>


<p>But it’s rarely the responsible thing to do with my time.</p>


<p>And I figure <strong>if I’m ever in a position where implementing away a $19/month expense is the best use of my time, then something’s wrong</strong>, you know what I mean?</p>


<div class="footnotes">
<hr/>
<ol>
<li id="fn:1">And, knowing Google’s APIs, this is a <em>tremendously</em> optimistic estimate.
 <a class="footnote-return" href="#fnref:1"><sup>[return]</sup></a></li>
</ol>
</div>
	