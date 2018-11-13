---
Title: "Graphing the sentences of your favorite authors"
Date: 2014-01-19 00:00:00
Tags: ["data"]
---

<p>I’ve been reading through <em>On the Road</em> this week (which is great, by the way, even if you’re worried about being seen as the kind of person who reads <em>On The Road</em>), and was impressed by Kerouac’s characteristic stream-of-consciousness writing style.  Curious about how it compared mechanically to other beloved authors of mine, I decided to fire up Python and do some basic analysis.  Below is the numbers of syllables per sentence in the first hundred sentences of writing samples from a bunch of likable dudes:</p>


<script charset="utf-8" src="http://d3js.org/d3.v3.min.js"></script>


<script src="http://d3js.org/topojson.v1.min.js"></script>


<script charset="utf-8" src="http://d3js.org/d3.geo.projection.v0.min.js"></script>


<script src="http://trifacta.github.com/vega/vega.js"></script>


<script type="text/javascript">
function cfl(string)
{
    return string.charAt(0).toUpperCase() + string.slice(1);
}

function parse(spec) {
  var h = document.createElement("h4");
  h.innerHTML = cfl(spec);
  document.getElementsByClassName('post')[0].appendChild(h);
  var div = document.createElement("div");
  div.id = spec;
  document.getElementsByClassName('post')[0].appendChild(div);
  vg.parse.spec("/static/" + spec + ".json", function(chart) { chart({el:"#" + spec}).update(); });
}
parse("fitzgerald");
parse("nabokov");
parse("dickens");
parse("joyce");
parse("hemingway");
parse("milton");
parse("kerouac");
parse("vonnegut");
</script>


<p>(Note: as Reddit user <a href="http://www.reddit.com/r/dataisbeautiful/comments/1vlrmk/oc_graphing_the_sentences_of_your_favorite_authors/cetl94y">/u/cincodenada</a> points out, these should really be bar graphs since they aren’t reflecting time-series or continuous data.  Unfortunately, I was having some issues getting the data to render as bar graphs at an acceptable speed.)</p>


<p>Without becoming a full-blown armchair literary critic, there are a bunch of fun observations you can make here:</p>


<ul>
<li>Dickens and Hemingway fulfill their stereotype of economical prose, with a few elongated digressions.  In particular, Hemingway’s massive spike – from <em>The Snows of Kilimanjaro</em> – is worth quoting:</li>
</ul>


<blockquote>
<p>The cot the man lay on was in the wide shade of a mimosa tree and as he looked out past the shade onto the glare of the plain there were three of the big birds squatted obscenely, while in the sky a dozen more sailed, making quick-moving shadows as they passed.</p>
</blockquote>


<ul>
<li><p>Kerouac’s overwhelming prose comes less from long sentences and more from long thoughts (though there are ample of both).</p></li>
<li><p>Retroactive vindication for thinking Milton was absurdly dense when I had to read it in <em>British Literature</em>.  Averaging one hundred syllables a sentence is absurd.</p></li>
</ul>


<p>I also put this into a table for a significantly more compact (yet significantly less pretty!) view of the data.  Be sure to try clicking the headers:</p>


<table>
<thead>
<tr>
<th>author</th>
<th>words</th>
<th>sentences</th>
<th>words per sentence</th>
<th>flesch-kincaid</th>
<th>syllables per word</th>
</tr>
</thead>
<tbody>
<tr>
<td>kerouac</td>
<td>21829</td>
<td>1281</td>
<td>17</td>
<td>81.2110779239</td>
<td>1.28095652572</td>
</tr>
<tr>
<td>joyce</td>
<td>7609</td>
<td>686</td>
<td>11</td>
<td>94.1033026679</td>
<td>1.20055197792</td>
</tr>
<tr>
<td>hemingway</td>
<td>8930</td>
<td>601</td>
<td>14</td>
<td>89.8165789474</td>
<td>1.21522956327</td>
</tr>
<tr>
<td>milton</td>
<td>5381</td>
<td>83</td>
<td>64</td>
<td>49.7284473146</td>
<td>1.08920275042</td>
</tr>
<tr>
<td>dickens</td>
<td>5542</td>
<td>288</td>
<td>19</td>
<td>85.2575784915</td>
<td>1.20913027788</td>
</tr>
<tr>
<td>fitzgerald</td>
<td>5651</td>
<td>323</td>
<td>17</td>
<td>80.5177101398</td>
<td>1.28915236241</td>
</tr>
<tr>
<td>nabokov</td>
<td>9942</td>
<td>407</td>
<td>24</td>
<td>66.8328756789</td>
<td>1.36692818346</td>
</tr>
<tr>
<td>vonnegut</td>
<td>2417</td>
<td>237</td>
<td>10</td>
<td>83.9083347125</td>
<td>1.33305750931</td>
</tr>
</tbody>
</table>


<p>More proof that Milton is ridiculous and that <a href="http://en.wikipedia.org/wiki/Flesch–Kincaid_readability_tests">Flesch-Kincaid</a> is not exactly the most airtight of measurements – Vonnegut harder to read than Joyce?  Really? (And <em>Ulysseys</em> was the writing sample, mind you.)</p>


<p>From a programming perspective, nothing of note – feel free to <a href="https://gist.github.com/jmduke/8501972">check out the script yourself</a> (though you’ll have to grab the writing samples on your own, as I’m too lazy to upload them.)  I am, however, rather proud of my method of finding the number of syllables in a word:</p>


<pre><code>from curses.ascii import isdigit
from nltk.corpus import cmudict as d
is_word = lambda word: isdigit(word[-1])
num_syllables = lambda word: len(filter(is_word, word))
return max(map(num_syllables, d[lowercase]))
</code></pre>
	