---
layout: post
title: Database models are more valuable than I think
---
I've been creating a lot of new tables ("objects", in Django parlance) in [Buttondown](https://buttondown.email) lately.  These are fairly boring tables.  Here are a few of them:

- _ArchiveImport_ (to track folks importing their archives)
- _PeacefulEmailAddress_ (to track email addresses that are confirmed as users to be valid, even if parts of my validation infrastructure think otherwise)
- _ImageUploadAttempt_ (to track images that folks have uploaded to S3)

Historically, I've been weirdly reticent to enshrine things in the database if I could do without it.  It's not clear where this impulse came from, but I'm willing to blame a not-so-distant past where coupling things to the database meant incurring a tax: you have to worry about migrations, you have to worry about state, you have to juggle another ball in the air.

And what's the point of doing that if you can just, say, jam a bunch of strings in a flag (to take the `PeacefulEmailAddress` case) or paginate over S3 (to take `ImageUploadAttempt`)?

Well, there are a lot of points:

1. You get a nice admin interface for free
2. You get _metrics_ for free through the ORM
3. You get lifecycle interactions like post-save and pre-delete signals for free
4. You get _organization_ for free (everything is in a reasonable place! everything has a `creation_date` and `is_deleted` attribute!)

I feel like... all of this is obvious in retrospect.  Of course the database is a good place to put state; it's inexpensive in every sense of the word, and I have a lot of code (both that I've written and that library authors have written) to make dealing with the database very very easy.

It's honestly unclear why I wasn't doing this from day one except, as aforementioned, inaccurate muscle memory.  Rewriting a lot of bits of business logic (imports, billing, etc.) to rely on the database has meant more reasonable _and_ more testable code.  It makes me curious about what things for which my mental cache is outdated.  (The answer is probably front-end unit testing.)
