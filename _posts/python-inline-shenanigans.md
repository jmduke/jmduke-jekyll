---
title: "Python inline shenanigans"
Date: 2014-07-10 00:00:00
Tags: ["python","development"]
layout: post
---

<p>You are likely already aware of most of Python’s inline greatness, like ternaries:</p>


<pre><code>value = x if a &gt; 10 else y
</code></pre>


<p>And comprehensions:</p>


<pre><code>names = [e.name for e in employees]
capitals = {city.state : city.name for city in capital_cities}
</code></pre>


<p>But there are a few more obscure (though none-the-less super-useful) ones that people don’t seem to know about.</p>


<p>Watch the magic unfold!</p>


<h2 id="the-power-of-if">The power of <code>if</code></h2>


<p>Do you have annoyingly redundant code that looks like this, checking to see if a value exists and assigning a fallback if necessary?</p>


<pre><code>important_key = provided_arg if provided_arg else default_key
</code></pre>


<p>Instead, write it like this!:</p>


<pre><code>important_key = provided_arg or default_key
</code></pre>


<p>Look at that.  Look at how many words you saved.  <sup class="footnote-ref" id="fnref:1"><a href="#fn:1" rel="footnote">1</a></sup></p>


<p>This is a very neat concept called a <a href="http://en.wikipedia.org/wiki/Null_coalescing_operator">coalescing operator</a> which is a fancy way of saying “first we check the first thing, and if that is false then we use the second thing.”</p>


<p>(It is important to note, if you’re familiar with this concept from C# or Perl, that Python’s <code>or</code> is not an actual <em>null</em> coalescing operator; it’s more of a ‘false coalescing operator’, which is a term I just made up.  Put another way: in C#, <code>0 ?? 2</code> evaluates to 0; in Python, <code>0 or 2</code> evaluates to 2.)</p>


<h2 id="inline-exception-handling-your-honor">(Inline) exception (handling), your honor!</h2>


<p>I am willing to bet all of the money in my pockets <sup class="footnote-ref" id="fnref:2"><a href="#fn:2" rel="footnote">2</a></sup> that you have oodles of code that looks like this:</p>


<pre><code>try:
    x = very_complicated_method()
except WeirdError:
    x = fallback_argument
</code></pre>


<p>Instead, write it like this:</p>


<pre><code>x = very_complicated_method() except WeirdError: fallback_argument
</code></pre>


<p>Isn’t that nicer?</p>


<h2 id="wait-why-does-this-matter">Wait, why does this matter?</h2>


<p>Yes, you can make the argument that the mental effort you spend reading this post and remembering these shortcuts is greater than the effort you spend typing out the extra few keywords, but there’s something to be said for aestheticism <sup class="footnote-ref" id="fnref:3"><a href="#fn:3" rel="footnote">3</a></sup>.  Ternaries are ugly.  Unnecessary blocks are unnecessary.</p>


<p>Besides, if you can’t impress your friends and colleagues with arbitrary Python arcana, what’s the point of even being a programmer?</p>


<div class="footnotes">
<hr/>
<ol>
<li id="fn:1">You saved two words.
 <a class="footnote-return" href="#fnref:1"><sup>[return]</sup></a></li>
<li id="fn:2">I have no money in my pockets.
 <a class="footnote-return" href="#fnref:2"><sup>[return]</sup></a></li>
<li id="fn:3">I believe the hip way to say this is <em>being Pythonic</em>.
 <a class="footnote-return" href="#fnref:3"><sup>[return]</sup></a></li>
</ol>
</div>
	