---
layout: post
title: Unshipping Webpack
---
My [company](https://stripe.com) has a lovely tradition of sending “unshipped” emails, which are writeups of services and pieces of technology that have been decommissioned or otherwise removed from service.

In that spirit, here is a brief writeup on my decision to remove Webpack and Vue from [Spoonbill](https://spoonbill.io), a service that I own.

## Context

Spoonbill has been live for around four years.  Pretty early on in Spoonbill’s life, I decided that it was going to be a big, featureful frontend application with rich design interactions.  This decision of course coincided with having recently begun programming front-end professionally, and discovering a new framework called “vue”. (Whoops.)

As such, I went through a song and dance familiar to many engineers with wide eyes and new side projects: I set up webpack and figured out how to deploy it on Heroku. I remember very little of this process besides one bleary-eyed evening staring blankly at a static file that refused to get updated on deploys.  In general, it was a weekend’s worth of pain for what I thought was a rich reward — a ‘real’ front-end application.

## why

It is very in fashion to dunk on Webpack, and i have certainly been guilty of doing so. That being said, Webpack is perhaps not the best version of itself but it does a complicated task pretty well, which is more than I can say for a lot of tools.

The cost of accomplishing that “complicated task” is fairly high, though, and frankly it was not worth it.  Spoonbill’s frontend is very simple: it is barely even a CRUD app, and all I really need to do is retrieve paginated querysets from the server (and handle some forms/settings) as quickly as possible.  

Webpack (or a front-end component framework) is simply unnecessary for this.  You don’t need to create a javascript bundle to implement what bootstrap 3 solved eight years ago or whatever.

Plus, very people _actually use_ Spoonbill’s frontend.  The vast majority of users sign up and just consume the emails — which is totally cool! — but that means i’ve shifted my efforts towards “how do I make the database fast and the dataset rich” rather than carrying about making a nice app.

## How

I had the idea of doing this in my mind for a while but was mostly paralyzed by where to get started.  I decided to start with the smallest bit and grow more ambitious from there.

(Also, all of this was in a single PR.  That is canonically “bad practice”, but one of the glories of side projects is that you can eschew good practices because you don’t have to worry about SLAs or breaking CI.)

Django supports partials (you’re probably familiar with these, but if not: think re-usable HTML snippets, the template equivalent of macros) which made this process pretty painless.  I went in the following order:

1. Stateless components. These could be translated pretty much directly into partials without worrying about anything.
2. Stateful components (such as subscription blocks or filters that hit a REST endpoint).  This is when things started to get tricky! I’d have to look at the pages which used these components and change the server-side controller to pass in the data that was governed by the REST endpoint.  By doing so, i would transform this into a stateless component that received its state from the main bundle, at which point I could translate it into a partial.
3. Controllers/pages.  At this point the controllers were a mix of some vue/js logic and some Django partials, and I would just translate them directly.  This was a fairly buggy experience because Django templates fail silently, but I opted for velocity over safety since if some bits and bobs weren’t immediately working it wasn’t the end of the world.

This was a really satisfying experience overall: watching the javascript footprint of the application shrink over the course of two weekends, culminating in a `rm package.json`, was really nice.  Highly recommend!

## Lessons and surprises

- Ironically, I think my time-to-DOM-loaded is a little worse now; a lot of the database work that was once handled asynchronously by REST is now being front-loaded.  This is a solvable problem that I just haven’t addressed yet.
- Builds and deploys are much faster, which is very great. 
- Builds are *conceptually simpler*.  No more worrying about bundle invalidation; no more worrying about my npm version.
- I’ve already identified a few places where I will probably want to reintroduce javascript: searching and filtering, namely, where interactivity is pleasant and not quite overkill.  still, I think I’ll be going with more of a WHOLE30 approach: javascript, like processed carbs, should be introduced with much hesitation and deliberation.
- Spoonbill’s surface area was a bit larger than I realized, which I think is more of a comment on having worked on a project so sparsely over three years.  the most bummerific part of this entire enterprise was realizing that I had a page (for managing your twitter lists) that had a bunch of modals and state that I just totally forget implementing which I then had to create a bunch of new views for.
