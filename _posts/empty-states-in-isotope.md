---
Title: "Empty states in Isotope"
Date: 2015-12-12 00:00:00
Tags: ["isotope"]
---

<p>The main recipe viewer runs on <a href="http://isotope.metafizzy.co/">Isotope</a>, using its helpful <code>filter</code> property to provide instant animated search:</p>


<pre><code>container.isotope({
    filter: function() {
        // return boolean here
    }
  });
</code></pre>


<p>With filterable lists, though, its helpful to provide some sort of ‘empty state’ indication, to let users know that what they’re looking at is <em>supposed</em> to be empty, and not merely a victim of a bad network call or internal error.</p>


<p>(There’s actually an entire <a href="http://emptystat.es/">blog</a> devoted to exploring empty states, which is definitely worth a perusal.)</p>


<p>Anyway, I wanted to get some sort of similar functionality going for the <a href="http://getbarback.com">main recipe browser</a>, so looked into elegant ways to handle it within Isotope.</p>


<p>Turns out this is fairly simple to do, thanks to Isotope exposing a <code>filteredItems</code> property which is a selector on all visible elements:</p>


<pre><code>// Returns list of filtered, visible items
container.data('isotope').filteredItems.length
</code></pre>


<p>You can easily play with this to make a check whether or not <em>any</em> items are visible:</p>


<pre><code>  if ( !container.data('isotope').filteredItems.length ) {
    // Empty state
  } else {
    // Non-empty state
  }
</code></pre>


<p>At that point, all you have to do is create an empty state <code>div</code>, hide it by default, then show/hide it depending on the above clause:</p>


<pre><code>  if ( !container.data('isotope').filteredItems.length ) {
    $('.container-empty-state').show();
  } else {
    $('.container-empty-state').hide();
  }
</code></pre>
	