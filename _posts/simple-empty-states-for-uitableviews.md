---
Title: "Simple empty states for UITableViews"
Date: 2014-10-21 00:00:00
Tags: ["development","ios"]
---

<p>Even if you’re not familiar with the term, you’ve probably run into empty states before in apps you’ve used:</p>


<p><style type="text/css">
  img {
    width: 40%;
    margin-left: 5%;
    margin: 1em;
  }
</style>
<img alt="" src="http://cdn.pttrns.com/pttrns/3259/small/IMG_0880.PNG"/></p>


<p><img alt="" src="http://cdn.pttrns.com/pttrns/3015/small/IMG_0296.PNG"/></p>


<p><img alt="" src="http://cdn.pttrns.com/pttrns/2492/small/IMG_4530.PNG"/></p>


<p>It’s a nice little detail that accomplishes two goals:</p>


<ol>
<li>It’s a nice little detail that tells your users you care about the nice little things.</li>
<li>It’s a nice little detail that tells your users that they don’t have to spend five minutes waiting for a screen to load because there’s just nothing there.</li>
</ol>


<p>I wanted to implement this in <a href="http://getbarback.com">Barback</a> for the edge case that a user had no active favorites.  StackOverflow yielded a bunch of different results, most of them revolving around throwing another UIView together in Interface Builder and doing a bunch of gross conditionals to toggle off its <code>hidden</code> attribute.</p>


<p>I thought that was sort of gross and, more importantly, I am a lazy person.  Thankfully, I found a tidy little solution: the <code>backgroundView</code> attribute of any good old-fashioned <code>UITableView</code>.</p>


<p>All you have to do is throw something looking like the bottom into your <code>viewDidAppear</code> <sup class="footnote-ref" id="fnref:1"><a href="#fn:1" rel="footnote">1</a></sup>:</p>


<pre><code>    // Load empty state view if necessary.
    if tableView(tableView, numberOfRowsInSection: 1) == 0 {
        let emptyStateLabel = UILabel(frame: tableView.frame)
        emptyStateLabel.text = "When you mark a recipe as a favorite, it'll show up here."

        // style it as necessary

        tableView.backgroundView = emptyStateLabel
    } else {
        tableView.backgroundView = nil
    }
</code></pre>


<p>And now you get something like this!</p>


<p><img alt="Imgur" src="http://i.imgur.com/qkJPJQp.gif"/></p>


<p>Hope this helped!  And, if you’d excuse me, I’m off to fix the three animation issues revealed by recording that gif.  <sup class="footnote-ref" id="fnref:2"><a href="#fn:2" rel="footnote">2</a></sup></p>


<div class="footnotes">
<hr/>
<ol>
<li id="fn:1">I put this in viewDidAppear because the number of rows in this particular table can only change within a separate view controller.  If that’s not true, you’ll need to place it in a more appropriate location – ideally its own separate function.
 <a class="footnote-return" href="#fnref:1"><sup>[return]</sup></a></li>
<li id="fn:2">This is the part where I grumble about animation delays in UIKit, but that’s a much longer and much more unpleasant post.
 <a class="footnote-return" href="#fnref:2"><sup>[return]</sup></a></li>
</ol>
</div>
	