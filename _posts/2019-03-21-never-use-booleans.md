---
layout: post
title: '"Never use booleans"'
---
One of my first interactions with a Principal [^1] at Amazon was a design review for a design owned by a team that was not mine, merely adjacent to mine.  Because I was 21 and a dumbass, I thought that this older guy would hew closer to a PM or a manager and say some sort of irrelevant/ignorant set of remarks rather than a bunch of clever, reasonable, and forward-looking things, and of course the latter is what he did.

(One of the major drawbacks of spending three years getting 'technical knowledge' from Hacker News and Reddit was that I was conditioned to mildly antagonize anyone who wasn't a programmer in their twenties or thirties.  Unlearning that vile lesson was a huge part of actually joining the industry.)

Anyway, I was walking back to our floor with the Principal after the meeting, and we engaged in the genre of small talk that I find particularly valuable, which arises when I begin discussions with "so, that was my first one of those, what else should I know?"  [^2]

The Principal chuckled, as if about to share a secret, and said, "honestly, these API reviews are pretty easy.  Everyone runs into the same mistakes after a while, and you can give fairly canned responses that are boring but actionable and correct."

I asked him for an example, and he obliged:

**"Never, ever make anything a boolean.  Always make it an enum instead.  There's going to end up being a third value, and you're going to regret it."**

This seemed like such a simple yet weird statement, and over the coming weeks I would try and poke holes in it — surely `is_deleted` is a reasonable flag!, surely `should_expose_rss` is a reasonable flag! — and it's stuck in my head ever since.

Anyway, I'm working on a refactor for Buttondown, and of course I just had to migrate a boolean on the `Email` model to an enum: `Email.is_imported` is now `Email.source` (where source can be `app`,  `import`, or `api`, to reflect the fact that now you can create emails through the API)

Was the Principal's advice good?  It's probably not correct 100% of the time.  Does it need to be?  Isn't advice sufficiently good if it's "mostly correct"?

I'm not sure.  But this wasn't the first time I've migrated a boolean to an enum and it won't be the last.  (I seem to remember the anecdote more vividly than the advice itself, which is one of my many vices.)

[^1]: Amazon's flavor of title to designate "extremely distinguished engineer"
[^2]: I am *convinced* there is no greater path to dense knowledge than telling someone you are new to A Thing and asking them what you should know.  It is honest and it is powerful and it is lovely.
