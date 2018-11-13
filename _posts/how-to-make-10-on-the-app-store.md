---
Title: "How to make $10 on the App Store"
Date: 2014-04-21 00:00:00
Tags: ["marketing","development"]
---

<p>One of my New Years’ resolutions was to make $10 on the App Store – and, as of last month, I’m happy to say I can check it off my list – <a href="http://getbarback.com">Barback</a> is now available to curious alcoholics everywhere!  This post, more than anything else, is a braindump of all the random thoughts and resources I had between deciding to make an app and proudly seeing it show up in the App Store.</p>


<p>(Of course, the amount of money I’ve made on the App Store is relatively far north of $10 and relatively far south of bajillions – this post is more about the actual development process for a programmer with zero mobile experience.)</p>


<h1 id="coming-up-with-an-idea-that-doesn-t-suck">Coming up with an idea that doesn’t suck</h1>


<p>If you’re a first-time mobile developer, the best piece of advice I can give you is to think of an idea that:</p>


<ol>
<li>satisfies a personal need</li>
<li>requires relatively few moving parts</li>
<li>can be explained to friends and family without using the words ‘disruptive’, ‘synergy’, or ‘paradigm’</li>
</ol>


<p>For me, that idea was simple: I loved making cocktails, but the only real resources I had were various online databases (for which the signal to noise ratio was incredibly poor <sup class="footnote-ref" id="fnref:1"><a href="#fn:1" rel="footnote">1</a></sup>) or hard-copy books, which were difficult to parse and search.</p>


<p>I wanted something simple and effective, where I could jot down notes, search by ingredients, and have a pleasant experience – and, surprisingly, that last criterion excluded most of the existing offerings on account of them being terrible.</p>


<p>That’s why I didn’t stipulate that the idea had to be particularly original – with <a href="http://www.theverge.com/2013/10/22/4866302/apple-announces-1-million-apps-in-the-app-store">over one million</a> iOS apps, the likelihood that you’re bringing new something new to the table is overwhelmingly slim.  <strong>Thankfully, most apps out there are absolutely awful.</strong> <sup class="footnote-ref" id="fnref:2"><a href="#fn:2" rel="footnote">2</a></sup></p>


<h1 id="designing-something-that-isn-t-awful">Designing something that isn’t awful</h1>


<p>I own an iPad and an iPhone and spend an embarrassing amount of time engrossed in apps on either.  That being said, even with my experience of <em>using</em> well-designed apps <sup class="footnote-ref" id="fnref:3"><a href="#fn:3" rel="footnote">3</a></sup>, I had no idea how to actually go about creating one.  Thankfully, there are a shocking number of design resources available for the hopeless novice.  My favorites, in no particular order:</p>


<ul>
<li>The vaguely named – yet still great – <a href="http://www.mobile-patterns.com/">Mobile Patterns</a></li>
<li><a href="http://pttrns.com/">pttrns</a>, which is even more vaguely named</li>
<li><a href="http://capptivate.co/">Capptivate</a>, which has a particular focus on animations</li>
<li>Lastly, the ubiquitous <a href="http://www.dribbble.com/search?q=ios">Dribbble</a>, which really needs an option to hide all screenshots that look awful except they’re renders on an actual device and that device is blurred and at a 30 degree angle for some reason</li>
</ul>


<p><strong>Also, don’t use the hamburger button (pictured below).  It’s just too weird.</strong></p>


<p><img alt="How does this look like a hamburger?  What kind of awful hamburgers are you eating?" src="http://mlkshk.com/r/LOQQ"/></p>


<h1 id="coding-things-that-don-t-break-often">Coding things that don’t break (often)</h1>


<p>Before anything else, do the <a href="https://developer.apple.com/library/ios/referencelibrary/GettingStarted/RoadMapiOS/FirstTutorial.html">standard iOS/XCode tutorial</a> that Apple offers.  XCode often feels as if Dali designed an IDE, and it helped me incredibly to get a few pages of hand-holding before setting off on my own.  If you want to follow even more directions after that, <a href="http://online.stanford.edu/course/developing-ios7-apps-fall-2013?utm_source=email-broadcast&amp;utm_medium=email-click&amp;utm_campaign=december-mailer-2013">Stanford offers a presumably excellent iTunes U course</a>.</p>


<p>Beyond that, the standard levy of resources (StackOverflow, /r/objectivec, furiously Googling exception messages) are always classic sources of help, but there are a few great iOS-specific places to check out as well:</p>


<ul>
<li><a href="https://itunes.apple.com/app/dash-docs-snippets/id458034879?mt=12">Dash</a>, the best way to search for documentation (which you will be doing frequently) <sup class="footnote-ref" id="fnref:4"><a href="#fn:4" rel="footnote">4</a></sup></li>
<li><a href="http://cocoapods.org/">CocoaPods</a> – think of this as iOS development’s version of PyPi / NPM / whatever the Ruby package manager is</li>
<li>Mike Ash’s <a href="https://mikeash.com/pyblog/">NSBlog</a>, or perhaps even his <a href="https://mikeash.com/book.html">NSBook</a> <sup class="footnote-ref" id="fnref:6"><a href="#fn:6" rel="footnote">5</a></sup></li>
</ul>


<p>And, while you might not need the following links just to get a v.0.1.0 app off the ground, <a href="http://www.objc.io/">objc.io</a> and <a href="http://nshipster.com/">NSHipster</a> great for deepening your understanding of the language and ecosystem as a whole:</p>


<p>(Also, bookmark <a href="http://benscheirman.com/2013/08/the-ios-developers-toolbelt/">the iOS developer’s toolbox</a>, which will quickly become your bible.)</p>


<h1 id="throwing-your-slop-at-the-huddled-masses">Throwing your slop at the huddled masses</h1>


<p>Okay, maybe the header’s a little hyperbolic, but in a lot of ways it isn’t – the closed-source nature of the App Store makes it easier than ever to rationalize shipping shitty code.  <sup class="footnote-ref" id="fnref:5"><a href="#fn:5" rel="footnote">6</a></sup>  And that’s a good thing, for the most part!</p>


<p>As long as you’re dutiful about avoiding unnecessary idiocy and not actively sabotaging your future development efforts, ripping the metaphorical bandaid off and submitting your app is going to be infinitely more useful for your productivity and sanity than laboring indefinitely over micro-optimizations.</p>


<p>Similarly, I found it incredibly useful to create a strict featureset for the first version of Barback: otherwise, you’ll likely find yourself lazily bathing in a quagmire of feature creep, letting obsessions over font-size customization and drag-and-drop override other useful things like ‘customer feedback’ and ‘money’.</p>


<p>That’s not to say that it isn’t worth obsessing over the tiny details – because it definitely is – but if you’re just a random dude tinkering around with a mobile app for the first time, you can probably wait a few versions before doing so.  <strong>If your goal is to ship a perfect gem of an app, then kudos – but there’s no reason that perfect gem has to be your first public release.</strong></p>


<h1 id="conclusion">Conclusion</h1>


<p>Development is, generally speaking, pretty rad.</p>


<p>Mobile development is, generally speaking, pretty weird – but it’s still pretty rad.</p>


<p>Getting to send someone a link to the App Store with your name on under ‘Developer’ is really neat, especially for the first time.  And, despite an abundance of anecdotal evidence otherwise, its fun and simple to learn how to do it yourself.</p>


<p>So yes – you too can make $10 on the App Store!  (Just stay away from the booze vertical, okay?  Kind of protective about my niche.)</p>


<div class="footnotes">
<hr/>
<ol>
<li id="fn:1">If you think I’m exaggerating, check out the Chocolatini.
 <a class="footnote-return" href="#fnref:1"><sup>[return]</sup></a></li>
<li id="fn:2">Previous sentence in bold because seriously, the next time you have doubts about yourself as a developer look at the ‘What’s New’ section of the App Store
 <a class="footnote-return" href="#fnref:2"><sup>[return]</sup></a></li>
<li id="fn:3">With some exceptions – I’m looking at you, King of Dragon Pass
 <a class="footnote-return" href="#fnref:3"><sup>[return]</sup></a></li>
<li id="fn:4">Okay, technically this isn’t even iOS-specific, but that’s how I learned about it so meh
 <a class="footnote-return" href="#fnref:4"><sup>[return]</sup></a></li>
<li id="fn:6">Disclaimer: it’s not called <em>NSBook</em>.  But I feel like that was a missed opportunity, you know?
 <a class="footnote-return" href="#fnref:6"><sup>[return]</sup></a></li>
<li id="fn:5">At least in webdev you run the risk of someone viewing your source and silently judging you for magic number overuse
 <a class="footnote-return" href="#fnref:5"><sup>[return]</sup></a></li>
</ol>
</div>
	