---
title: "Everything you need to know about :nth-child"
Date: 2014-01-27 00:00:00
Tags: ["development","web"]
layout: post
---

<p>Let’s talk about <code>nth-child</code>.  You can do a lot of things with it, but most people don’t know most of them.</p>


<p>We’re going to use a blank ol’ 9x9 table as demonstration.  Without any <code>nth-child</code> shenanigans, it looks like this:</p>


<table class="nth"><tbody><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr></tbody></table>


<h3 id="the-basics">The basics.</h3>


<pre><code>td:nth-child(2) {
    background-color: #f15b29;
}
</code></pre>


<table class="nth"><tbody><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr></tbody></table>


<pre><code>tr:nth-child(3) td {
    background-color: #f15b29;
}
</code></pre>


<table class="nth"><tbody><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr></tbody></table>


<p>Note that indices start from one:</p>


<pre><code>td:nth-child(1) {
    background-color: #f15b29;
}
</code></pre>


<table class="nth"><tbody><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr></tbody></table>


<h3 id="ranges">Ranges.</h3>


<p>Think of <code>n</code> as a substitute that matches from zero to infinity: so <code>nth-child(n + 4)</code> is the equivalent of <code>nth-child(4)</code>, <code>nth-child(5)</code>, etc.</p>


<pre><code>td:nth-child(n + 4) {
    background-color: #f15b29;
}
</code></pre>


<table class="nth"><tbody><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr></tbody></table>


<p>You can do the same thing (well, I guess, the opposite thing) with <code>-n</code>, which evaluates to 0, -1, -2, and so on:</p>


<pre><code>tr:nth-child(-n + 7) td {
    background-color: #f15b29;
}
</code></pre>


<table class="nth"><tbody><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr></tbody></table>


<h3 id="sort-of-advanced-topics">Sort of advanced topics.</h3>


<p>You can chain these ranges to provide finite subsets:</p>


<pre><code>td:nth-child(n+4):nth-child(-n+6) {
    background-color: #f15b29;
}
</code></pre>


<table class="nth"><tbody><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr></tbody></table>


<p>And, just as you can turn <code>n</code> into <code>-n</code>, you can also turn it into <code>2n</code> to grab every other element (again, think of n as the infinite set of positive integers, so 2n = <code>2, 4, 6, 8, ...</code>.)</p>


<pre><code>td:nth-child(2n) {
    background-color: #f15b29;
}
</code></pre>


<table class="nth"><tbody><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr></tbody></table>


<p>These multiples can also be modified and chained, just like anything else:</p>


<pre><code>td:nth-child(2n + 1):nth-child(-n + 7) {
    background-color: #f15b29
}
</code></pre>


<table class="nth"><tbody><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr></tbody></table>


<p>You can apply the pseudoselector to multiple elements in a definition (and there are <code>odd</code> and <code>even</code> keywords, too!)</p>


<pre><code>tr:nth-child(odd) td:nth-child(even) {
    background-color: #f15b29
}
</code></pre>


<table class="nth"><tbody><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr></tbody></table>


<h3 id="nth-of-type">nth-of-type</h3>


<p>There’s also the criminally little-used <code>nth-of-type</code> pseudoselector, which works the exact same way as <code>nth-child</code> except it counts by the number elements of the specific type of the selector, as opposed to <code>nth-child</code> (which counts <em>all</em> child elements.)</p>


<p>Our square table makes the difference difficult to illustrate, since they only have <code>tr</code> elements (which only have <code>td</code> elements.)  Instead, lets make something a little kookier:</p>


<pre><code>&lt;div class='examplediv'&gt;
    &lt;span&gt;(S) This is some text.&lt;/span&gt;
    &lt;div&gt;(D) Here is some more text!&lt;/div&gt;
    &lt;div&gt;(D) Please, sir, can I have some more text?!&lt;/div&gt;
    &lt;span&gt;(S) Here's the last bit of text.&lt;/span&gt;
    &lt;div&gt;(D) Ha, just kidding!  This is the last element!&lt;/div&gt;
    &lt;span&gt;(S) (This space intentionally left blank.)&lt;/span&gt;
&lt;/div&gt;
</code></pre>


<div class="examplediv">
<span>(S) This is some text.</span>
<div>(D) Here is some more text!</div>
<div>(D) Please, sir, can I have some more text?!</div>
<span>(S) Here's the last bit of text.</span>
<div>(D) Ha, just kidding!  This is the last element!</div>
<span>(S) (This space intentionally left blank.)</span>
</div>


<p>If we were to try and grab the second span element, <code>nth-child</code> might not necessarily get us what we want:</p>


<pre><code>span:nth-child(2) {
    font-weight: bold;
}
</code></pre>


<div class="examplediv">
<span>(S) This is some text.</span>
<div>(D) Here is some more text!</div>
<div>(D) Please, sir, can I have some more text?!</div>
<span>(S) Here's the last bit of text.</span>
<div>(D) Ha, just kidding!  This is the last element!</div>
<span>(S) (This space intentionally left blank.)</span>
</div>


<p>This specifies a span element which is also the second child element of its parent; but since the second child element of our parent <code>div</code> is not a span, nothing matches. But if we were to slap a <code>nth-of-type</code> on that bad boy, we’d be golden!</p>


<pre><code>span:nth-of-type(2) {
    font-weight: bold;
}
</code></pre>


<div class="examplediv">
<span>(S) This is some text.</span>
<div>(D) Here is some more text!</div>
<div>(D) Please, sir, can I have some more text?!</div>
<span>(S) Here's the last bit of text.</span>
<div>(D) Ha, just kidding!  This is the last element!</div>
<span>(S) (This space intentionally left blank.)</span>
</div>


<h3 id="nth-last-child">nth-last-child</h3>


<p>There’s also <code>nth-last-child</code>, which is <code>nth-child</code>’s evil twin: instead of counting from the first element, this counts from the last element.</p>


<pre><code>td:nth-last-child(2) {
    background-color: #f15b29
}
</code></pre>


<table class="nth"><tbody><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr><tr><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td><td> </td></tr></tbody></table>


<h3 id="conclusion">Conclusion</h3>


<p>Hope this helped!  <code>nth-child</code> is an incredibly powerful front-end tool once you get the hang of it.  If there are any other nice recipes or tricks I omitted, lemme know in the comments.</p>
	