---
Title: "Mining Twitter to discover how bad I am at Threes"
Date: 2014-02-23 00:00:00
Tags: ["data"]
---

<p><a href="http://asherv.com/threes/">Threes</a> is a wonderful game and also horribly addictive.  If you haven’t yet had the misfortune of getting ensnared by its cartoonish eldritch tentacles, I recommend it wholeheartedly.  While the game continues on its inexorable march to rob the productivity of nerdy types everywhere, you can tell that its already inspired a particular brand of developer fervor:</p>


<ul>
<li>On GitHub, developers are working on <a href="https://github.com/luin/Threes-AI">open source AIs</a></li>
<li>Over at TouchArcade, people are <a href="http://forums.toucharcade.com/showthread.php?p=3142161#post3142161">hammering out proofs</a> about the minimum possible number of tiles</li>
<li>And, the true mark of success, Threes has already spawned <a href="https://itunes.apple.com/app/id819357694?mt=8">a Chinese knockoff</a></li>
</ul>


<p>Personally, I was interested in discovering the general distribution of scores in the game: having broken the five-digit mark yesterday, I was curious to see how I stacked up against the rest of the world.  <sup class="footnote-ref" id="fnref:1"><a href="#fn:1" rel="footnote">1</a></sup>  Knowing that the game had a “tweet your score” function that, judging by my Twitter feed, a surprising amount of the world uses, I decided to fire up Sublime Text and get to work.</p>


<p>The vast majority of tweets were composed using the default template, which looks something like this:</p>


<blockquote>
<p>I just scored 3,384 in @ThreesGame! <a href="http://threesgame.com">http://threesgame.com</a>  pic.twitter.com/bq3lqq1nIT</p>
</blockquote>


<p>As a result, I could just search for “I just scored” and the specific handle and grabbing the data would be relatively easy <sup class="footnote-ref" id="fnref:2"><a href="#fn:2" rel="footnote">2</a></sup>.</p>


<pre><code>api = TwitterAPI(consumer_key, consumer_secret, access_token_key, access_token_secret)
tweets = TwitterRestPager(api, 'search/tweets', {'q':'@ThreesGame'})
while True:
    try:
        for tweet in tweets.get_iterator():
            text = tweet.get('text')

            if not text or "I just scored" not in text:
                continue

            score = re.findall(r"[\d\,]+", text)[0]
            score = score.replace(",", "")

            username = tweet.get('user').get('screen_name')
            timestamp = tweet.get('created_at')
            tweet_id = str(tweet.get('id'))

            print ",".join((score, username, timestamp, tweet_id))
</code></pre>


<p>And, armed with the csv data, we could load it into <code>pandas</code> and get some quick summary statistics <sup class="footnote-ref" id="fnref:3"><a href="#fn:3" rel="footnote">3</a></sup>:</p>


<pre><code>import pandas as pd
tweets = pd.read_csv('threes.csv')
print tweets['score'].describe()
</code></pre>


<div style="font-family: Inconsolata">
count      7331.000000 <br/>
mean       7039.220161<br/>
std        9898.609367<br/>
min           0.000000<br/>
25%        2325.000000<br/>
50%        3435.000000<br/>
75%        9112.500000<br/>
max      236484.000000
</div>


<p>Not bad!  Looks like I placed in the top quartile <sup class="footnote-ref" id="fnref:4"><a href="#fn:4" rel="footnote">4</a></sup>, though like with all games there are a few outliers who are crazy good.  I’m looking at you, <a href="https://twitter.com/natenewbie/status/437212351528321024">@natenewbies</a> – unfortunately for my ego, that 236484 score is all too real.</p>


<p>Still, what’s the point of a huge array if we don’t graph it, right?  First, we can bin them with sizes of 500 and see some cool stuff:</p>


<pre><code>import vincent
score_distribution = np.histogram(list(tweets['score']), bins=map(lambda x: x * 500, range(200)))
score_distribution = pd.DataFrame(score_distribution[0], index=score_distribution[1][:-1])
area = vincent.Area(score_distribution)
area.axis_titles(x='Score (grouped by 500)', y='Frequency')
area.to_json('threes_area.json', html_out=True, html_path='threes_area.html')
</code></pre>


<script charset="utf-8" src="http://d3js.org/d3.v3.min.js"></script>


<script src="http://d3js.org/topojson.v1.min.js"></script>


<script charset="utf-8" src="http://d3js.org/d3.geo.projection.v0.min.js"></script>


<script src="http://trifacta.github.com/vega/vega.js"></script>


<div class="vis" id="vis1"></div>


<script type="text/javascript">
// parse a spec and create a visualization view
function parse(spec) {
  vg.parse.spec(spec, function(chart) { chart({el:"#vis1"}).update(); });
}
parse("/static/threes_area.json");
</script>


<p>It’s entertaining to see the distribution of score packets.  Your score in Threes is <a href="http://bitsplitting.org/2014/02/11/threes-scoring/">roughly exponential based on the tiles themselves</a> – getting a 6 only gives you 9 points, whereas a 3072 nets you a whopping 177,147.  We can jack up the bin size from 500 points to 2000 points, to make things a little more pleasant to look at:</p>


<p></p>
<div class="vis" id="vis3"></div>


<script type="text/javascript">
// parse a spec and create a visualization view
function parse(spec) {
  vg.parse.spec(spec, function(chart) { chart({el:&ldquo;#vis3&rdquo;}).update(); });
}
parse(&ldquo;/static/threes_area2.json&rdquo;);
</script>


<p>This is illustrated a bit more clearly with a cumulative frequency chart <sup class="footnote-ref" id="fnref:5"><a href="#fn:5" rel="footnote">5</a></sup>:</p>


<pre><code>cumulative_frequency = [0]
all_scores = list(tweets['score'])
thresholds = range(0, int(max(map(float, all_scores))), 50)
for threshold in thresholds:
    for score in all_scores:
        if score &lt; threshold:
            cumulative_frequency[-1] += 1
            all_scores.pop(all_scores.index(score))
    cumulative_frequency.append(cumulative_frequency[-1])

cumulative_frequency = map(lambda x: float(x) / len(list(tweets['score'])) * 100, cumulative_frequency)

line = vincent.Line(cumulative_frequency, thresholds)
line.axis_titles(x='Score', y='Percentage')
line.to_json('threes_line.json', html_out=True, html_path='threes_line.html')
</code></pre>


<p></p>
<div class="vis" id="vis2"></div>


<script type="text/javascript">
// parse a spec and create a visualization view
function parse(spec) {
  vg.parse.spec(spec, function(chart) { chart({el:&ldquo;#vis2&rdquo;}).update(); });
}
parse(&ldquo;/static/threes_line.json&rdquo;);
</script>


<p>Note the jumps at certain thresholds, corresponding with hitting each tile and collecting the fat exponential score bonus.  The curves are a bit prettier at full fidelity – I had to sample the distribution at every 50 points because JavaScript doesn’t like rendering graphs with a hundred thousand points – but you still get the general sense of things.</p>


<p>So, in conclusion: if you’re in the trenches of being stuck on 192s and 384s like me, you have quite a ways to go.  If you’re spawning <a href="https://twitter.com/triferatu">Triferati</a> like there’s no tomorrow, then you can truly consider yourself a member of the Threes 1%.  And if you’re interested in checking out the data yourself, you can download it <a href="/static/threes.csv">here</a>.</p>


<div class="footnotes">
<hr/>
<ol>
<li id="fn:1">Spoiler alert – pretty poorly.
 <a class="footnote-return" href="#fnref:1"><sup>[return]</sup></a></li>
<li id="fn:2">Yeah, theoretically someone could tweet the exact same content with a bogus score and throw everything off, but who cares?
 <a class="footnote-return" href="#fnref:2"><sup>[return]</sup></a></li>
<li id="fn:3">If you’re following along at home: I added headers to the csv file before reading it because I was too lazy to do it programmatically.
 <a class="footnote-return" href="#fnref:3"><sup>[return]</sup></a></li>
<li id="fn:4">Which definitely makes up for my complete inability to play chess, right?
 <a class="footnote-return" href="#fnref:4"><sup>[return]</sup></a></li>
<li id="fn:5"><code>thresholds</code> is possibly the most unnecessarily complicated line of Python I’ve ever written.  So compact, though!
 <a class="footnote-return" href="#fnref:5"><sup>[return]</sup></a></li>
</ol>
</div>
	