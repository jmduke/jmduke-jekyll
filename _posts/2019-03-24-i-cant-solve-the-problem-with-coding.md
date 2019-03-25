---
layout: post
title: I can't solve the problem with coding
---
The process of preparing Buttondown's marketing stuff every month is kind of painful: I need to write an email, send it, convert it into a blog post, publish that, then tweet about it.  All of this takes a bunch of manual pulling from disparate data sources, which is super frustrating ("red" implies "effort"):

![](https://i.imgur.com/2OGtZmZ.jpg)

It recently occurred to me that I could automate a lot of this!  *I could solve the problem with coding*.  I could build out a small tool that grabs relevant commits from the GitHub API — as long as I was judicious about tagging the important feature commits [^1] and populating the commit bodies with marketing-material-level copy about what is being done [^2], I could just run a little script at the start of each month that fetches everything, calls some APIs, and then I'm done.
Let's give this a shitty name, like "Commithawk", and look at how easy it seems:

![](https://i.imgur.com/ZdHfr5o.jpg)

This is *so tempting*.  There are so many positives:

- My body essentially tingles with lust at the prospect of automating out a painful task with code.
- I love dogfooding!
- It would save time.
- It would be eventually open-sourceable, and probably a clever way of getting some new users.

But there’s no way this actually saves me time *and* lets me send a great email, right?  

- Procedurally generated emails are sterile.  I can’t do any of my fun little kitschy things like write about the weather or include corgi gifs.
- I’m going to inevitably spend more time running into arcane edge cases with this fifty-line script than I’ll spend actually writing the email.
- What happens when I want to include stuff that isn't in a goddamn git commit?

---

One of my biggest foibles is that, deep down, I think I can do anything with enough code.  This is *rarely true* with Buttondown, and a lot of the project’s biggest flaws — unexamined business model, untested marketing funnel, poorly scaled customer support — stem from things that I can’t just fix in an IDE.

I’m probably going to end up writing this commit scraper-email sender thing, as an exercise.  I might end up using it.  But it’s not going to make anything better: it’ll just be an interesting diversion.  (Which has merit on it’s own, to be fair.)

[^1]: Which, in fairness, I am.
[^1]: Which, in fairness, I am *absolutely not*, but I want to get better at anyway; commit history is powerful and useful and I neglect it.
