---
Title: "PSA: you should be using console.table()"
Date: 2013-03-30 00:00:00
Tags: ["development","web"]
---

<p>As wonderful as the console pane is in Firefox and Chrome, its display functionalities tend to leave much to be desired.</p>


<p>One of the newest tools to help with this – having originated in Firebug and having been relatively recently ported over to Chrome’s main build – is <code>console.table()</code>, which lets you print tables to the console!  As simple as it sounds, I’ve found it to be an incredibly useful tool, especially when working with some <a href="http://d3js.org/">visualization</a> <a href="https://variancecharts.com/examples/">toys</a> where a little structure goes a long way.</p>


<p>The most obvious way to use the command is to pass it a two-dimensional array:</p>


<pre><code>console.table([[1,2,3], [4,5,6], [7,8,9]]);
</code></pre>


<p><img alt="" src="http://imgur.com/Z6BRur2.png"/></p>


<p>It also takes a second, optional argument of columns, only printing those specific ones:</p>


<pre><code>console.table([[1,2,3], [4,5,9], [7,8,15]], [0, 2]);
</code></pre>


<p><img alt="" src="http://imgur.com/scrKBo3.png"/></p>


<p>You can also pass a list of dicts, which is advantageous in that you get actual column headers <sup class="footnote-ref" id="fnref:1"><a href="#fn:1" rel="footnote">1</a></sup>:</p>


<pre><code>console.table([{"first": "John", "last": "Doe"}, {"first": "Jane", "last": "Doe"}, {"first": "Rust", "last": "Cohle"}]);
</code></pre>


<p><img alt="" src="http://imgur.com/Bh2hlpT.png"/></p>


<p>And, with actual column headers, you can specify columns by string:</p>


<pre><code>console.table([{"first": "John", "last": "Doe"}, {"first": "Jane", "last": "Doe"}, {"first": "Rust", "last": "Cohle"}], ["last"]);
</code></pre>


<p><img alt="" src="http://imgur.com/bwgHgDe.png"/></p>


<p>Perhaps even more pragmatically, you can pass arbitrary objects to <code>console.table()</code> and it’ll do a good job of representing them.  Take this only slightly contrived instance, for example:</p>


<pre><code>function Car(make, model, year) {
  return {"make": make, "model": model, "year": year};
}

garage = {};
garage.primary = new Car("Honda", "Accord", 2002);
garage.secondary = new Car("Toyota", "Prius", 2011);
garage.midlife_crisis = new Car("Ford", "Thunderbird", 1964);

console.table(garage);
</code></pre>


<p><img alt="" src="http://imgur.com/eVyasJ8.png"/></p>


<p>Compare that to the default tree view, as provided by <code>console.log()</code> <sup class="footnote-ref" id="fnref:2"><a href="#fn:2" rel="footnote">2</a></sup>:</p>


<p><img alt="" src="http://i.imgur.com/ByquUSb.png"/></p>


<p>And, just like before, you can filter by column:</p>


<pre><code>console.table(garage, ["make", "model"]);
</code></pre>


<p><img alt="" src="http://imgur.com/JytAxFI.png"/></p>


<div class="footnotes">
<hr/>
<ol>
<li id="fn:1">BTW: the columns are sortable.  Just click on the headers.
 <a class="footnote-return" href="#fnref:1"><sup>[return]</sup></a></li>
<li id="fn:2">And four clicks required to decompress the whole thing – the horror!
 <a class="footnote-return" href="#fnref:2"><sup>[return]</sup></a></li>
</ol>
</div>
	