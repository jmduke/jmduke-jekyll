---
layout: post
title: Unshipping Webpack
---
my [company](https://stripe.com) has a lovely tradition of sending “unshipped” emails, which are writeups of services and pieces of technology that have been decommissioned or otherwise removed from service.

in that spirit, here is a brief writeup on my decision to remove webpack and vue from [spoonbill](https://spoonbill.io), a service that i own.

## context

spoonbill has been live for around four years.  pretty early on in spoonbill’s life, i decided that it was going to be a big, featureful frontend application with rich design interactions.  this decision of course coincided with having recently begun programming front-end professionally, and discovering a new framework called “vue”.

as such, i went through a song and dance familiar to many engineers with wide eyes and new side projects: i set up webpack and figured out how to deploy it on heroku. i remember very little of this process besides one bleary-eyed evening staring blankly at a static file that refused to get updated on deploys.  in general, it was a weekend’s worth of pain for what i thought was a rich reward — a ‘real’ front-end application.

## why

it is very in fashion to dunk on webpack, and i have certainly been guilty of doing so. that being said, webpack is perhaps not the best version of itself but it does a complicated task pretty well, which is more than i can say for a lot of tools.

the cost of accomplishing that “complicated task” is fairly high, though, and frankly it was not worth it.  spoonbill’s frontend is very simple: it is barely even a CRUD app, and all i really need to do is retrieve paginated querysets from the server (and handle some forms/settings) as quickly as possible.  

webpack (or a front-end component framework) is simply unnecessary for this.  you don’t need to create a javascript bundle to implement what bootstrap 3 solved eight years ago or whatever.

plus, very people _actually use_ spoonbill’s frontend.  the vast majority of users sign up and just consume the emails — which is totally cool! — but that means i’ve shifted my efforts towards “how do I make the database fast and the dataset rich” rather than carrying about making a nice app.

## how

i had the idea of doing this in my mind for a while but was mostly paralyzed by where to get started.  i decided to start with the smallest bit and grow more ambitious from there.

(also, all of this was in a single PR.  that is canonically “bad practice”, but one of the glories of side projects is that you can eschew good practices because you don’t have to worry about SLAs or breaking CI.)

django supports partials (you’re probably familiar with these, but if not: think re-usable HTML snippets, the template equivalent of macros) which made this process pretty painless.  i went in the following order:

1. stateless components. these could be translated pretty much directly into partials without worrying about anything.
2. stateful components (such as subscription blocks or filters that hit a REST endpoint).  this is when things started to get tricky! i’d have to look at the pages which used these components and change the server-side controller to pass in the data that was governed by the REST endpoint.  by doing so, i would transform this into a stateless component that received its state from the main bundle, at which point i could translate it into a partial.
3. controllers/pages.  at this point the controllers were a mix of some vue/js logic and some django partials, and i would just translate them directly.  this was a fairly buggy experience because django templates fail silently, but i opted for velocity over safety since if some bits and bobs weren’t immediately working it wasn’t the end of the world.

this was a really satisfying experience overall: watching the javascript footprint of the application shrink over the course of two weekends, culminating in a `rm package.json`, was really nice.

## lessons and surprises

- ironically, i think my time-to-DOM-loaded is a little worse now; a lot of the database work that was once handled asynchronously by REST is now being front-loaded.  this is a solvable problem that I just haven’t addressed yet.
- builds and deploys are much faster, which is very great. 
- builds are *conceptually simpler*.  no more worrying about bundle invalidation, no more worrying about my npm version.
- i’ve already identified a few places where i will probably want to reintroduce javascript: searching and filtering, namely, where interactivity is pleasant and not quite overkill.  still, i think i’ll be going with more of a WHOLE30 approach: javascript, like processed carbs, should be introduced with much hesitation and deliberation.
- spoonbill’s surface area was a bit larger than i realized, which i think is more of a comment on having worked on a project so sparsely over three years.  the most bummerific part of this entire enterprise was realizing that i had a page (for managing your twitter lists) that had a bunch of modals and state that i just totally forget implementing which i then had to create a bunch of new views for.
