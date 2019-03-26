---
layout: post
title: solvable problems in a mid-stage side project
---
A periodically updated list of solvable (but not yet solved) things in Buttondown.  I'll add to this list (and cross off the things that are done) over time.

1. Database migrations are painful.  Not even *complex* migrations: "add column `Subscriber.foo`, backfill it based on `Subscriber.bar`, and then delete `Subscriber.bar`" is a genre of Django migration that always ends poorly, because it takes like twenty minutes and then something explodes.
2. I have ~zero front-end tests because every time I try to figure out how to do component testing in Vue I grow a gray hair.  This results in a lot of silently broken/janky components.
3. I don't have a great system of handling integration testing, particularly with tightly coupled integrations (Stripe and my bevy of email-verification APIs are where this really hurts.)
3. I have very little insight into deliverability and bouncing, which is probably the single greatest existential risk to the product.
4. Buttondown doesn't have a strict design system and as the surface area of the application increases, UI drift becomes more and more of an issue.
5. Buttondown's bus factor is one.  I have a lot of quality of life tooling around common customer service requests, but no knowledge base / wiki / readme / anything.
6. Buttondown's marketing funnel is non-existent. This hasn't really been that big of a problem, thanks to people just being dope and sharing it, but "hope someone with influence likes the product" isn't a 
sustainable way of growing.
7. My approach to CSS within emails is really bad and needs to be entirely overhauled.  Ideally, automatic inlining would be inclusive of this effort.

An entirely separate — and scarier/more interesting — list would be: all of the things that are wrong with Buttondown that I am unaware of. (If you know of something that may be on this list, please let me know.)

There are two *really big* features I want to ship in Buttondown (**paid subscriptions** and **multiple newsletters**).  After that, I'd like to really spend the rest of the year just tackling this list, and solving the solvable problems, getting it into a steady state where I can ignore my backlog, error tracker, and inbox for a week and be completely fine.

(Knowing me, I'm not going to do this.  But maybe blogging about it will push me in the right direction.)
