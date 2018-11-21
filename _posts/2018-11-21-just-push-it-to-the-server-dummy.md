---
layout: post
title: 'Just push it to the server, dummy'
---
A lesson I'm learning over and over again with Buttondown is that every time I think to myself "meh, this isn't that complicated, I can implement it clientside and be fine" I am always wrong.  The latest example of this was munging + framing of some subscriber metrics, which is the perfect example of something you _should never do clientside anyway_; it doesn't scale [^1], it's hard to build regression tests around [^2], and it commingles presentation with computation.

That last one is probably the most contentious, but I'm growing more and more confident in the approach that client-side applications should be thin wrappers around server-side data.  (Again, not a new concept at all — just something that I've never really held as a zealous belief.) My client-side code is at its best when it is focused on state management, performance, and clarity, acting as an elegant (but intrinsically ignorant) wrapper around blobs of information returned from a server.

[^1]: ES6 is more performant than most people realize, but it's still not the right choice for iterating through tens of thousands of subscribers.

[^2]: Frontend testing is still a bugaboo for me; I cannot figure out a way to do it in a way that is as painless as hygienic as `pytest`.
