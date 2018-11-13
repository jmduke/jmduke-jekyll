---
Title: "I made an app I’ll never use"
Date: 2016-10-17 00:00:00
Tags: ["personal","projects"]
---

<p>I made a very small app that I find personally abhorrent to ever use.</p>


<p>More on that in a sec.</p>


<p>First, <a href="https://itunes.apple.com/us/app/cluebird-crossword-helper/id1162829250?ls=1&amp;mt=8">please download it</a>.  I’ll probably ask you a few more times over the course of this post, but downloading helps my rankings!  And plus it makes me feel good.</p>


<h2 id="anyway-i-made-an-app-i-ll-never-use">Anyway, I made an app I’ll never use.</h2>


<p>Here’s <a href="https://itunes.apple.com/us/app/cluebird-crossword-helper/id1162829250?ls=1&amp;mt=8">the app</a> again.  Have you downloaded it yet?  Of course you have — you’re my friend and want the best for me.  In case you skipped over the app description in your haste to download the app, here’s what it does:</p>


<blockquote>
<p>Cluebird is a helpful free utility for solving crossword puzzles or other word puzzle where you need to fill in the blanks or match a word to a clue!</p>
</blockquote>


<p>So yeah!  The name of the app is <strong>Cluebird</strong>.  You can put in a crossword clue, like <em>60 minuti</em>, and it tells you what the answer is — like <em>ORA</em>.</p>


<p>Or you can put in a template for an answer, if you’re missing a couple squares, like <em>LA___RS</em>, and it’ll give you the possible answers: <em>LAWYERS</em>, <em>LANCERS</em>, <em>LADDERS</em>, etc.</p>


<p>It generates these answers straight from the source – from <strong>over 2.7 million clue/answer pairs sourced from the New York Times crossword</strong> (and a couple other publications, too.)  If you’re a Bayesian, then you know you can count on this app to help you complete your crossword.  (If you’re a Frequentist, you’ll just have to take my word for it.) <sup class="footnote-ref" id="fnref:1"><a href="#fn:1" rel="footnote">1</a></sup></p>


<h2 id="justin-that-s-not-a-very-complicated-app">Justin, that’s not a very complicated app.</h2>


<p>Of course it’s not a complicated app.  The most interesting part of the app is the data set: the app itself is two table view controllers, some ORM glue, and a bunch of boilerplate.  It’s basically a Hello World app except with 1.6 million rows.</p>


<p>It’s so technically trivial that I even open sourced it!  You can check the <a href="https://github.com/jmduke/Cluebird/">code out here</a>.</p>


<p>The code is mostly bad, because I made a deal with myself that I would create this app in ten hours.  Ten hours over ten days, to be precise: one hour before work, Monday through Friday, for two weeks.</p>


<p>(I ended up going a little bit over my time limit, because I forgot about creating screenshots.)</p>


<p>(Creating screenshots is the worst, but thankfully iTunes changed it so you only need one set of iPhone screenshots.  Previously you needed to get a set for each screen size, which was <strong>the absolute worst</strong>.)</p>


<h2 id="justin-i-m-not-even-sure-this-is-a-particularly-useful-app">Justin, I’m not even sure this is a particularly useful app?</h2>


<p>I’ll go one step beyond ‘not particularly useful’ and say that I <strong>actively discourage the use of this app in my household</strong>.  As far as I’m concerned, looking up an answer to a crossword is cheating, and thus this app is cheating.</p>


<p>If I catch you using this app when you’re solving a crossword, I will be very upset.  I probably won’t say anything to you — I am not very confrontational.  But I will give you a stern look and — perhaps when you are not looking — shake my head.</p>


<p>That being said, be sure to <a href="https://itunes.apple.com/us/app/cluebird-crossword-helper/id1162829250?ls=1&amp;mt=8">download it</a> if you haven’t already!</p>


<h2 id="why-i-made-an-app-i-ll-never-use">Why I made an app I’ll never use</h2>


<ol>
<li><strong>I had a cool data set</strong>.  I crawled my way to every clue/answer pair in the New York Times Crossword for the past sixty years, and I wanted to do some cool data viz stuff to it but I was having trouble thinking of a good jumping off point when I realized I could turn this into an app.</li>
<li><strong>It had been a while since I released something.</strong>  Over the past couple months I started a <a href="http://tenantbase.com">dope new job</a> and a <a href="http://vittles.cloud">fun new side project</a> which had been dominating most of my programming time, but it had been a while since I actually released the 1.0 of anything — especially when that fun new side project keeps on growing in scope every couple hours.</li>
<li><strong>Releasing things is intrinsically good.</strong>  Hitting “Upload to App Store” feels good.  Hitting “Release App” feels good. Getting money from software is good.  Senses of accomplishment and completion are really good.</li>
</ol>


<h2 id="what-i-enjoyed-about-making-this-thing">What I enjoyed about making this thing.</h2>


<ol>
<li><strong>Doing competitive research is really fun and a good muscle to excercise.</strong> <em>Especially</em> when your competitors  seem mostly incompetent and have not updated their apps since the release of iOS 7.  I am not joking: <a href="https://itunes.apple.com/us/app/crossword-solver-free/id337794038?mt=8">this</a> and <a href="https://itunes.apple.com/us/app/the-crossword-anagram-solver/id490438494?mt=8">this</a> and this are my main competition.  This was also a good proxy for “will literally anyone use this” — some of these apps have high hundreds’ of reviews, meaning that some sort of audience is there.</li>
<li><strong>I got to bikeshed for a while.</strong> The fundamental technical problem at the heart of this — <em>how do you search a couple million pairs of strings</em> — is actually kind of tricky, since the two access patterns (substring search and regex) don’t really lend themselves well to basic indexing.  I messed around with Realm, Core Data, and various in-memory trickery before deciding to spend 30 minutes loading everything into SQLite and call it a day.  (It wouldn’t be a perfect bikeshedding section if all of that work didn’t end up completely useless.)</li>
<li><strong>Dealing with UIKit reminded me what I love about programming.</strong>  What I love about programming, in this case, is anything that does not involve using UIKit.</li>
</ol>


<h2 id="what-still-needs-to-be-done">What still needs to be done</h2>


<ol>
<li><strong>The search throttling mechanism is dumb.</strong>  I started implementing an operation queue but then got distracted and stopped because it’s already relatively fast, but will probably try and finish implementing that at some point.</li>
<li><strong>Achieving feature parity by I guess hooking into a dictionary?</strong>  Some of the competitor apps have dictionaries and stuff so if you tap on words it gives you a definition and related words/clues.  A couple reviews mention this.  I’m not sure if it’s worth the effort.</li>
<li><strong>Actual screenshots.</strong>  Seriously the screenshots I submitted the app with are awful.  Like, comically bad.  I need to probably do the trendy thing and have the screenshots include a render of the actual phone.</li>
</ol>


<p>(Or maybe I’ll never touch it again!  Who knows.)</p>


<h2 id="what-s-happened-since-releasing-it">What’s happened since releasing it!</h2>


<ol>
<li><strong>I bought a bottle of <a href="https://www.beeradvocate.com/beer/profile/700/39497/">Elysian Pumpkin Stout</a>!</strong>  That’s kind of unrelated, but I’ve been looking for this beer since mid-September and finally gotten a couple bottles.  I’m pretty jazzed about it.</li>
<li><strong>Cluebird has been live for 48 hours and grossed 12 dollars.</strong>  If I were to value my time at $200/hour, that means I invested $2000 into this app, which means it has yielded a 0.6% return so far.  That’s not so good.  But $12 is enough to buy two bottles of Elysian Pumpkin Stout, which is pretty good.</li>
</ol>


<h2 id="in-conclusion">In conclusion</h2>


<p>Make things!  Even if they’re kinda small and dumb.  Releasing things is good.</p>


<p>Releasing things and then having a pumpkin stout is <em>even better</em>, but feel free to substitute that pumpkin stout for a nice scotch or hot chocolate if you’re not really into pumpkins or beer.</p>


<p>If you go for hot chocolate, get marshmallows.</p>


<p>You deserve it.</p>


<div class="footnotes">
<hr/>
<ol>
<li id="fn:1">Full disclosure: I might have accidentally swapped the role of the Frequentist and the Bayesian in this joke.
 <a class="footnote-return" href="#fnref:1"><sup>[return]</sup></a></li>
</ol>
</div>
	