---
Title: "Swift is like Frasier"
Date: 2014-06-30 00:00:00
Tags: ["swift","personal"]
---

<p>Swift is like <em>Frasier</em>.</p>


<p>…</p>


<p>Still reading?  Okay, let me make my case:</p>


<p>When I was a kid, I spent more than a few hours at my grandparents’ house watching <em>Frasier</em> – I was never particularly interested in the characters or the plot, but I liked the dog and the tendency for the characters to make uproarious fools of themselves.</p>


<p>Over the past few months, I’ve been steadily binging through it on Netflix <sup class="footnote-ref" id="fnref:1"><a href="#fn:1" rel="footnote">1</a></sup>, and I’m surprised at how simultaneously familiar and unfamiliar it seems.  I remember the broad strokes and characterizations – Frasier is pompous but kind-hearted, Martin is cranky but proud, farce is omnipresent – but there are so many pleasant surprises that I’ve picked up on now that I have a pop culture foundation surpassing that of a sheltered fifth-grader: things as basic as an extended homage to <em>My Dinner With Andre</em> <sup class="footnote-ref" id="fnref:2"><a href="#fn:2" rel="footnote">2</a></sup> and throwaway references to Seattle intersection to the serious undercurrents of ennui and loneliness that manage to thrive amidst the world’s most obnoxious soundtrack.</p>


<p>Watching an episode (or five) feels vaguely familiar – the plots, even as unremarkable as they are (Frasier fixes the toilet!  Niles needs new shoes!), are nothing new, but there’s another aspect to it that makes me enjoy the whole thing a little bit more, if only to appreciate the fact that a dozen or so talented writers had the brains and guts to throw references to Jung and Vivaldi at the sitcom-shaped wall and see what stuck.</p>


<p>This, of course, is the exact same experience I had working with Swift.</p>


<hr/>


<p>Swift’s launch wasn’t just met with fanfare, it was met with unbridled enthusiasm.  Objective-C, to many <sup class="footnote-ref" id="fnref:3"><a href="#fn:3" rel="footnote">3</a></sup>, is less of a language and more of the wall you have to climb to do fun things.  I maintain that anyone rising to the defense of its Smalltalk-esque syntax is a victim of Stockholm Syndrome; the prospect of ditching the baggage of Objective C and progressing to a language with vastly better development and execution time (as claimed in the keynote) is incredibly enticing.</p>


<p>I’ve spent the past two or so weeks porting <a href="http://getbarback.com">Barback</a> to Swift.  This was  done both for pragmatic and educational reasons: I was already itching for a reason to replace v1.01 with something that looked less like spaghetti code, and I wanted a chance to tinker with this awesome new language before it became passé.</p>


<p>The port is done, and while I must wait until autumn to actually push it out to the App Store, you can take a look at the code on <a href="https://github.com/jmduke/Barback">GitHub</a>.</p>


<p>The reality is twofold:</p>


<p>First, writing in Swift is incredibly pleasant.  Swift code is aesthetically pleasing; it promotes clarity and pragmatism.  While I haven’t played around with two of the most highly touted aspects of the language – case matching and robust <code>enum</code>s, I’m in love with mobile programming that looks like this:</p>


<pre><code>func matchesTerms(searchTerms: NSString[]) -&gt; Bool {
    for term: NSString in searchTerms {

        // If the term is nil (e.g. the second item in "orange,", match errything.
        if term == "" {
            continue
        }

        // If the term matches the name of the recipe..
        if self.lowercaseName.rangeOfString(term) {
            continue
        }

        // Or at least one ingredient in it.
        let matchedIngredients = ingredients.filter({
            (ingredient: Ingredient) -&gt; Bool in
            return ingredient.matchesTerm(term)
        })
        if matchedIngredients.count &gt; 0 {
            continue
        }

        // Otherwise, no luck.
        return false
    }
    return true
}
</code></pre>


<p>As far as I’m concerned, the closer it feels like to writing Python the happier I am, and Swift succeeds remarkably in that regard.  As dumb as it sounds, there are times where I want to hide my code and there are times I want to keep refining it and making it even better: my experience with Swift falls solely in the latter, and I’m enjoying actively refining and refactoring my code for no other reason than that I can.  It’s the first hit of a new designer drug: everything is new and wonderful and unexplored</p>


<p>Second, you’re still writing an iOS app that looks structurally identical to one you’d write in Objective-C.  Which means you’re still dealing with Cocoa Touch bindings 95% of the time; which means you still have to struggle with Core Data et al, in all of its flawed glory; which means you still get to spend a few hours debugging why your UITableView refuses to adopt its new constraints before realizing you called <code>willLayoutSubviews()</code> after <code>self.view.layoutIfNeeded()</code>.</p>


<p>Swift is still a very opinionated alpha of a language, which can be frustrating.  Protocols and extensions are nice but they’re no absolute solution to a lot of problems; the singleton pattern gets to be implemented with this abomination of a struct:</p>


<pre><code>class MySingleton {
  class var sharedInstance: MySingleton {
    struct Singleton {
      static let instance = MySingleton()
    }
    return Singleton.instance
  }
} 
</code></pre>


<p>And, while dealing with segfaults and random SourceKit crashes is hardly symptomatic of Swift’s long-term prospects, it points to the larger issue of how early adoption of a (for now) closed-source language is tenable.  A few thousand open Radars is no substitute for a robust community.</p>


<p>Syntactic sugar is great to use, but Swift development encourages overdosing on the carbs: you’re usually stuck  using suboptimal builtins (<code>String.lowercaseString</code> is <code>O(n)</code>, and was the legitimate chokepoint of one of my methods to the extent that pre-calculating it and storing it as a parameter sped up <code>viewDidLoad()</code> by 95%) and bridging to the <code>NSEquivalent</code> (this is something that will hopefully get better in time, but good luck for now judging what should and shouldn’t be an <code>Optional</code>!)</p>


<p>What I’m getting at is that there are all of these quirks that don’t really go away just because you’re using Swift <sup class="footnote-ref" id="fnref:4"><a href="#fn:4" rel="footnote">4</a></sup> – if anything, Swift exposes them.</p>


<p>With Objective-C, it was vaguely hellish the whole way through.</p>


<p>With Swift, the contrast is painfully apparent: you use an elegant language to do inelegant things.</p>


<hr/>


<p>Put another way: Objective-C was a pain point, but it wasn’t <em>the</em> pain point.  The difficulties and imperfections in working with Apple’s development stack are still there, they’re just smoothed over by a much nicer programming language and the promise that things will keep getting better.</p>


<p>Ultimately, Swift didn’t really solve most of my problems with iOS development.  But it certainly made me more excited to run headfirst into them – and appreciate the work put into so many things in a new light, like watching <a href="https://www.youtube.com/watch?v=VxIBk1a3qdQ">a six minute silent comedy</a> and only now realizing the brilliance.</p>


<div class="footnotes">
<hr/>
<ol>
<li id="fn:1">Yes, all ten seasons.  Everything past the fifth season or so is just not so good, in case you’re wondering.
 <a class="footnote-return" href="#fnref:1"><sup>[return]</sup></a></li>
<li id="fn:2">Yeah, <em>Frasier</em> beat <em>Community</em> to the punch on that one.  By around fifteen years.
 <a class="footnote-return" href="#fnref:2"><sup>[return]</sup></a></li>
<li id="fn:3">Myself included, of course.
 <a class="footnote-return" href="#fnref:3"><sup>[return]</sup></a></li>
<li id="fn:4">Hell, some of them are exacerbated by it.
 <a class="footnote-return" href="#fnref:4"><sup>[return]</sup></a></li>
</ol>
</div>
	