---
title: "Coach marks and onboarding"
Date: 2014-11-02 00:00:00
Tags: ["design"]
layout: post
---

<p>According to my iTunes history, I’ve downloaded 312 apps.  44 of those have been purchases, with an average purchase price of just under two dollars.  27 of them <sup class="footnote-ref" id="fnref:2"><a href="#fn:2" rel="footnote">1</a></sup> are cocktail/recipe apps to help with my initial (and post-initial) design of <a href="http://www.getbarback.com">Barback</a>.</p>


<p>That’s a fair enough amount to start developing some pattern recognition and identifying some app smells.</p>


<p>To understand what an app smell is <sup class="footnote-ref" id="fnref:1"><a href="#fn:1" rel="footnote">2</a></sup>, you should know what a <a href="http://en.wikipedia.org/wiki/Code_smell">code smell</a> is:</p>


<blockquote>
<p>In computer programming, code smell is any symptom in the source code of a program that possibly indicates a deeper problem. Code smells are usually not bugs—they are not technically incorrect and do not currently prevent the program from functioning. Instead, they indicate weaknesses in design that may be slowing down development or increasing the risk of bugs or failures in the future.</p>
</blockquote>


<p>So, basically, a surface-level anti-pattern that indicates a more serious problem: a literal tip of the iceberg.  Code smells appear in things that get compiled; app smells appear in things that get tapped.</p>


<p>I’ve had a mental list of a bunch of these accumulating, and I’m going to start working to write them all up, starting with –</p>


<h3 id="coach-marks">Coach marks</h3>


<p>I might as well start with the one that I’m currently guilty of: coach marks.  Even if you’re not familiar with the term, you’ve seen them before: you open a new view in an app, your screen fades out a little, a helpful tooltip or blurb pops up explaining what a certain button or field is for, you tap the screen and it either goes away or gets replaced with another one.  Below are some examples of how I’m using it:</p>


<iframe allowfullscreen="" frameborder="0" height="527" src="http://mediacrush.net/OV6NbZZVyyIr/frame" width="297"></iframe>


<p><img alt="Imgur" src="http://i.imgur.com/fT25ORU.gif"/></p>


<p>The issue here is obvious: if you have to give your app an instruction manual (let alone one that can only be read once), then you’re not doing a good job of communicating with your users.  I’d argue that features should either be self-explanatory or absent: if a user might be confused by something, then it shouldn’t exist until they would be able to take advantage of it.</p>


<h3 id="solution">Solution</h3>


<p>There’s a simple solution, but it’s not necessarily an easy one:</p>


<p><strong>Create interfaces and user experiences that are intuitive and self-explanatory.</strong></p>


<p>I think there are two main paths to this solution:</p>


<ol>
<li>Lean heavily on previously accumulated user expectation and knowledge: co-opt system icons, heavily adopted use patterns, that kind of thing.</li>
<li>A dedicated, thorough, and organic onboarding process.  I’d argue this only really makes sense for catastrophically complex apps, and even then it potentially runs you into the same issue that more naive coach mark setups do.  A thorough collection of these – both those with great execution and awful execution – can be found at the wonderful <a href="http://www.useronboard.com/">User Onboarding</a>.</li>
</ol>


<p>In my case: an onboard process for a five-tab cocktail app is pretty absurd.  I’m trying to remove most of my more novel <sup class="footnote-ref" id="fnref:3"><a href="#fn:3" rel="footnote">3</a></sup> interactions and replacing them with things that I can expect random users — especially the clutch “old dudes who don’t like smartphones but do like martinis” market — to understand as a result of having used other apps already (<em>especially</em> first-party apps.)</p>


<p>An apt example of this: Barback has a ‘random’ tab that, well, pulls up a random recipe.  Previously, the only way to get another random recipe was to shake the phone: despite this being called out in the coach mark for first loading the tab, nine out of the ten people I used as guinea pigs didn’t know how to do it.  <sup class="footnote-ref" id="fnref:4"><a href="#fn:4" rel="footnote">4</a></sup>  It’s not their fault: the whole ‘shake to refresh’ paradigm is only really used in a couple apps and once the novelty wears off it’s not nearly as easy to use as a good old-fashioned navigation controller button.  So, instead, I replaced that listener <sup class="footnote-ref" id="fnref:5"><a href="#fn:5" rel="footnote">5</a></sup> with a much more boring solution: a system-provided Refresh button.</p>


<p><img alt="Imgur" src="http://i.imgur.com/lx82RGE.gif"/></p>


<p>Still, I have a long ways to go.  By far the biggest piece of feedback that needs addressing is that most people don’t realize that you can click on ingredients to get more information about them (as seen below), which is sort of awful (and, again, this is <em>with</em> coach marks).  <sup class="footnote-ref" id="fnref:6"><a href="#fn:6" rel="footnote">6</a></sup>  But plugging away slowly — removing coach marks just as one would remove unruly methods whose needs have been refactored out of existence — I’m gaining confidence in my design and my UX.</p>


<h3 id="perfect-on-boarding">Perfect on boarding</h3>


<p>I’ve rambled about coach marks for long enough, I think, but in closing I want to highlight some excellent write-ups on how to handle this brand of user education:</p>


<ol>
<li>Toto Temple designed a menu system <a href="http://t.co/cx6Aanbzzo">that teaches first-timers how to play</a> by using the same controls for character + level selection that are used in the actual game.</li>
<li>Wanderlust, a to-do app, includes the list of <a href="http://uxmag.com/articles/wunderlists-cross-platform-acquisition-onboarding-process">basic product features as pre-loaded tasks</a>.</li>
<li>Possibly the most classic example: the original Super Mario Bros. uses the first level as an <a href="http://auntiepixelante.com/?p=465">introduction to the rules which govern the game</a>.</li>
</ol>


<p>(I don’t think it’s coincidental that two of my three favorite examples for this kind of thing are games.)</p>


<div class="footnotes">
<hr/>
<ol>
<li id="fn:2">Most encouragingly, almost all of them are awful.
 <a class="footnote-return" href="#fnref:2"><sup>[return]</sup></a></li>
<li id="fn:1">And by <em>is</em>, I obviously mean that this is a term I just made up.
 <a class="footnote-return" href="#fnref:1"><sup>[return]</sup></a></li>
<li id="fn:3">This is me sugar-coating the word ‘dumb’.
 <a class="footnote-return" href="#fnref:3"><sup>[return]</sup></a></li>
<li id="fn:4">This can also be blamed on the fact that shake detection is, uh, <em>shaky</em> at best.
 <a class="footnote-return" href="#fnref:4"><sup>[return]</sup></a></li>
<li id="fn:5">Well, technically it’s still there, but I’m no longer coaching on it.
 <a class="footnote-return" href="#fnref:5"><sup>[return]</sup></a></li>
<li id="fn:6">This is probably my top complaint about flat design: you lose so many visual cues for interactivity.
 <a class="footnote-return" href="#fnref:6"><sup>[return]</sup></a></li>
</ol>
</div>
	