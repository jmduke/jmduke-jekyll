---
layout: post
title: Tips on technical interviews
---
I've done seven mock interviews in the past two weeks.  (I've also done a whole bunch of other mock interviews prior to that, and around two hundred actual interviews.)

Here are some common trends in feedback that I've given candidates.  None of these are prescriptive or exhaustive, but in general candidates who do these things provide more positive signal than those who don't.

### Ask clarifying questions before starting implementation.

The most common flaw I see in the first three minutes of an interview is a candidate's first impulse being to write code.  Jumping straight to implementation is almost always a negative signal; just like in real life, you want to spend time sussing out the domain and making sure you understand all the ramifications of the prompt.

A really easy tactic for this: restate the problem to your interviewer and ask them to confirm your understanding!  This takes, like, thirty seconds, demonstrates that the two of you are on the same page, and gives you confidence that you understand the problem being asked.

### Write out example inputs and outputs, including edge cases.

If your interviewer is nice, they'll give you a couple example invocations of the method or class you're implementing, like such:

```
most_common_word("dog dog cat") == "dog"
most_common_word("The lazy cat jumped over the lazier cat.") == "cat"
```

If they do this, *add more example inputs and outputs*.  Pay attention to edge cases, like:

1. What happens if you pass in an empty string?
2. What size of string are we dealing with?
3. What happens if there's a tie?
4. etc. etc.

If they don't do this: *especially add inputs and outputs*.  Again, it shows that you're thinking about the problem systematically, that you've considered scenarios besides the most obvious, and it gives you a great framework to approach the solution. [^2]

### Avoid radio silence.

As an interviewer, my job is to collect as much positive signal about a candidate as I can. [^3]  Specifically, this means I'm looking for things that you do well: 

- do you think about problems well?
- do you have a great understanding of tooling?
- are you an awesome communicator?
- are you super familiar with a language?
- etc etc

You know the one time it's impossible to get *anything* along these lines?  When you're silent, thinking very hard about a problem or an issue.  I understand the temptation to just kind of sit back and think, but it's *awful* for me in terms of getting actionable feedback.  Try and talk through what you're thinking or write down your thoughts on a notepad/whiteboard.

### Write comments!

Seriously.  Everyone loves comments.  It might feel off-brand to write a bunch of comments when you're on the clock and in a tunnel vision of "oh god gotta solve this quick", but *it is worth your time*.  Some genres of comment that I always *love* to see from candidates:

```
// TODO: handle this edge case
```

```
// This is inefficient, but I'm going with this approach because <reason>
```

```
// Abstract this out later.
```

All three of these do a great job of conveying *I understand this isn't ideal, and know that given more time I can improve this, but in the interest of expediency I'm ignoring it for now*.

### By the way, want a mock interview?

[Email me](mailto:me@jmduke.com). I'd be more than happy to spend an hour interviewing you!

[^2]: Plus, it makes it easy to write tests.  You're writing tests, right?
[^3]: This is tech jargon for "our default position on any candidate is not to hire them, and we need to get evidence as to why that would be a mistake."
