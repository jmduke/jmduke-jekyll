---
Title: "Embedding Markdown in YAML"
Date: 2015-11-09 00:00:00
Tags: ["yaml"]
---

<p>Barback’s data is all stored internally as <code>YAML</code>.  This isn’t for any particularly interesting technical reason: I just like writing it more than JSON.  It means when I want to create a new recipe, I can write something like:</p>


<pre><code>- name: Naked and Famous
  source: http://www.letsdrinkabout.it/sara-benincasa/
  ingredients:
  - 2cl Aperol
  - 2cl Mezcal
  - 2cl Yellow Chartreuse
  - 2cl Lime juice
  directions: "Combine all ingredients in a shaker, add ice and shake until well chilled. Strain into a chilled cocktail glass. Garnish with a lime wedge."
  garnish: "lime wedge"
  glassware: coupe
</code></pre>


<p>I’m in the process of converting directions for recipes from the prosaic format as seen above to something akin to an ordered list (like, you know, actual directions.)  So instead of:</p>


<blockquote>
<p>Combine all ingredients in a shaker, add ice and shake until well chilled. Strain into a chilled cocktail glass. Garnish with a lime wedge</p>
</blockquote>


<p>It could be:</p>


<ol>
<li>Combine all ingredients in a shaker.</li>
<li>Add ice and shake until well chilled.</li>
<li>Strain into a chilled cocktail glass.</li>
<li>Garnish with a lime wedge.</li>
</ol>


<p>This lead to an interesting question: how do I actually do this in the confines of <code>YAML</code>?</p>


<p>Most markdown is fine in YAML — I was already embedding inline Markdown like <code>em</code> and <code>strong</code> in it.  However, ordered lists need newlines in Markdown. The above list would be represented as follows:</p>


<pre><code>1. Combine all ingredients in a shaker.
2. Add ice and shake until well chilled.
3. Strain into a chilled cocktail glass.
4. Garnish with a lime wedge.
</code></pre>


<p>And <code>YAML</code> doesn’t really like multi-line strings, right?</p>


<p>Turns out, the solution is pretty simple.  You can express a <a href="http://www.yaml.org/spec/1.2/spec.html#id2760844">scalar</a> as being literal using <code>|</code>, which means — amongst other things — that newlines will be preserved.  So all you need to do to preserve the Markdown formatting within YAML is use this to kick off your multi-line string, as follows:</p>


<pre><code>- name: Naked and Famous
  source: http://www.letsdrinkabout.it/sara-benincasa/
  ingredients:
  - 2cl Aperol
  - 2cl Mezcal
  - 2cl Yellow Chartreuse
  - 2cl Lime juice
  directions: |
    1. Combine all ingredients in a shaker.
    2. Add ice and shake until well chilled.
    3. Strain into a chilled cocktail glass.
    4. Garnish with a lime wedge.
  garnish: "lime wedge"
  glassware: coupe
</code></pre>
	