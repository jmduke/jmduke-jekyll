---
layout: post
title: 'computer tip: be your first reviewer'
---
![](http://i.imgur.com/OoI0XBZ.jpg)

Do people do this? They should! Do you do this?  If you don't, you should.

Before you assign a pull request (or a code review, or whatever your organization calls it) to someone else, review it yourself.

This seems, depending on who I talk to, either obvious or inane.  The "obvious" camp says things along the lines of "of course you should look at your code"; the "inane" camp says things along the lines of "why would I read my code again, I literally just wrote it."

The point is to read it within the GitHub (or Crucible, or GitLab, or whatever) UI — to shift your brain from 'boop boop I am a programmer writing some code and I bet it's fine' mode to 'I am a _hawk_ with _powerful vision_ finding **deficiencies in a code change**'.

Again, I know this may sound silly.  But it works very well, like editing a manuscript in a different room than the one in which you read it.

Two other addendums to this:

1. Open PRs and review your code even for projects for which you are the only contributor.  Any non-trivial [^1] change gets its own PR; the process of going through a mental feedback loop is valuable, and the ritual of the Pull Request UI is effective in forcing you to stop, step out of your code-hole, and digest your approach.
2. Commenting on your own PRs before assigning them is also a tremendously ergonomic way to explain particularly complex or conversation-worthy bits of your changes. [^2]

[^1]: Where 'trivial' is, like, ten lines of code, but then again the number of times I've been bitten by not reviewing ten lines of code is too numerous to count.
[^2]: Though you should always ask yourself if those comments would be better served in the codebase!
