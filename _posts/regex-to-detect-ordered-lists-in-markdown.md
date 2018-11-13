---
Title: "A regular expression to detect Markdown ordered lists"
Date: 2016-02-12 00:00:00
Tags: ["markdown"]
---

<p>I’m in the process of converting all of Barback’s recipes’ into directions that have ordered lists.</p>


<p>The <a href="https://getbarback.com/recipes/english-garden/">English Garden</a> is a good example of a before and after.</p>


<p>Before:</p>


<pre><code>Muddle cucumber, lime, syrup and rose water. Next, add gin and st germain and shake with ice.  Double strain over ice and top with tonic. Garnish with cucumber.
</code></pre>


<p>After:</p>


<pre><code>1. Muddle cucumber, lime, syrup and rose water.
2. Add gin and st germain.
3. Shake with ice.
4. Double strain over ice.
5. Top with tonic.
6. Garnish with cucumber.
</code></pre>


<p>It’s clearer and allows for nicer styling client-side on the iOS app as well!</p>


<p>However, I need to convert like 200 recipes to this format and I wanted a way of keeping track of my progress via a <code>django-admin</code> filter.  Still, I needed a regular expression to actually pass in, so I started to tinker with one (huge thanks to <a href="https://regex101.com/">Regex 101</a> for the help.)</p>


<p>I ended up with this:</p>


<p>‘[0-9]+.(.*)\n’</p>


<p>It’s actually fairly simple.  Breaking it down:</p>


<ul>
<li><code>[0-9]+</code> says we want a number</li>
<li><code>\.</code> says we want a period after that number</li>
<li><code>(.*)</code> says we want pretty much anything …</li>
<li>but <code>\n</code> says it’s gotta end with a newline.</li>
</ul>


<p>This has worked awesome for my case, though it may not be exhaustive!  Lemme know if you come up with a better one, but this should work for your purposes.</p>
	