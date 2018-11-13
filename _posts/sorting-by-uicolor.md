---
Title: "Sorting by UIColor"
Date: 2015-11-15 00:00:00
Tags: ["swift"]
---

<p>New in Barback 3.1 is the ability to sort ingredients just as you can sort recipes.  One of the possible methods to sort by is the color of the ingredient, which is admittedly more of an aesthetic option than a functional one:</p>


<iframe allowfullscreen="" frameborder="0" height="315" src="https://www.youtube.com/embed/nYgrkdF4blM" width="420"></iframe>


<p>Sorting by UIColor in this manner — getting a bit of a rainbow effect — is actually fairly easy to pull off!</p>


<p>The trick is to use the semi-hidden (and, in Swift, semi-ugly) <code>getHue</code> function (listed in the Apple docs <a href="https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIColor_Class/#//apple_ref/occ/instm/UIColor/getHue:saturation:brightness:alpha:">here</a>).</p>


<p><code>getHue</code> lets you retrieve the HSB <sup class="footnote-ref" id="fnref:1"><a href="#fn:1" rel="footnote">1</a></sup> components from a given UIColor and store them in pointers that you provide to the function.  Our key here is the hue specifically, since its the one that forms the rainbow gradient.  Below is a mapping of hue values across a spectrum:</p>


<p><img alt="" src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/ad/HueScale.svg/743px-HueScale.svg.png"/></p>


<p>So all we need to do is compare two UIColors by their hues, which makes for a fairly simple comparator:</p>


<pre><code>let firstColor = UIColor.redColor
let secondColor = UIColor.blueColor

// The actual values we end up comparing.
var firstHue: CGFloat = 0
var secondHue: CGFloat = 0

// Dummy pointers.
var saturation: CGFloat = 0
var brightness: CGFloat = 0
var alpha: CGFloat = 0
firstColor.getHue(&amp;firstHue, saturation: &amp;saturation, brightness: &amp;brightness, alpha: &amp;alpha)
secondColor.getHue(&amp;secondHue, saturation: &amp;saturation, brightness: &amp;brightness, alpha: &amp;alpha)
print(oneHue &gt; twoHue)
</code></pre>


<p>You can also check it out how Barback does it, within a specific <a href="https://github.com/jmduke/Barback/blob/b1bfd8bfb39e579d802731b410660deee522787f/Rye/Barback/Controllers/IngredientBaseSortingMethod.swift">enum of different ingredient comparators</a>:</p>


<pre><code>    case .ColorAscending:
        return ({
            var oneHue: CGFloat = 0
            var twoHue: CGFloat = 0
            var saturation: CGFloat = 0
            var brightness: CGFloat = 0
            var alpha: CGFloat = 0
            $0.uiColor.getHue(&amp;oneHue, saturation: &amp;saturation, brightness: &amp;brightness, alpha: &amp;alpha)
            $1.uiColor.getHue(&amp;twoHue, saturation: &amp;saturation, brightness: &amp;brightness, alpha: &amp;alpha)
            return oneHue &gt; twoHue
        })
    }
</code></pre>


<div class="footnotes">
<hr/>
<ol>
<li id="fn:1">Hue, saturation, brightness.
 <a class="footnote-return" href="#fnref:1"><sup>[return]</sup></a></li>
</ol>
</div>
	