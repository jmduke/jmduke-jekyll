---
title: "Markdown in Swift"
Date: 2014-11-30 00:00:00
Tags: ["development","swift"]
layout: post
---

<p>A thought process I had last week:</p>


<ol>
<li>Man, it would be great if I could write descriptions for <a href="http://www.getbarback.com">Barback</a> in Markdown.</li>
<li>Wait, maybe I can.  There are Markdown compilers for everything, right?</li>
<li>Wait, what would it even compile to?  HTML?  An <code>NSAttributedString</code>?  How would that work?</li>
<li>Blargh.  Let’s just Google things and hope for the best.</li>
</ol>


<p>But for you, reader dearest, I have compiled my solution.  It is thoroughly unexciting and likely suboptimal.  Let us press on!</p>


<h3 id="1-first-you-need-a-markdown-compiler">1.  First, you need a Markdown compiler.</h3>


<p>I selected <a href="https://github.com/kristopherjohnson/Markingbird">Markingbird</a>, because I’m a sucker for using Swift drop-ins.  But there are many other solutions.  (Don’t roll your own unless you like agony or premature optimization.)  Throw this in your project.  Swift means auto-importing.  You invoke it like this:</p>


<pre><code>var markdownEngine = Markdown()
let outputHTML = markdownEngine.transform(markdownText)
</code></pre>


<p>It is important that Markdown isn’t declared via <code>let</code>, as it is self-mutating.  You could probably get away with having it as a singleton, but it’s not threadsafe and the setup time is negligible (~10ms).</p>


<h3 id="2-next-you-throw-the-html-into-an-nsattributedstring">2.  Next, you throw the HTML into an NSAttributedString.</h3>


<p>This is surprisingly easy:</p>


<pre><code>let informationData = informationHTML.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
let informationString = NSAttributedString(data: informationData!, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil, error: nil)
</code></pre>


<p>There’s some bad news here: currently, this is done via rendering the whole dang thing in a UIWebView, which is like <em>super</em> slow.  I’m talking approx 400ms slow.  This is depressing, but still acceptable for my use case so I’m not too bummed: that being said, if anyone has a better way of accomplishing this let me know!</p>


<h3 id="3-lastly-you-throw-the-nsattributedstring-into-a-relevant-view">3.  Lastly, you throw the NSAttributedString into a relevant view.</h3>


<p>This should be self-explanatory for anyone who has experience with attributed strings: you just set the <code>attributedText</code> attribute:</p>


<pre><code>attributedText = informationString
</code></pre>


<p>There are two things to note about this, though:</p>


<p><strong>Setting attributedText overwrites the style information of the label.</strong></p>


<p>There are probably more sophisticated ways to fix this issue, but the styling I wanted was pretty fixed across the views so instead of iterating over the string elements I did it by straight-up adding CSS to the HTML before rendering it:</p>


<pre><code>var informationHTML += "&lt;style type='text/css'&gt;"
    + "p { text-align: center;"
    + "    font-family: \(font.familyName);"
    + "    font-size: \(font.pointSize)px;"
    + "    color: \(normalColor); }"
    + "&lt;/style&gt;"
</code></pre>


<p><strong>UILabels don’t play nice with hyperlinks.</strong></p>


<p>Again, something that might be obvious, but if you’re dealing with Markdown you probably want support for hyperlinks – even if just the default handling mechanism – and you’re going to need to make sure you’re using a <code>UITextView</code> with some specific attributes set:</p>


<pre><code>view.selectable = true
view.editable = false
</code></pre>


<hr/>


<p>There are a couple ways you could implement all of this stuff – again, I’m not experienced with Swift to proselytize a certain approach as the most Swift-y <sup class="footnote-ref" id="fnref:1"><a href="#fn:1" rel="footnote">1</a></sup>.  But, for better or for worse, this is how I implemented it – as an observed attribute of an existant subclass of <code>UIWebView</code>:</p>


<pre><code>import Foundation
import UIKit

class DescriptionTextView : UITextView {

    // Other boring/irrelevant stuff is in this class, I promise.

    var markdownText: NSString? {
        didSet {

            // Hey, short-circuiting logic!
            if markdownText == nil || markdownText == "" {
                attributedText = NSAttributedString(string: "")
                return
            }

            var markdownEngine = Markdown()
            let normalColor = NSString(format:"%2X", Color.Light.rawValue)
            let tintColor = NSString(format:"%2X", Color.Tint.rawValue)
            var informationHTML = "&lt;style type='text/css'&gt;"
                + "p { text-align: center;"
                + "    font-family: \(font.familyName);"
                + "    font-size: \(font.pointSize)px;"
                + "    color: \(normalColor); }"
                + "&lt;/style&gt;"
            informationHTML += markdownEngine.transform(markdownText!)
            let informationData = informationHTML.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
            let informationString = NSAttributedString(data: informationData!, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil, error: nil)
            attributedText = informationString

        }
    }

}
</code></pre>


<div class="footnotes">
<hr/>
<ol>
<li id="fn:1">Number one complaint of Swift’s name is that it’s an adjective.  What’s the Swift equivalent of “Pythonic”?
 <a class="footnote-return" href="#fnref:1"><sup>[return]</sup></a></li>
</ol>
</div>
	