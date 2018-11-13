---
Title: "Newfangled Title Text Attributes"
Date: 2014-07-21 00:00:00
Tags: ["ios","swift","development"]
---

<p>In the process of upgrading Xcode 6 to the newest beta I ran headfirst into one of my past sins: glorious and reckless ignorance of the <code>deprecated</code> tag in pursuit of the cheap ecstasy StackOverflow answers.</p>


<p>Specifically, title text attributes.  My wanton use of  <code>UITextAttributeFont</code> went from yellow nags to blaring red build failures. <em>Ugh.</em></p>


<p>This is not a particularly exciting or insightful blog post.  This is more about me being the dude who spent twenty minutes wandering down the wrong path on Rattlesnake Ledge and, upon finding his way back to the main trail, decided to nail a crude sign <sup class="footnote-ref" id="fnref:1"><a href="#fn:1" rel="footnote">1</a></sup> to a nearby oak.</p>


<p>Below is a simple table of deprecated title text attributes and their handy-dandy replacements:</p>


<table>
<thead>
<tr>
<th>attribute</th>
<th>old jank</th>
<th>new jank</th>
</tr>
</thead>
<tbody>
<tr>
<td>font</td>
<td>UITextAttributeFont</td>
<td>NSFontAttributeName</td>
</tr>
<tr>
<td>text color</td>
<td>UITextAttributeTextColor</td>
<td>NSForegroundColorAttributeName</td>
</tr>
<tr>
<td>text shadow color</td>
<td>UITextAttributeTextShadowColor</td>
<td>NSShadowAttributeName</td>
</tr>
<tr>
<td>shadow offset</td>
<td>UITextAttributeTextShadowOffset</td>
<td>NSShadowAttributeName</td>
</tr>
</tbody>
</table>


<p>To be more specific with regards to NSShadow, you create an actual <code>NSShadow</code> object and pass it in via <code>NSShadowAttributeName</code>, a la:</p>


<pre><code>var dopestShadowEver = NSShadow()
shadow.shadowColor = UIColor.blackColor()
shadow.shadowOffset = CGSizeMake(width: 0, height: 1)
</code></pre>


<p>That’s all I got.  I hope the search engine gods whisked you here to some minor level of insight, and that they will carry you to someplace warmer, someplace safer: a place without deprecation.</p>


<div class="footnotes">
<hr/>
<ol>
<li id="fn:1">Crafted with bark, crayons, and the entrails of useless StackOverflow keywords.
 <a class="footnote-return" href="#fnref:1"><sup>[return]</sup></a></li>
</ol>
</div>
	