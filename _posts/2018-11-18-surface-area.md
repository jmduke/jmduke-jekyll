---
layout: post
title: Surface Area
---
As a codebase grows, its surface area invariably grows larger.  There are more considerations; more edge cases; there is more and more content to keep track of.  You can temper this growth by being extremely careful and considerate, but you can never stop it entirely (modulo just "not doing anything" — but even then you have to deal with code rot.)

My main approach to handing this with Buttondown has been writing lots of unit tests [^1] and reify as few directions as possible with really pleasant abstractions and interfaces.  Even this though doesn't work perfectly: take [this conversation](https://twitter.com/hugo__df/status/1064275022544551937):

1. Tweet embedding is a really cool feature that I'm relatively proud of, as it birthed the entire markdown feature ecosystem I'm using.
2. It's also super buggy and incomplete.
3. It's also not obvious and usage is probably very low. 

This is the other thing I struggle with a lot: I have, say, eight hours a week I can spend working on Buttondown.  Because I am ill-disciplined and capricious, I usually want to spend that working on whatever I find interesting at the moment.  Which means there are important parts of the codebase that never get touched; which means there are important considerations (I should redo my marketing pages!) that never get, uh, considered.

[^1]: Sitting at around 400 right now.
