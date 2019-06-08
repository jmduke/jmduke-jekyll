---
layout: post
title: Should I offer a free tier in my SaaS?
---
I've been thinking about Buttondown's pricing model a lot lately, and one way in which I am thinking about it is: "was it a mistake to offer a free tier?"

Popular wisdom says yes. Take the inimitable [patio11](https://twitter.com/patio11):

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr"><a href="https://twitter.com/gkoberger?ref_src=twsrc%5Etfw">@gkoberger</a> No.  Free trial first month (in low-touch SaaS), but I generally am not a big fan of free tiers until persuaded otherwise.</p>&mdash; Patrick McKenzie (@patio11) <a href="https://twitter.com/patio11/status/479125328841830400?ref_src=twsrc%5Etfw">June 18, 2014</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

Or [Baremetrics](https://baremetrics.com/blog/freemium-saas-implode):

> The bigger issues came down to the fact that our resources are finite. We’d been able to scale our infrastructure slowly because our growth before had been predictable and we could figure out ahead of time when certain bottlenecks would become major issues.

> The free plan threw all of that out the window, though.

> When your available resources, whether it be team size, performance caps or money, are tight, then “free” has a real possibility of causing more damage than providing any real benefit.

But what about for me?

First, the actual _technical_ costs of running a free tier are fairly minimal. I'd have to crunch the numbers but I'd say around 20% of the emails sent and subscribers gained (which are the two proxy for infrastructural costs) are on free-tier accounts.

That 20% is actually super reasonable, given that around two-fifths of Buttondown's paid users have come through the blessed upsell path of:

1. Started on Buttondown as a free user with a trivial number of subscribers
2. Gained enough subscribers to warrant paying for the product
3. Happily started paying and are now a profitable customer. [^2]

So the free tier is:

- not directly costing me money 
- working as a good upsell opportunity.
- *objectively good and fun*

Sounds great, right?  

Where it _really_ hits me, though, is customer support burden — again, I don't have exact numbers here, but I would peg 80% of customer service burden on free users.  [^3]

Just because of the way I am — I want to help everyone using Buttondown! — I try to not really care about this.  Folks are folks, and if you have a reasonable request or suggestion I am going to try and address it. This has grown unsustainable, though: there are too many users that the weeks I spend addressing every single thing are weeks that I end up treading water and not actually making progress on the product. [^1]

It is increasingly tempting to snap my fingers and remove the base plan with a $5/month one.  This isn't even to improve revenue so much as to reduce everything else; to know that every time I spend time digging through an inbox or tracking down an arcane DMARC bug I am doing it in service of a user who finds my time and effort valuable enough to pay me for it.

...but. I *like* Buttondown having a free tier; it seems innately 'good' to me, even if it's not the right business decision, if that makes sense.

Buttondown isn't a "business".  It's making a non-trivial amount of money, sure, but the fact that it is a side project with no aspirations for it to be more than a side project means that I can be more incentivized by what feels 'correct' than what is materially most profitable, and the correctness of niceties (plus the fact that without the free plan I have no idea how I'd get an influx of new customers, given my total lack of marketing) outweighs the popular wisdom, at least for now.

And so. I've kinda arrived at this concept of a free tier being a bad business choice that I don't regret.  Or rather, it's a bad choice from a _business_ perspective, if not from a personal one.

So rest assured, Buttondown will forever have a free plan — it's a tool for weird projects first and foremost, and I want it to be in the hands of as many people as possible.

(I still need to think about changing that $29/month price point, though.  That'll come later.)

[^1]: This is something I'm actively working on getting better at: if you're a free customer of Buttondown I will probably not prioritize your feature request unless it's something already on my roadmap.
[^2]: Buttondown's business model is such that if you have 1,000 subscribers and are paying the bare minimum, so long as you're not literally sending an email every day I have a decent margin on you.
[^3]: This is one lesson that I had read online but never really internalized: the folks who are willing to spend money on a service are, paradoxically, less persnickety about the service itself.
