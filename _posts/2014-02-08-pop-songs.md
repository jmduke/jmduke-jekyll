---
title: "Pop songs"
Date: 2014-02-08 00:00:00
Tags: ["data"]
layout: post
---

<p>I listen to a lot of music, some of it good.</p>


<p>I listen to MFDOOM.  I listen to Paul Simon.  I listen to Kanye.  I listen to Stars, and The Hold Steady, and Fall Out Boy.  I listen to The Weepies and Katy Perry and Nujabes and Chance the Rapper.  I listen to pop and Sub Pop and rap and ‘indie’.  There is nothing analytic about my taste in music: it would take nobody very long to find something in my iTunes library <sup class="footnote-ref" id="fnref:1"><a href="#fn:1" rel="footnote">1</a></sup> at which to recoil in disgust.</p>


<p>Despite music being incredibly industrial, there’s nothing inherently numerical about it. But you can gather a thousand people in a room and none of them can convince me that the way a song hits you, the way a song throws you to the ground, the way a song grabs your limbs and forces you to dance – none of them can convince me that that feeling isn’t immortal and immeasurable.</p>


<p>The above paragraphs are an ambling prelude to this: I have acquired a large file filled with data for thirty thousand pop songs, let’s have some fun.</p>


<p><strong>Let’s pretend, for a fleeting moment, that you are a data-driven songwriter.</strong></p>


<h3 id="how-long-should-your-song-be">How long should your song be?</h3>


<p>This is an easy question to answer: the best songs in the world are the ones which appear on Billboard, and the best songs in the world must have optimal timing.  We can figure this out by crafting a histogram of song lengths, as seen below:</p>


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
parse("/static/pop_songs_b1.json");
</script>


<p>Interestingly, there are two peaks in song lengths: you can be a three minute song or a four minute song.  There are many good three-and-a-half minute songs, but why struggle in that nadir?  Either cull that unnecessary bridge or add an extra verse.</p>


<p>This is a somewhat flawed picture, though, because the will of the populace in the 1970’s may have clamored for a different optimal song length than those of day.  Graphing average song lengths over time reveals an interesting trend:</p>


<p></p>
<div id="vis2"></div>


<script type="text/javascript">
// parse a spec and create a visualization view
function parse(spec) {
  vg.parse.spec(spec, function(chart) { chart({el:&ldquo;#vis2&rdquo;}).update(); });
}
parse(&ldquo;/static/pop_songs_l1.json&rdquo;);
</script>


<p>Note that we hit a valley of expediency <sup class="footnote-ref" id="fnref:2"><a href="#fn:2" rel="footnote">2</a></sup> in the years leading up to the 1960’s, with a steady climb in length for the three decades following.  With the mid rush of the 90’s came the appreciated death of the flue-minute RnB slow jam, and we’re slowly approaching a length of – three and a half minutes?  Really?  Shit.</p>


<h3 id="what-should-you-name-your-song">What should you name your song?</h3>


<p>We can grab each word and each track, take out the boring words like “The” and “and” and “me” and “you” <sup class="footnote-ref" id="fnref:3"><a href="#fn:3" rel="footnote">3</a></sup>, and count them all up, getting something like this:</p>


<pre><code>Counter({'love': 2866, "don't": 899, "i'm": 735, 'little': 714, 'heart': 598, 'baby': 549, 'one': 536, 'time': 535, "it's": 514, 'get': 487, 'girl': 480, 'like': 474, 'got': 458, 'man': 450, 'night': 447, 'song': 426, 'go': 425, "can't": 421, 'back': 385, "you're": 376, 'good': 372, 'way': 364, 'want': 359, 'old': 349, 'come': 347, 'home': 341, 'never': 334, 'let': 329, "i'll": 328, 'blue': 319, 'know': 317, 'world': 298, 'day': 296, 'take': 288, 'blues': 284, 'sweet': 275, 'away': 267, 'make': 265, 'life': 257, 'say': 243, 'eyes': 235... # omitted for length.
</code></pre>


<p>To make this more visually appealing, we can put it in a word cloud, like this:</p>


<p><a href="http://imgur.com/zqpcrEK"><img src="http://i.imgur.com/zqpcrEK.png" title="Hosted by imgur.com"/></a></p>


<p>The conclusion here is painfully obvious: if you are a songwriter and you want to become famous, name your song <strong>One Love Don’t Hurt My Little Heart, Baby</strong>.  Or, alternatively, <strong>My Baby, My One Little Loving Heart</strong>.  Or, alternatively, <strong>Get My Baby In the Night, Love Her Heart</strong>.</p>


<h3 id="how-many-hit-songs-will-your-band-produce">How many hit songs will your band produce?</h3>


<p>First, I will give you the most honest answer possible: judging by the past hundred or so years, you will produce <strong>4.42</strong> hit songs over the course of your lifetime.  Four of them will be glorious: one will be 42% as glorious as the rest.</p>


<p>We can take a look at this broken down annually, but there is no escaping the inexorable truth: you will probably not produce more than a dozen good songs in your lifetime <sup class="footnote-ref" id="fnref:4"><a href="#fn:4" rel="footnote">4</a></sup>.</p>


<p></p>
<div id="vis3"></div>


<script type="text/javascript">
// parse a spec and create a visualization view
function parse(spec) {
  vg.parse.spec(spec, function(chart) { chart({el:&ldquo;#vis3&rdquo;}).update(); });
}
parse(&ldquo;/static/pop_songs_l2.json&rdquo;);
</script>


<p>Still, out of reverence to the greats, it might be pleasant to contact the most prolific of your peers:</p>


<table>
<thead>
<tr>
<th>Artist</th>
<th>Count</th>
</tr>
</thead>
<tbody>
<tr>
<td>Bing Crosby</td>
<td>293</td>
</tr>
<tr>
<td>Guy Lombardo &amp; His Royal Canadians</td>
<td>218</td>
</tr>
<tr>
<td>Glee Cast <sup class="footnote-ref" id="fnref:5"><a href="#fn:5" rel="footnote">5</a></sup></td>
<td>208</td>
</tr>
<tr>
<td>Paul Whiteman &amp; His Orchestra</td>
<td>188</td>
</tr>
<tr>
<td>Elvis Presley</td>
<td>159</td>
</tr>
<tr>
<td>Frank Sinatra</td>
<td>159</td>
</tr>
<tr>
<td>Tommy Dorsey &amp; His Orchestra</td>
<td>137</td>
</tr>
<tr>
<td>Perry Como</td>
<td>135</td>
</tr>
<tr>
<td>Glenn Miller &amp; His Orchestra</td>
<td>127</td>
</tr>
<tr>
<td>Billy Murray</td>
<td>122</td>
</tr>
<tr>
<td>Ted Lewis &amp; His Band</td>
<td>103</td>
</tr>
<tr>
<td>Ben Selvin &amp; His Orchestra</td>
<td>102</td>
</tr>
</tbody>
</table>


<p>Please note that history has deemed the cast of <em>Glee</em> more noteworthy than Frank Sinatra.</p>


<h3 id="coda">Coda</h3>


<p>Feeble attempts at humor aside, I hope you gleamed some modicum of knowledge or joy from the above!  I honestly do love the nerdier side of music consumption – one of these days I’ll take a pickaxe to my scribbles – and I think this kind of stuff is immensely interesting, even if it doesn’t necessarily apply to the core act of listening.  You can download the IPython Notebook i used for all of the above <a href="/static/pop_songs.ipynb">here</a>.</p>


<div class="footnotes">
<hr/>
<ol>
<li id="fn:1">Or, more recently, my LastFM feed.
 <a class="footnote-return" href="#fnref:1"><sup>[return]</sup></a></li>
<li id="fn:2">Less than two and a half minutes!  My stars and garters!
 <a class="footnote-return" href="#fnref:2"><sup>[return]</sup></a></li>
<li id="fn:3">These are called <em>stopwords</em>.  This knowledge will never be useful.
 <a class="footnote-return" href="#fnref:3"><sup>[return]</sup></a></li>
<li id="fn:4">Though your chances increase considerably if you invent a time machine and travel back to the 1940’s.  Who would have guessed that America had a thing for institutions?
 <a class="footnote-return" href="#fnref:4"><sup>[return]</sup></a></li>
<li id="fn:5">Yep, the cast of <em>Glee</em>.
 <a class="footnote-return" href="#fnref:5"><sup>[return]</sup></a></li>
</ol>
</div>
	