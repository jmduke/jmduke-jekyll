---
Title: "Trends in AV Club reviews"
Date: 2014-03-03 00:00:00
Tags: ["data"]
---

<p>I love the <a href="http://www.avclub.com">AV Club</a>, probably to an unhealthy extent.  It’s one of my favorite little corners of the internet – one where people swap <em>Twin Peaks</em> references and write thousand-word diatribes on <a href="http://www.avclub.com/article/everyones-an-architect-11-jobs-common-only-in-roma-201073">the odd prevalance of architects in romantic comedies</a>.</p>


<p>It’s also a potential data source ripe for amateur analysis: the AV Club staff reviews a surprising number of shows on a weekly basis, assigning a letter grade to the writeup.  Since this data is linked to the author and the show itself – and has some built-in granularity, given that series come in seasons and episodes – I thought it would be fun to try and scrape all the data and look at some big-picture analysis about the grades being assigned. <sup class="footnote-ref" id="fnref:1"><a href="#fn:1" rel="footnote">1</a></sup></p>


<p>And, similarly to one of my earlier posts about <a href="http://jmduke.com/posts/analysing-pitchfork-using-pandas/">analyzing Pitchfork grades</a>, I thought that looking at all of their television reviews would be a fun way to spend an afternoon.</p>


<p>Scraping the data wasn’t too bad, though I learned an important lesson about the follies of deduping pages based solely on the URL <sup class="footnote-ref" id="fnref:2"><a href="#fn:2" rel="footnote">2</a></sup>.  I thought the most salient piece of information would be a simple breakdown by grade:</p>


<pre><code>import pandas as pd
import json
import vincent

data = filter(lambda r: r.get('grade') != '-' and len(r.get('season')) == 1, map(json.loads, open('outy.txt').readlines()))
data = pd.DataFrame(data)
grades = data.groupby('grade').count()['date']
vis = vincent.Bar(grades)
</code></pre>


<script charset="utf-8" src="http://d3js.org/d3.v3.min.js"></script>


<script src="http://d3js.org/topojson.v1.min.js"></script>


<script charset="utf-8" src="http://d3js.org/d3.geo.projection.v0.min.js"></script>


<script src="http://trifacta.github.com/vega/vega.js"></script>


<div id="vis1"></div>


<script type="text/javascript">
// parse a spec and create a visualization view
function parse(spec) {
  vg.parse.spec(spec, function(chart) { chart({el:"#vis1"}).update(); });
}
parse("/static/avbar.json");
</script>


<p>Keeping in mind that this is a uniform weighting of all reviews, the results are somewhat surprising: the graph is centered around a B+, with a pretty rad bell curve on either side.</p>


<p>If you can’t tell, there’s like a one-pixel sliver for <strong>A+</strong>, which made me curious as to what received the vaunted grade.  Turns out, not exactly what I’d expect:</p>


<pre><code>print data[data['grade'] == 'A+']
</code></pre>


<ul>
<li>Two episodes of <em>Curb Your Enthusiasm</em></li>
<li>An episode of <em>Undeclared</em></li>
<li>The season two finale of <em>West Wing</em> <sup class="footnote-ref" id="fnref:3"><a href="#fn:3" rel="footnote">3</a></sup></li>
<li>And, uh, a <a href="http://www.avclub.com/tvclub/american-idol-1-of-6-voted-off-40595">random episode from the ninth season of American Idol</a></li>
</ul>


<p>What about a show-by-show breakdown of average grades?  (Apologies for if this breaks your browser):</p>


<pre><code># Sort shows by average grade
def grade_count(grade):
    return ['A+', 'A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'D+', 'D', 'D-', 'F'][::-1].index(grade)

data['grade'] = [grade_count(g) for g in data['grade']]
actual_shows = (data.groupby('show').count()['show'] &gt; 3).values
actual_shows = data.groupby('show').mean()[actual_shows]['grade'].order()
vis = vincent.Area(actual_shows)
</code></pre>


<p></p>
<div id="vis2" style="margin-left: -180px"></div>


<script type="text/javascript">
// parse a spec and create a visualization view
function parse(spec) {
  vg.parse.spec(spec, function(chart) { chart({el:&ldquo;#vis2&rdquo;}).update(); });
}
parse(&ldquo;/static/avbar2.json&rdquo;);
</script>


<p>So this is a very pretty graph that tells us more or less what we already know: there are a handful of very good shows (the peak on the far right), a handful of awful ones (far left), and a pretty balanced spectrum of everything in between.  What are those outliers specifically?</p>


<ul>
<li>On the truly abhorrent side of television, we have <em>Hostages</em>, <em>The Following</em>, <em>Heroes</em>, <em>Low Winter Sun</em>, and <em>V</em>.  Which pretty much all make sense, though I have a special place in my heart for the first season of <em>Heroes</em>. <sup class="footnote-ref" id="fnref:4"><a href="#fn:4" rel="footnote">4</a></sup></li>
<li>When it comes to transcending television,  we have <em>Luck</em>, <em>The Shield</em>, <em>Seinfeld</em>, <em>Generation Kill</em>, and <em>The Wire</em>.  Naturally, this leads us to the groundbreaking relevation that HBO produces a lot of critically acclaimed television.</li>
</ul>


<p>It’s also relatively painless to test the evergreen theory that reviewers get softer over time, by graphing average grades over time:</p>


<pre><code>data['year'] = [int(d.split()[-1]) for d in data['date']]
years = data.groupby('year').mean()
vis = vincent.Line(years)
</code></pre>


<p></p>
<div id="vis3"></div>


<script type="text/javascript">
// parse a spec and create a visualization view
function parse(spec) {
  vg.parse.spec(spec, function(chart) { chart({el:&ldquo;#vis3&rdquo;}).update(); });
}
parse(&ldquo;/static/avbar3.json&rdquo;);
</script>


<p>Looks like there’s a slight downward trend, but nothing worth noticing.  (The other, more likely, possibility is that the review staff has expanded and taken in a wider breadth of regularly reviewed shows, including some worse ones.) <sup class="footnote-ref" id="fnref:5"><a href="#fn:5" rel="footnote">5</a></sup></p>


<p>And, lastly, we can get a pleasant trajectory of television quality by graphing grades on a season-by-season basis:</p>


<pre><code>grades = data.groupby('season').mean()['grade']
vis = vincent.Line(grades)
</code></pre>


<p></p>
<div id="vis4"></div>


<script type="text/javascript">
// parse a spec and create a visualization view
function parse(spec) {
  vg.parse.spec(spec, function(chart) { chart({el:&ldquo;#vis4&rdquo;}).update(); });
}
parse(&ldquo;/static/avbar4.json&rdquo;);
</script>


<p>What’s interesting here is how well the grades match the general narrative: great shows usually take a season or two to work out the jitters <sup class="footnote-ref" id="fnref:6"><a href="#fn:6" rel="footnote">6</a></sup> and then enjoy a few golden years before a state of general decline.</p>


<div class="footnotes">
<hr/>
<ol>
<li id="fn:1">The AV Club maintains that there aren’t any <em>real</em> significance to the grades, but that’s no fun.
 <a class="footnote-return" href="#fnref:1"><sup>[return]</sup></a></li>
<li id="fn:2">I’ll give you a hint – one of the many, <em>many</em> URLs <code>scrapy</code> ran into was “<a href='http://www.avclub.com/search?feature_types=tv-club&amp;page=1&amp;page=2&amp;page=3&amp;page=4"'>http://www.avclub.com/search?feature_types=tv-club&amp;page=1&amp;page=2&amp;page=3&amp;page=4"</a>.
 <a class="footnote-return" href="#fnref:2"><sup>[return]</sup></a></li>
<li id="fn:3">For my money, the best two hours of television ever produced.
 <a class="footnote-return" href="#fnref:3"><sup>[return]</sup></a></li>
<li id="fn:4">Perhaps more accurately, I have a special place in my heart for Hayden Panettiere.  Or, rather, I did before she started dating Milo Ventimiglia, which is weird.
 <a class="footnote-return" href="#fnref:4"><sup>[return]</sup></a></li>
<li id="fn:5">Or, perhaps, television is slowly but surely getting worse.  Judging by a linear regression of this graph, by ~2063 television will be, on average, a D-.
 <a class="footnote-return" href="#fnref:5"><sup>[return]</sup></a></li>
<li id="fn:6">Exhibit A: <em>Parks and Recreation</em>.
 <a class="footnote-return" href="#fnref:6"><sup>[return]</sup></a></li>
</ol>
</div>
	