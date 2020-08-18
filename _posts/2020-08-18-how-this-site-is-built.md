---
layout: post
title: How this site is built
---
It is something of an annual tradition at this point for me to tinker around with my web page.  As I write this, I am engaged in probably the longest bout of tinkering and writing that I've undertaken in quite some time. The combination of becoming disillusioned with traditional publishing & syndication infrastructure [^1] and reading [Gwern](https://www.gwern.net/About) has inspired me quite a bit to take more seriously the enterprise of publishing and maintaining this work.

Unlike Gwern's approach, which is I think more academically correct, in the short term I'm interested in making some tradeoffs and using technology that certainly won't be around ten years from now because I don't want to build it all myself yet.  

## Airtable

TKTKTK

## Git

TKTKTK

## Jekyll

TKTKTK

## Netlify

TKTKTK

## Zapier

This site is essentially powered by two data sources: my actual writing archive, in Markdown and Git, and my content & quotes database, in Airtable. Netlify is smart enough to compile and deploy whenever the backing Git repository changes, but it has no mechanism of doing the same thing whenever the Airtable data changes.

I spent an evening puttering around the conventional, reasonable approach to this problem: find some sort of webhook/publishing paradigm that plays with Zapier _and_ Netlify.

- [IFTTT](https://ifttt.com/), which supports both _but_ only triggers on new Airtable items, rather than updates.  This doesn't fit my use case.
- [Zapier](http://zapier.com/), which supports both _but_ only triggers on new Airtable items, rather than updates.  This doesn't fit my use case.
- [Integromat](http://integromat.com/), which supports both _and_ includes support for Airtable updates, but was rather finicky and felt particularly brittle/overkill.

After spending an hour or two on Integromat, I decided to give up and go with something that I have more comfortable with [^2] — Zapier.  Rather than try to be clever and kludge my way around the fact that it doesn't have support for updates, I just set the Zapier "trigger" to be "once every hour".  This is probably _overkill_ — it could be once a day! — and means that my site has a pretty strong level of freshness.

It _also_ means that I can pretty easily divest from Zapier by just writing a cronjob, which has merit in of itself. 


[^1]: By which I mean Twitter.
[^2]: I have a good amount of experience with Zapier due to my time spent building a Buttondown integration for it.
