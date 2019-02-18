---
Title: "A gentle introduction to itertools"
Date: 2013-11-29 00:00:00
Tags: ["python"]
slug: itertools
layout: post
---

<style>.post-content h2 { font-size: 20px !important; font-weight: bold; }</style>

<p><code>itertools</code> is pretty much the coolest thing ever.  Despite a vaguely technical name and a decreased emphasis in most introductory Python materials, it’s the kind of builtin package that makes list comprehensions much less of a syntactical mess.</p>


<p>The biggest barrier to using <code>itertools</code> is that there are, well, a lot of methods that tend to all do similar things.  With that in mind, this post is a showcase of some of the more basic — yet completely rad — things you can do with these methods.</p>


<h2>Setup and a Disclaimer</h2>


<p>First, let’s get the boring part out of the way:</p>


<pre><code>import itertools

letters = ['a', 'b', 'c', 'd', 'e', 'f']
booleans = [1, 0, 1, 0, 0, 1]
numbers = [23, 20, 44, 32, 7, 12]
decimals = [0.1, 0.7, 0.4, 0.4, 0.5]
</code></pre>


<p>Well, that was easy.</p>


<h2>chain()</h2>


<p><code>chain()</code> does exactly what you’d expect it to do: give it a list of lists/tuples/iterables and it chains them together for you.  Remember making links of paper with tape as a kid?  This is that, but in Python.</p>


<p>Let’s try it out!</p>


<pre><code>print itertools.chain(letters, booleans, decimals)

&gt;&gt;&gt; &lt;itertools.chain object at 0x2c7ff0&gt;
</code></pre>


<blockquote>
<p>Oh god what happened</p>
</blockquote>


<p>Relax.  The <code>iter</code> in <code>itertools</code> stands for <em>iterable</em>, which is hopefully a term you’ve run into before.  Printing iterables in Python isn’t exactly the hardest thing in the world, since you just need to cast it to a list:</p>


<pre><code>print list(itertools.chain(letters, booleans, decimals))

&gt;&gt;&gt; ['a', 'b', 'c', 'd', 'e', 'f', 1, 0, 1, 0, 0, 1, 0.1, 0.7, 0.4, 0.4, 0.5]
</code></pre>


<p>Yay, much better!  <code>chain()</code> also works, as you’d imagine, with lists/iterables of varying lengths:</p>


<pre><code>print list(itertools.chain(letters, letters[3:]))

&gt;&gt;&gt; ['a', 'b', 'c', 'd', 'e', 'f', 'd', 'e', 'f']
</code></pre>


<p>(For the purposes of making this a readable post I’ll be surrounding most of the methods with <code>list()</code> casts.)</p>


<h2>count()</h2>


<p>Let’s say you’re trying to do a sensitivity analysis of a super important business simulation.  Your entire super important business simulation hinges on the hopes that the average cost of a widget is $10, but demand for that widget might explode over the new few months and you make sure you won’t hemorrhage money if it costs more money.  So you want a list of theoretical widget costs to pass to <code>magic_business_simulation()</code>.</p>


<p>With list comprehensions, that might look something like:</p>


<pre><code>[(i * 0.25) + 10 for i in range(100)]

&gt;&gt;&gt; [10.0, 10.25, 10.5, 10.75, ...]
</code></pre>


<p>Which isn’t bad at all!  Except that reading it is difficult, especially if you’re chaining that list comprehension inside another list comprehension.</p>


<p>With <code>itertools</code> it looks like:</p>


<pre><code>itertools.count(10, 0.25)
</code></pre>


<p>Whee!  Now, if you’re a smart little Pythonista you might be thinking to yourself:</p>


<blockquote>
<p>Well I pass the function a starting point and a step size, but how does it know when to stop?</p>
</blockquote>


<p>And the answer is <strong>it never stops</strong>.  <code>count()</code> and many other <code>itertools</code> methods generate infinitely, until aborted (via, say, <a href="http://docs.python.org/2/tutorial/controlflow.html#break-and-continue-statements-and-else-clauses-on-loops">break</a>).  No, really — again, <code>itertools</code> is all about <em>iterables</em>, and infinite iterables might be scary right now but they are incredibly helpful down the road.</p>


<p>So let’s say we only want the values of the above method up until $20 (this widget has very elastic demand, apparently).  How do we cut off <code>count()</code> like a stern mother scolding a sugar-addled child?</p>


<p>(Hint: another <code>itertools</code> function.)</p>


<h2>ifilter()</h2>


<p><code>ifilter()</code> is a simple invocation of a simple use case:</p>


<pre><code>print list(itertools.ifilter(lambda x: x % 2, numbers))

&gt;&gt;&gt; [23, 7]
</code></pre>


<p>Simple, right?  You pass in a function and an iterable object: it returns a list of those objects which, when passed into the function, evaluate True.</p>


<p>So, to solve our little widget problem from earlier:</p>


<pre><code>print list(itertools.ifilter(lambda x: x &lt; 20, itertools.count(10, 0.25))

&gt;&gt;&gt; ...

&gt;&gt;&gt; ...
</code></pre>


<p>Yeah, this is still going to keep on going infinitely because <code>count()</code> will keep giving you values, and even though they’re going to be ignored by <code>ifilter()</code> it has to process them.</p>


<p>So how do we do this?  A common pattern is thus:</p>


<pre><code>for i in itertools.count(10, 0.25):
    if i &lt; 20:
        do_something()
    else:
        break
</code></pre>


<p>(Look how readable that is.  Isn’t that wonderful?)</p>


<h2>compress()</h2>


<p><code>compress()</code> is by far what gets the most of my use.  It’s perfect: given two lists <code>a</code> and <code>b</code>, return the elements of <code>a</code> for which the corresponding elements of <code>b</code> are True.</p>


<pre><code>print list(itertools.compress(letters, booleans))

&gt;&gt;&gt; ['a', 'c', 'f']
</code></pre>


<h2>imap()</h2>


<p>The final method I’m going to go over is one that should be a simple addition for readers well-versed in the functional programming staples of <code>map</code> and <code>filter</code>: <code>imap()</code> is just a version of map that produces an iterable.  By passing it a function, it systematically grabs arguments and throws them at the function, returning the results:</p>


<pre><code>print list(itertools.imap(mult, numbers, decimals))

&gt; [2.2, 14.0, 17.6, 12.8, 3.5]
</code></pre>


<p>Or (perhaps even better), you can use <code>None</code> in lieu of a function and get the iterables grouped as tuples back!</p>


<pre><code>print list(itertools.imap(None, numbers, decimals))

&gt; [(22, 0.1), (20, 0.7), (44, 0.4), (32, 0.4), (7, 0.5)]
</code></pre>


<h2>Okay, so now what?</h2>


<p>These are, in my opinion, the five most helpful elements of <code>itertools</code>.  But there are <a href="http://docs.python.org/2/library/itertools.html">way more</a>.  Play around with the above five, then five more (<code>permutation()</code>, I’d argue, wins the award for highest fun-to-usefulness ratio).  But the big takeaway is that these methods are cool on their own, but saving a few lines and characters by migrating away from list comprehensions is a benefit that pales in comparison to what you can do by combining these methods together.</p>


<p>The <a href="http://docs.python.org/2/library/itertools.html#recipes">official documentation</a> has a bunch of great examples of how powerful <code>itertools</code> is when you pair it with <code>itertools</code>.  My favorite is below:</p>


<pre><code>def unique_everseen(utterable, key=None):
"List unique elements, preserving order. Remember all elements ever seen."
# unique_everseen('AAAABBBCCDAABBB') --&gt; A B C D
# unique_everseen('ABBCcAD', str.lower) --&gt; A B C D
seen = set()
seen_add = seen.add
if key is None:
    for element in ifilterfalse(seen.__contains__, utterable):
        seen_add(element)
        yield element
else:
    for element in utterable:
        k = key(element)
        if k not in seen:
            seen_add(k)
            yield element
</code></pre>


<p>(Thanks to redditor <a href="http://www.reddit.com/user/bwalk">bwalk</a> for pointing out a typo!)</p>
	