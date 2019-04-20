---
title: "Removing trailing whitespace from Swift files on your Mac"
Date: 2017-01-22 00:00:00
Tags: ["mac"]
layout: post
---

<p>As I was getting <a href="http://getbarback.com">Barback 4</a> ready to ship, I started doing some polish on the actual code since it’d be a little bit before I picked up the codebase again and I wanted to make sure it was relatively hospitable when I came back.  (Nobody likes coming back from vacation to a messy house.)</p>


<p>I installed the lovely tool <a href="https://github.com/realm/SwiftLint">SwiftLint</a> to help clean the codebase, and I discovered that I had <strong>a boatload</strong> of trailing whitespace everywhere.  (I blame Xcode – for most things, but this in particular.)</p>


<p>Thankfully, a little shell magic made this painless to clean up.  I made sure everything was committed (just in case), and then ran:</p>


<p><code>find . -name '*.swift' | xargs -I{} sed -i '' 's/[[:space:]]*$//g' {}</code></p>


<p>in the root source directory.</p>


<p><strong>Presto chango!</strong> It’s all good to go, and I’m down from around 1200 lint warnings to a mere 500.</p>


<p>(This approach naturally works just as well with non-Swift files: just replace the <code>*.swift</code> with <code>*.py</code> or <code>*.js</code> or whatever.)</p>
	