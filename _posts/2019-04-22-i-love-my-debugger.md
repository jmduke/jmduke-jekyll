---
layout: post
title: 'computer tip: love your debugger'
---
the current top post on Hacker News is [PySnooper](https://github.com/cool-RR/pysnooper), a cute and useful tool that straddles the middle line between robust debugging and throwing in `print(foo)` every few lines like you're salt bae.  the readme features, as marketing, the situation in which it may be found useful (emphasis mine):

> You're trying to figure out why your Python code isn't doing what you think it should be doing. **You'd love to use a full-fledged debugger with breakpoints and watches, but you can't be bothered to set one up right now.**

the top comment on this post is a paean to `print(foo)` itself:

> Happy to see new tools for debugging. Yet it's the good old print that I most often end up using. Debugging is very context-sensitive: adding prints makes sense because I know exactly what I'm interested in, and I can drill down on that without being disturbed by anything else. I can print low-level stuff or high-level indicators, depending where my debugging takes me. There's no ready-made recipe for that. Some codebases have built-in logging or tracing functionality: you just flick a switch in a module and begin to get ready-made prints from all the interesting parts. But I've found myself never using those: they are not my prints, they do not come from the context I'm in and they don't have a meaning.

> Use what you want but please don't underestimate prints.

and this sentiment is pretty broad, both among front-end and back-end developers:

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">This has been my debugging strategy for the past 10 years and I don&#39;t see it changing <a href="https://t.co/E9cm3p1Pkj">pic.twitter.com/E9cm3p1Pkj</a></p>&mdash; Sebastian McKenzie (@sebmck) <a href="https://twitter.com/sebmck/status/1109644524995801088?ref_src=twsrc%5Etfw">March 24, 2019</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

i understand this, and find myself sympathizing with this a lot.  printing is easy; printing feels natural in the same way using a REPL to test feels natural.  it is something i have done for literally the majority of my life, compared to the modernism and effort and constraint of connecting with a debugger.

and truth be told, there was a very long time where i didn't know how to debug well.  like, i understood it in the abstract and academic sense — having used `pdb` and `valgrind` in college — but it was never a thing that i considered a tool with which i could more capably solve problems.  it was a thing a different type of engineer did.

but there has been no single greater improvement to my debugging productivity than using a debugger enough to turn it into muscle memory — and i am not even "good" at debuggers. i have merely achieved a level of baseline competence easily available to anyone with an hour or two of spare time.

there are cases where I find myself leaning to use print statements over a formal debugger.  "it's gotta be just this variable", i tell myself. "just a sanity check."

and this is the same voice i use when I say "i'm sure this doesn't need a test" or "i know this migration will just work fine."  a lot of my maturation as a developer has come from realizing that intuition is a disease and a crutch rather than a thing that should be relied on in lieu of formal verifications: the goal should be to delay intuition until it is reified in a thing that exists beyond your mind. [^1]

it's never just that variable; i am wrong so many more times than i am right. a proper debugger gives you line-by-line execution, variable watching, arbitrary code evaluation, and much more.  it is really valuable and i encourage you to make debugging more of a habit! it is fun and fast and easy and will make you better at your job.

[^1]: i am [stealing this concept](http://www.cs.uni.edu/~wallingf/blog/archives/monthly/2019-04.html#e2019-04-08T11_55_12.htm) of defensive programming as delayed intuition
