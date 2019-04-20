---
title: "Automating App Store screenshots"
Date: 2014-12-09 00:00:00
Tags: ["ios","development"]
layout: post
---

<p>Things I knew would be bad about iOS development, going in:</p>


<ul>
<li>XCode.</li>
<li>App Store’s draconian policies <sup class="footnote-ref" id="fnref:1"><a href="#fn:1" rel="footnote">1</a></sup></li>
<li>A general malaise accompanied by glancing longingly at old stylesheets, as if they were photos of spurned ex-lovers</li>
</ul>


<p>Things that I did not know would be bad about iOS development, going in:</p>


<ul>
<li>Spending three hours per version taking goddamn screenshots.</li>
</ul>


<p>Seriously, up until recently, this was my workflow:</p>


<ol>
<li>Open app in simulator.</li>
<li>Navigate to each pretty view and take screenshot.</li>
<li>Curse loudly when you realize you accidentally took a Mac screenshot (which ahs chrome) instead of a simulator screenshot.</li>
<li>Correct your mistake.</li>
<li>Save in specific folder.</li>
<li>Open each screenshot in Sketch, save it into iPhone SVG.</li>
<li>Add a pretty little background with explainer text. <sup class="footnote-ref" id="fnref:2"><a href="#fn:2" rel="footnote">2</a></sup> <sup class="footnote-ref" id="fnref:3"><a href="#fn:3" rel="footnote">3</a></sup></li>
<li>Make sure it’s <em>literally</em> pixel-perfect, because you can only upload screenshots that are 1224x2238 or whatever the hell.</li>
<li>Upload to the comically god-awful iTunes Connect, which will often drop uploads or reorganize them <em>just cuz</em>.</li>
<li>Repeat for the six other device sizes. <sup class="footnote-ref" id="fnref:4"><a href="#fn:4" rel="footnote">4</a></sup></li>
<li>Drink.  Drink heavily.</li>
</ol>


<p>I know, It looks merely tedious on paper: but to do this flawlessly takes me around ninety minutes per design change (which, at this point, is pretty much every minor version) – and that’s assuming <sup class="footnote-ref" id="fnref:5"><a href="#fn:5" rel="footnote">5</a></sup> that I don’t stop halfway through because I realize there’s some issue or that I want to showcase a different screen or whatever.</p>


<p>Thankfully, I have a new, much better solution, which takes a little work up front but shaves this into around five minutes of work (and I don’t even have to be there for that five minutes!)</p>


<h2 id="download-some-stuff">Download some stuff.</h2>


<p>“Some stuff” is:</p>


<ul>
<li><a href="https://github.com/KrauseFx/snapshot">snapshot</a>, which automates the screenshooting process</li>
<li><a href="http://sketchtoappstore.com">Sketch to App Store</a>, which automatically embeds screenshots in chrome + backgrounds <sup class="footnote-ref" id="fnref:6"><a href="#fn:6" rel="footnote">6</a></sup></li>
<li><a href="https://github.com/KrauseFx/deliver">deliver</a>, which automatically uploads new jank to iTunes Connect</li>
</ul>


<p>Follow all the instructions for these, which amount to installing gems in the same folder as your XCode project.</p>


<h2 id="set-up-uiautomation-script-to-grab-screenshots">Set up UIAutomation script to grab screenshots.</h2>


<p>I’m not going to try to cover UI Automation here in detail – since my understanding of it is so meager, and my use case so basic – but if you’re unaware, it’s basically JavaScript to interact with iOS devices.  <a href="https://developer.apple.com/library/mac/documentation/DeveloperTools/Conceptual/InstrumentsUserGuide/UsingtheAutomationInstrument/UsingtheAutomationInstrument.html">Apple probably has the best tutorial.</a></p>


<p>My script looks like this (keeping in mind that <code>captureLocalizedScreenshot</code> is a magic method brought to us by <code>snapshot</code>):</p>


<pre><code>#import "SnapshotHelper.js"

var target = UIATarget.localTarget();
var app = target.frontMostApp();
var window = app.mainWindow();

// Get full list.
target.frontMostApp().mainWindow().tableViews()["Sorry, we can't get you recipes until you connect to the internet!"].elements()[0].tapWithOptions({tapOffset:{x:0.40, y:0.54}});
target.delay(0.5);
captureLocalizedScreenshot("Check out tons of great recipes");

// Get recipe detail.
target.frontMostApp().mainWindow().tableViews()[0].cells()["Manhattan"].tapWithOptions({tapOffset:{x:0.62, y:0.39}});
captureLocalizedScreenshot("Get ingredients, directions, and fun facts");

// Get search page.
target.frontMostApp().tabBar().buttons()["Search"].tap();
target.frontMostApp().mainWindow().tap();
target.frontMostApp().mainWindow().tableViews()[0].cells()["Gin"].tap();
target.frontMostApp().mainWindow().tableViews()[0].searchBars()[0].tap();
captureLocalizedScreenshot("Search for exactly what you're in the mood for");
target.frontMostApp().mainWindow().tableViews()[0].cells()["Gin + Lemon juice"].tap();

// Get favorites.
target.frontMostApp().tabBar().buttons()["Favorites"].tap();
target.frontMostApp().mainWindow().tap();
target.frontMostApp().mainWindow().tap();
captureLocalizedScreenshot("Keep track of your favorites");

// Get shopping list.
target.frontMostApp().mainWindow().tableViews()[0].cells()["Shopping List"].tap();
captureLocalizedScreenshot("Figure out what you need to buy");
</code></pre>


<h2 id="run-that-script">Run that script.</h2>


<p>Now you have a folder – probably <code>./screenshots/</code> – filled with all of those dope images.  Life is great.</p>


<p>(If you’re going to throw them into Sketch, as I’ve detailed below, then you only actually need the iPhone 6S versions, but I think it’s worth going through the entire list just as a last-minute UI veriication.)</p>


<h2 id="add-those-images-to-sketch-to-app-store-and-export">Add those images to <strong>Sketch to App Store</strong> and Export</h2>


<p>The actual plugin here does a good job of outlining what you need to do here: again, a bit of up-front effort but you will literally only need to do it once ever.</p>


<h2 id="call-deliver">Call <code>deliver</code></h2>


<p>Running this the first time</p>


<h3 id="in-conclusion">In conclusion</h3>


<p>My process is now this:</p>


<ol>
<li><code>./snapshot</code></li>
<li>Replace old Sketch images with new ones.</li>
<li><code>./deliver</code></li>
</ol>


<p>I sit back, let iTerm whirr, and read Murakami for a couple minutes.  These are good wins for my efficiency, but even better wins for my sanity.</p>


<div class="footnotes">
<hr/>
<ol>
<li id="fn:1"><a href="http://www.panic.com/blog/transmit-ios-1-1-1/">Exhibit #1256</a>.
 <a class="footnote-return" href="#fnref:1"><sup>[return]</sup></a></li>
<li id="fn:2">Fun fact: the App Store expressly prohibits all images which aren’t direct screenshots of the app.
 <a class="footnote-return" href="#fnref:2"><sup>[return]</sup></a></li>
<li id="fn:3">Fun fact: everyone breaks that rule anyway.  Because the App Store is draconian and awful.
 <a class="footnote-return" href="#fnref:3"><sup>[return]</sup></a></li>
<li id="fn:4">Remember when iOS’s major selling point to developers was only having to design for one screen size?  That was cool.
 <a class="footnote-return" href="#fnref:4"><sup>[return]</sup></a></li>
<li id="fn:5">(naively)
 <a class="footnote-return" href="#fnref:5"><sup>[return]</sup></a></li>
<li id="fn:6">If you’re a goodie-two-shoes and just want to use the raw screenshots, you don’t need this
 <a class="footnote-return" href="#fnref:6"><sup>[return]</sup></a></li>
</ol>
</div>
	