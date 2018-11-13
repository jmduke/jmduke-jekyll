---
Title: "Forcing functions in everything"
Date: 2017-04-29 00:00:00
Tags: ["development"]
---

<p>Kelly Sutton <a href="http://kellysutton.com/2017/04/18/design-pressure.html">wrote a great article about how TDD impacts software design</a>:</p>


<blockquote>
<p>Design Pressure is the little voice in the back of your head made manifest by a crappy test with too much setup. It’s a force that says when your tests become hard to write, you need to refactor your code.</p>
</blockquote>


<p>I think this is absolutely correct, and touches on a larger concept that I’ve been internalizing over the past few months – that the best methods for evaluating the soundness of a codebase come from activities adjacent to the codebase.

(Or, to use fewer syllables, if it sucks to do something with the code, then the code probably sucks.)</p>


<ul>
<li>Is it tedious and frustrating to create documentation for a codebase?  That’s a sign that the codebase is disjointed and documentation tooling is inadequate.</li>
<li>Are tests painful to write or run?  That’s a sign that the interfaces and abstractions you’ve chosen are incorrect.</li>
<li>Are code reviews disjointed or overly cumbersome?  That’s a sign of improper organization and poor structuring.</li>
<li>Is it a non-trivial task to deploy new changes or onboard a new developer?  That’s a sign your environment is on the wrong side of the spectrum between pleasant and eldritch.</li>
</ul>


<p>All the things that are commonly loathed as tasks – keeping an accurate, performant test suite, having comprehensive documentation, thorough and probing code reviews – are bellwethers of a codebase’s overall health.</p>


<p>Obviously, they’re good tasks to do in of themselves, just like TDD provides the lower order benefit of ensuring a certain level of correctness, but they give you the opportunity to examine your codebase through a lens other than “the person writing the code”, which is even more valuable.</p>


<p>Or, to quote Anne Lamont:</p>


<blockquote>
<p>It’s like discovering that while you thought you needed the tea ceremony for the caffeine, what you really needed was the tea ceremony.</p>
</blockquote>
	