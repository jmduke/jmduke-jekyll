---
Title: "Code Reviews"
Date: 2017-07-13 00:00:00
Tags: ["development"]
---

<p>I’ve seen three different iterations of “code review culture”, and all of them have been positive with minor tweaks and changes.  What follows is a general list of observations and advice:</p>


<h4 id="finding-and-preventing-bugs-is-a-secondary-goal-of-code-reviews-not-a-primary-one">“Finding and preventing bugs” is a <em>secondary</em> goal of code reviews, not a primary one.</h4>


<p>You shouldn’t be relying on your code reviewers to find bugs; it’s nice to have an extra set of eyes who can point them out, but it’s your job as the implementer and tester to ensure correctness.</p>


<!--more-->

<h4 id="everyone-and-everything-should-be-subject-to-code-reviews"><strong>Everyone and everything should be subject to code reviews</strong>.</h4>


<p>An atmosphere where senior engineers don’t have to go through CRs is bad: it implies poor things about your development hierarchy, like the idea that seniority means your code is immune to critique.</p>


<p>An atmosphere where critical bug fixes don’t have to go through CRs is bad: it implies you don’t have a testing/rollback framework set up to avoid the need to push unreviewed code.</p>


<h4 id="code-reviews-should-not-be-more-than-x-lines-of-code"><strong>Code reviews should not be more than X lines of code</strong>.</h4>


<p>Anything more than X and diminishing returns set in.  What <code>X</code> is varies from language to language and context to context, but 200 is a pretty good number.  (If your immediate reaction to this is “but most changes are more than 200 lines of code”, my immediate reaction is: nah.)</p>


<h4 id="super-basic-style-comments-should-not-be-in-code-reviews"><strong>Super-basic style comments should not be in code reviews</strong>.</h4>


<p>Like, they <em>will</em> be — someone (you!) is going to leave out a semicolon or mess up spacing, and that should be addressed in a review comment.</p>


<p>But if that’s the norm and not a occassional slip-up, then that’s a sign that you don’t have a documented code style.  Whenever you or someone else comments <em>we prefer null coalescing to ternaries here</em> or whatever, that comment should go into a wiki and a lintfile so such issues can be automatically detected. <sup class="footnote-ref" id="fnref:1"><a href="#fn:1" rel="footnote">1</a></sup>  The goal is to avoid work that can (and should) be automated so reviewers can focus on the important stuff.</p>


<p>(Automation is always preferable to documentation: it’s nice to have a central resource for these things, but it’s <em>much nicer</em> to have that central resource be your IDE or a pre-commit hook.)</p>


<h4 id="don-t-be-an-asshole"><strong>Don’t be an asshole</strong>.</h4>


<p>People have a wide range of how they internalize code reviews, and it is often hard to separate critique of code from critique of the coder.  The best way to do this is to approach code reviews not as an adversarial process, but as a collaborative discovery of the best possible implementation.</p>


<p>A great way to do this that some folks gloss over: <em>write positive comments in CRs</em>.  Positive reinforcement is just as helpful as constructive criticism: praising someone’s tests or the way they structured some tricky business logic doesn’t just make them feel good, it enforces that behavior for themselves and others.</p>


<h4 id="be-prompt"><strong>Be prompt.</strong></h4>


<p>The largest personal and institutional grievance folks have with code reviews is that they gum up the works and increase the time it takes to deploy code.  Set team-wide practices on healthy expectations for when code should be reviewed and stick to them.</p>


<h4 id="be-rigorous">Be rigorous.</h4>


<p>The <em>woooooooorst</em> thing to experience as a review-ee:</p>


<ol>
<li>You post some code.</li>
<li>A reviewer makes comments A, B, and C.</li>
<li>You address those comments and post the new code, asking for a new round of review.</li>
<li>The same reviewer makes comments D, E, and F, all of which could have been made during the original review pass.</li>
</ol>


<p>The <em>woooooooorst</em> thing to experience as a reviewer:</p>


<ol>
<li>Someone posts some code.</li>
<li>You make comments A, B, C, and D.</li>
<li>They address only A and D and post the new code, asking for another round of review.</li>
</ol>


<h4 id="keep-at-it">Keep at it!</h4>


<p>Code reviews can be long and they can be difficult but they are good for the long term health of your code base, just like building out a test suite or documentation.</p>


<p>Some further reading:</p>


<ul>
<li><a href="https://dzone.com/articles/the-most-important-developer-practice">The great article on code reviews</a> that inspired this post.</li>
<li><a href="http://kellysutton.com/2017/04/18/design-pressure.html">Design Pressure</a>, which describes a generalized framework about how optimizing your code for implementation-adjacent tasks. A lot of these observations, you might notice, are nominally about code reviews but really about broader development practices: that’s design pressure at work.</li>
<li><a href="https://secure.phabricator.com/book/phabflavor/article/writing_reviewable_code/">Phabricator’s docs</a> on writing reviewable code, and similarly <a href="https://secure.phabricator.com/book/phabflavor/article/recommendations_on_revision_control/">their docs on crafting commits</a>.</li>
</ul>


<p>Thanks to <a href="https://twitter.com/KellySutton">Kelly Sutton</a>, <a href="https://twitter.com/kwuchu">Iheanyi Ekechukwu</a>, and <a href="https://twitter.com/djtide">Chad Little</a> for reviewing this post.  (And thanks to Michelle, Daniel, Andy, and countless others for reviewing my code over the years, and teaching me how to review well. <sup class="footnote-ref" id="fnref:2"><a href="#fn:2" rel="footnote">2</a></sup>)</p>


<p></p>


<div class="footnotes">
<hr/>
<ol>
<li id="fn:1"><a href="https://houndci.com/">Hound</a> is also great for this.
 <a class="footnote-return" href="#fnref:1"><sup>[return]</sup></a></li>
<li id="fn:2">And occasionally putting up with my terrible code.
 <a class="footnote-return" href="#fnref:2"><sup>[return]</sup></a></li>
</ol>
</div>
	