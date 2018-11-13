---
Title: "Avoiding UICollectionViewController crashes when reloading data"
Date: 2017-01-10 00:00:00
Tags: ["swift"]
---

<p>This honestly is less of a post and more of a public service announcement, because as I was migrating a bunch of UITableViews in <a href="http://getbarback.com">Barback</a> to UICollectionViews I ran into an apparently obscure problem:</p>


<ol>
<li>The backing data store of the UICollectionView (let’s call it <code>items: [String]</code>) changes.</li>
<li>When that happens, we want to call <code>self.collectionView.reloadData</code> to update the collection view.</li>
<li>Naturally, the app then crashes with <code>UICollectionView received layout attributes for a cell with an index path that does not exist</code></li>
<li>Wait, what?</li>
</ol>


<p>Yeah, I ran into this and it was surprisingly difficult to find an answer for, given that it seems like such a basic problem!</p>


<p>The answer is simple, to change this:</p>


<pre><code>var items: [String] = [] {
    didSet {
        self.collectionView?.reloadData()
    }
}
</code></pre>


<p>To this:</p>


<pre><code>var items: [String] = [] {
    didSet {
        self.collectionView?.reloadData()
        self.collectionViewLayout.invalidateLayout()
    }
}
</code></pre>


<p>That’s literally all you have to do: let the collection view’s layout object know that it’s not valid any more, since the data that the layout is based off of is no longer valid.</p>


<p>(I hope this helps, and saves you a couple minutes of research!)</p>
	