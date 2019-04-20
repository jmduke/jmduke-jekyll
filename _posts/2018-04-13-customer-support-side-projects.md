---
title: Customer Support for Side Projects
Date: 2018-04-13
Tags: ["personal"]
slug: customer-support-side-projects
---

<style>
h3 > span {
	    background: #fd5d20;
	    position: absolute;
    color: #fff;
    font-weight: 900;
    width: 30px;
    height: 29px;
    line-height: 30px;
    text-align: center;
    margin-left: -40px;
    border-radius: 50%;
    font-size: 16px;
}
</style>

I have been running a bunch of reasonably successful [^1] side projects for a couple years now.  Here is a (unfortunately, very much truncated) list of support emails I have received:

- [Why don't you have more Fernet cocktails?](https://getbarback.com)
- [Why doesn't this tool integrate with LinkedIn?](https://spoonbill.io)
- [Why isn't my email sending?](https://buttondown.email)

I used to be very bad at providing any level of support, for a number of reasons:

- I got anxious receiving email.
- I got anxious sending email.
- I got anxious at the thought of writing something that might upset someone.
- I got anxious at the thought of doing work that wasn't exciting or germaine to what I was currently focused on.

But I'm much better at it now!  In fact, with my largest product, [Buttondown](https://buttondown.email), I am **so good at support that a non-trivial number of people have been upsold purely on my response time.**

It's not just a good way to aid in the growth of your side project, it's a very transferable skill — it improves your ability to communicate effectively, react quickly, and empathize with customers.  All of these are great things!

<!--more-->

Here are my secrets. [^2]

<br />

### <span>1</span> Stay on top of your emails.  (And tweets.  And negative reviews.)

This is the most important thing and why I'm leading with it: **respond to emails ASAP.**

People will be super impressed *and* it stops the ambient stress of an inbox piling up.

When emailing, err on the side of "Sure, I'll do that for you!".  Also err on the side of impressing people with how fast you do things.  

For anything that takes a long time to 'close the loop' [^4] keep track of who's waiting for what.  You can do this with dedicated customer service software like Intercom or HelpScout, but that's probably overkill — I just have a little table in [Notion](https://notion.so) that I keep updated.

<br />

### <span>2</span> Be a person.

Folks are generally not mean. 

They are, however, conditioned from a lifetime of bad customer support interactions to assume that discourse will be slow and painful and either relatively adversarial or relatively robotic.

Be nice, be fun, use emojis — establish a tone as quickly as possible that says "hey, I'm just a person, feel free to chat but also don't be a white-hot ball of rage." [^3]

Frame everything in terms of collaboration (*How can we work together to understand and solve this problem?*) as opposed to combat (*I don't think this is a problem and it's up to you to convince me otherwise.*)

<br />

### <span>3</span> Treat every one-off request as the v0 of a new tool.

If someone asks for a thing, someone else will probably ask for that thing a couple weeks later.

The first time you do that thing, don't run it in a shell or change it manually in the admin but build out a rough script of it, making the second such request easier — and each time down the line, refine it further and further until you have a polished little script you can drop in your playbook.

(This is how Buttondown's import system initially started — as a twenty-line Django script that was a glorified CSV reader that has now evolved into a mostly well-behaved eldritch monstrosity of handling various Tinyletter and Mailchimp edge cases.)

<br />

### <span>4</span> Minimize your operational surface area.

Programmers often balk at the concept of spending money on stuff they can build themselves — especially on side projects, where the whole point is often the artisanal hand-crafted nature of it all!

But just because it's a side project doesn't mean you can't spend money making your life easier.  

I use Heroku (which costs more than rolling my own infrastructure) because dammit, I don't want to deal with provisioning.  I want to type `git push` and let everything magically happen.

I use Mailgun for Buttondown rather than rolling my own mailservers because I don't want to be on the hook for SMTP shenanigans.  (Or, at least, any more than I already am on the hook for SMTP shenanigans.)

<br />

### <span>5</span> Remember to have fun out there!

Here's a good mental exercise.  Ask yourself:

> Can I spend a week never responding to users?

If the answer is **not without being stressed as hell**, then it's not *just* a side project: its an obligation and something that is probably generating a non-trivial amount of stress.

Obligations are okay, especially if they're profitable, but if you *really* want your thing to be successful long-term you need to position it such that it gives you energy rather than drains it.

Obviously there are places where you need to provide an SLA (if people are giving you money, or if your thing is critical to the life of an organization) — otherwise, just breathe.

Nothing's on fire; or, if something's on fire, the fire is probably small.  Spend a week mentally deloading.  Your users will understand (and if they don't understand, then they're jerks.)

<br />

[^1]: My definition of reasonably successful is some combination of the following descriptors: mostly stable, thousands of MAUs, generating "more than just beer money" monthly, getting written up in B-tier tech publications, that kind of thing.
[^2]: None of these are secrets; they're known by many people who have known them for a long time.  Unfortunately, I was conditioned to think of things like 'empathy for the customer' and 'prompt communication' as "soft skills", with all the implicit denigration therein.
[^3]: I send out an initial post-signup email to try and establish this tone.
[^4]: Sorry for slipping into PM-speak.  I promise it'll be the last time it happens.