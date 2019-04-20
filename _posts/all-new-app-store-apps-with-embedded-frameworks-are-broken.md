---
title: "Apps with embedded frameworks are broken"
Date: 2014-10-03 00:00:00
Tags: ["development","gripe","ios"]
layout: post
---

<p>Me, 6.30pm, last night:</p>


<blockquote>
<p>Ooh!  My new version of <a href="http://www.getbarback.com">Barback</a> passed App Store review!  Let me download it and play around with it!</p>
</blockquote>


<p>Me, 6.35pm, last night, after Barback crashed after launching on me and my friend’s phone:</p>


<blockquote>
<p>ASIDQWOIE:WQ JPO&lt;FWEFLQWLDFEQIHER <sup class="footnote-ref" id="fnref:1"><a href="#fn:1" rel="footnote">1</a></sup></p>
</blockquote>


<p>I tried resubmitting the app with a few build settings changed and this time it was rejected for ‘crashing on launch’, with the crash log looking something like this:</p>


<pre><code>Dyld Error Message:
  Library not loaded: @rpath/libswiftCore.dylib
  Referenced from: /private/var/mobile/Containers/Bundle/Application/ED6A7194-EAD0-4FB6-8E81-C4C987E60E08/&lt;AppName&gt;.app/&lt;AppName&gt;
  Reason: no suitable image found.  Did find:
    /private/var/mobile/Containers/Bundle/Application/ED6A7194-EAD0-4FB6-8E81-C4C987E60E08/
&lt;AppName&gt;..app/Frameworks/libswiftCore.dylib: mmap() error 1 at address=0x100168000, size=0x00194000 segment=__TEXT in Segment::map() 
mapping /private/var/mobile/Containers/Bundle/Application/ED6A7194-EAD0-4FB6-8E81-C4C987E60E08/&lt;AppName&gt;.app/Frameworks/libswiftCore.dylib
  Dyld Version: 353.5
</code></pre>


<p>Though I spent the first few hours drowning my perceived ineptitude in beer and looking for solutions to the problem, it appears the entire issue was out of my hands and instead an issue with the App Store.  In fact, this issue doesn’t just affect plucky half-wit devs who like fancy cocktails, but the likes of <a href="https://twitter.com/kcase/status/518153566842654720">Omni Group</a> and <a href="https://twitter.com/pragmaticcode/status/517926341573091328">Pragmatic Code</a>:</p>


<blockquote>
<p>Last update of Linky crashes on launch. It’s removed from sale. We’re sorry. It seems to be bug on the App Store and not an error from us. ~ @pragmaticcode</p>
<p>Looks like another busy weekend ahead: OmniFocus 2.0.2 for iPad is crashing on launch, not sure why yet. If you still have 2.0.1, keep it. ~ @kcase</p>
</blockquote>


<p>Turns out it’s an issue with <strong>all</strong> apps <a href="https://devforums.apple.com/message/1054545#1054545">with embedded frameworks</a>, which naturally includes all Swift apps.</p>


<p>The best part about this?  Apple already approved a bunch of apps that exhibit this behavior!</p>


<p><strong>The review process and walled garden model, which was specifically designed to prevent bad customer experiences like upgrading to an app that breaks immediately, failed to keep out apps that literally cannot make it past the launch screen.</strong></p>


<p>The second best part about this?  The app store doesn’t grant developers any ability to revert back to a previous version of the app.  So now all of my Manhattan-swilling customers have to go off memory until a fix is in place.  <sup class="footnote-ref" id="fnref:2"><a href="#fn:2" rel="footnote">2</a></sup></p>


<p>The third best part about this?  It’s impossible to reproduce!  Apple’s canonical way of testing a distribution build is creating it as an Ad Hoc build and running that – which, of course, doesn’t exhibit the somewhat troublesome behavior of crashing immediately.</p>


<p>So, yeah – if Barback or any other app you own now crashes on launch – sorry, I wish there was something else I could do.  Some tribal wisdom has pointed me in the direction of regenerating my developer certificates, which I’ve tried – but again, because the problem is impossible to reproduce on my end, I can only hope that it works.</p>


<p>Another incident in favor of my longstanding argument: the gatekeeper model for mobile apps would be great if the gate wasn’t made half out of plywood and half out of titanium – and the gatekeeper stopped showing up drunk to the job.</p>


<p><em>(Writing this made me feel better.  If there’s an obvious solution to this problem, or you have more details, or [very likely] I am wildly inaccurate about any of this, please let me know in the comments.)</em></p>


<p><strong>Update: October 4 – looks like Apple fixed the issue, manually resubmitted all affected apps, and they are all available as updates in the App Store.  So yay for only two days of outright downtime.</strong></p>


<div class="footnotes">
<hr/>
<ol>
<li id="fn:1">Imagine lots and lots of expletives.
 <a class="footnote-return" href="#fnref:1"><sup>[return]</sup></a></li>
<li id="fn:2">Or, you know, a competing app.  Joy.
 <a class="footnote-return" href="#fnref:2"><sup>[return]</sup></a></li>
</ol>
</div>
	