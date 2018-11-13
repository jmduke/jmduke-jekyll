---
Title: "Checking for Debug mode in Swift"
Date: 2017-02-06 00:00:00
Tags: ["swift"]
---

<p>There are often a bunch of times where you want to write Swift code that only executes when you’re in Debug mode.  Some
obvious examples:</p>


<ul>
<li>Hiding ads when you generate screenshots</li>
<li>Logging and printing to console</li>
<li>Using a local developer/staging endpoint instead of the production one.</li>
</ul>


<p>Still, this can kind of be a pain to manage. The Objective-C mainstay (which still works in Swift) is this very clunky
macro:</p>


<pre><code>#if DEBUG
    let a = 2
#else
    let a = 3
#endif
</code></pre>


<p>This, to me, is super gross: it’s imperative, clashes with other Swift syntax, and is hard to parse or do clever things with.</p>


<p>However, I stumbled on a little known (and, in my opinion, better) solution that checks the build configuration of your project:</p>


<pre><code>_isDebugAssertConfiguration() -&gt; Bool
</code></pre>


<p>Yup, that’s all you need to call: it’s a globally available function.</p>


<p>The method invocation on its own is a little clunky, so I bind it to a global struct that I use:</p>


<pre><code>struct Utilities {
  // other stuff, too.
  static let isDebug = _isDebugAssertConfiguration()
}
</code></pre>


<p>Which means I can now use it in guards and lets and all sorts of things!</p>


<p>For instance, to bail out of functions early if I’m in debug mode:</p>


<pre><code>// The first section only contains the ad..
// We hide the ad in debug mode so we can generate nicer screenshots.
override func tableView(_ tableView: UITableView,
                        numberOfRowsInSection section: Int) -&gt; Int {
    let sectionIsAdSection = section == 0
    let numberOfCellsInAdSection = Constants.isDebug ? 0 : 1
    return sectionIsAdSection ?
        numberOfCellsInAdSection :
        matchingAnswers[section - 1].count
}
</code></pre>


<p>Some obvious caveats apply with this approach (it’s a flaky function that might get removed at some point, and it’s
not publicly documented) but it’s worked great for me and I recommend trying it out rather than scattering your codebase
with clunky <code>#if DEBUG</code> invocations.</p>
	