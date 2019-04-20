---
title: "Singletons in Swift"
Date: 2014-07-05 00:00:00
Tags: ["development","swift"]
layout: post
---

<p>A quick, relatively boring post about how to handle singletons in Swift in case you’re like me and spent an inordinate amount of time deliberating between the various approaches:</p>


<h2 id="singleton-a-la-global-variable">Singleton a la global variable</h2>


<p>The laziest and easiest way to do it is storing the singleton as a global variable:</p>


<pre><code>let _SingletonSharedInstance = Singleton()

class Singleton  {
    class var sharedInstance : Singleton {
        return _SingletonSharedInstance
    }
}
</code></pre>


<p>Advantages of this approach:</p>


<ul>
<li>Lazy initialization! <sup class="footnote-ref" id="fnref:2"><a href="#fn:2" rel="footnote">1</a></sup></li>
<li>It’s automatically threadsafe since you’re making it a constant.</li>
</ul>


<p>The disadvantages of this approach are myriad:</p>


<ul>
<li>Swift doesn’t have support for private variables, so you clutter the global namespace (and you know, it’s a public variable) <sup class="footnote-ref" id="fnref:5"><a href="#fn:5" rel="footnote">2</a></sup></li>
<li>You can’t push it to a class-level constant <sup class="footnote-ref" id="fnref:1"><a href="#fn:1" rel="footnote">3</a></sup></li>
<li>Nothing says ‘this is probably a bad approach’ like prepending a variableName with an underscore</li>
</ul>


<h2 id="singleton-a-la-dispatch-once">Singleton a la <code>dispatch_once</code></h2>


<p>Basically a straight port of the traditional Objective-C approach to Swift:</p>


<pre><code>class RetroSingleton {
    class var sharedInstance : RetroSingleton {
        struct Static {
            static var token : dispatch_once_t = 0
            static var instance : Singleton? = nil
        }
        dispatch_once(&amp; Static .token) {
            Static.instance = RetroSingleton()
        }
        return Static.instance!
    }
}
</code></pre>


<p>This is how Apple recommends you implement the pattern in Objective-C: for those unaware <sup class="footnote-ref" id="fnref:3"><a href="#fn:3" rel="footnote">4</a></sup>, <code>dispatch_once</code> is a command to do something exactly once – you pass it a token and a closure to execute once, ensuring that you only hit the instantiation one time.  This, like the global approach, is thread-safe and lazy:  there aren’t any specific disadvantages here, but it’s not a particularly aesthetic approach.</p>


<h2 id="singleton-a-la-nested-struct">Singleton a la nested struct</h2>


<p>My preferred solution to the pattern (for the time being), as I find it the prettiest:</p>


<pre><code>class NestedSingleton {

    class var sharedInstance : NestedSingleton {
        struct Static {
            static let instance : NestedSingleton = NestedSingleton()
        }
        return Static.instance
    }

}
</code></pre>


<p>Unlike classes, <code>struct</code>s <em>do</em> support static constants!  So we create a class-level property for the singleton class which, when accessed, grabs the struct with the singleton’d property and returns it.  Since we declare the singleton’d property with <code>let</code>, it shares the advantages of the previous two approaches (and only has to be calculated once.)  In <a href="http://www.getbarback.com">Barback</a>, it looks something like this:</p>


<pre><code>class AllRecipes {
    class var sharedInstance : Recipe[] {
        struct Static {
            static let instance : Recipe[] = Static.allRecipes()
            static func allRecipes() -&gt; Recipe[] {
                let filepath = NSBundle.mainBundle().pathForResource("recipes", ofType: "json")
                let jsonData = NSString.stringWithContentsOfFile(filepath, encoding:NSUTF8StringEncoding, error: nil)
                let recipeData = jsonData.dataUsingEncoding(NSUTF8StringEncoding)
                var rawRecipes = NSJSONSerialization.JSONObjectWithData(recipeData, options: nil, error: nil) as NSDictionary[]

                var allRecipes = rawRecipes.map({
                    (rawRecipe: NSDictionary) -&gt; Recipe in
                    return Recipe(rawRecipe: rawRecipe)
                    })
                allRecipes = sort(allRecipes) { $0.name &lt; $1.name }
                return allRecipes
            }
        }
        return Static.instance
    }
}
</code></pre>


<hr/>


<p>That’s all the approaches I’ve found.  If there are other options that I haven’t considered or considerations that I haven’t made <sup class="footnote-ref" id="fnref:4"><a href="#fn:4" rel="footnote">5</a></sup>, lemme know!  Hope this helps.</p>


<div class="footnotes">
<hr/>
<ol>
<li id="fn:2">See [here](<a href="https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Properties.html#//apple_ref/doc/uid/TP40014097-CH14-XID_337">https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Properties.html#//apple_ref/doc/uid/TP40014097-CH14-XID_337</a>
<a class="footnote-return" href="#fnref:2"><sup>[return]</sup></a></li>
<li id="fn:5">As of beta 4, this is no longer true.  Access control is now a thing.
 <a class="footnote-return" href="#fnref:5"><sup>[return]</sup></a></li>
<li id="fn:1">Though Chris Lattner has mentioned that this is an eventual possibility!
 <a class="footnote-return" href="#fnref:1"><sup>[return]</sup></a></li>
<li id="fn:3">Like myself, until very recently!
 <a class="footnote-return" href="#fnref:3"><sup>[return]</sup></a></li>
<li id="fn:4">This is very likely.
 <a class="footnote-return" href="#fnref:4"><sup>[return]</sup></a></li>
</ol>
</div>
	