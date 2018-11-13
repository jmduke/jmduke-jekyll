---
Title: "All that glitters: who's giving out Reddit Gold?"
Date: 2014-05-08 00:00:00
Tags: ["data"]
---

<p>I’m a sucker for Reddit, warts and all – communities like /r/python and /r/nba (and, yes, /r/aww) keep me coming back even though I’ve sworn off the default subreddits for quite some time.  One of their revenue streams comes from “Reddit Gold”, which you can buy for yourself or a fellow redditor for $4 – basically a kudos to reward a particularly insightful or hilarious comment, like below:</p>


<p><img alt="Truncated, but you get the point." src="http://i.imgur.com/SGMeifj.png"/></p>


<p>I thought it would be somewhat entertaining to see which subreddits are most generous with their gold.</p>


<p>(Plus, it’d give me a good reason to bust out my new scraping project, <a href="github.com/jmduke/panther">panther</a>, which you can see here.)</p>


<p>Reddit exposes an [browsable feed of all gilded comments](“<a href='http://www.reddit.com/r/all/gilded"'>http://www.reddit.com/r/all/gilded"</a>), and I thought it’d be easy enough to just crawl through that.  Panther’s main function, <code>prowl</code>, takes three arguments – a starting url, a CSS selector (or list of selectors) from which to extract content, and a CSS selector (or list of selectors) from which to generate new links to scrape.  You pass it all of this and it creates a generator which we can iterate through and create a histogram:</p>


<pre><code>url = "http://www.reddit.com/r/all/gilded"
gilded_selector = ".gilded.comment .subreddit"
next_page_selector = ".nextprev a[rel='nofollow next']"
subreddits = {}

generator = panther.prowl(url, gilded_selector, next_page_selector, delay=3)
for results in []:
    for subreddit in results:
        subreddits[subreddit.text] = subreddits.get(subreddit.text, 0) + 1
print subreddits
</code></pre>


<p>And after a few minutes, we get:</p>


<pre><code>{'kpop': 1, 'Smite': 1, 'AskVet': 1, 'golf': 1, 'MapPorn': 3, 'softwareswap': 1, 'whatsthisbug': 1, 'pettyrevenge': 1, 'excel': 2, 'CCW': 1, 'Fitness': 1, 'learndota2': 1, 'Poetry': 1, 'dataisugly': 1, 'quotes': 1, 'wsgy': 5, 'dataisbeautiful': 3, 'nihilism': 1, 'Random_Acts_Of_Amazon': 17, 'relationships': 5, 'GlobalOffensive': 2, 'learnpython': 1, 'freediving': 1, 'unixporn': 2, 'Cardinals': 1, 'harrypotter': 1, 'blog': 14, 'picrequests': 6, 'whowouldwin': 2, 'woahdude': 3, 'WTF': 13, 'bourbon': 1, 'soccer': 4, 'sweden': 1, 'AnimalsBeingDerps': 1, 'MensRights': 1, 'Reds': 1, 'exmormon': 7, 'NewOrleans': 1, 'photoshopbattles': 3, 'Guildwars2': 1, 'freegold': 23, # truncated because you get the point, it's a big dictionary}

sum(subreddits.values())
&gt; 962
</code></pre>


<p>Hm.  That seems like an awfully small total – less than one thousand total?  In disbelief, I reran it outputting the urls as they were being traversed, the last one being <code>http://www.reddit.com/r/all/gilded?count=950&amp;after=t1_ch8yajz</code> <sup class="footnote-ref" id="fnref:1"><a href="#fn:1" rel="footnote">1</a></sup> – which, sure enough, didn’t have a ‘next’ link.  Ugh – while it gives a rough idea of the distribution of gold, it’s hardly an appropriate sample size.</p>


<p>I decided to approach the problem from a different angle.  Instead of grabbing them from r/all/, we can view the gilded comments for a specific subreddit and crawl from there.  So, first, we need a list of popular subreddits.  We’ll get this using panther’s <code>find()</code> method, which takes a url and a CSS selector (or list thereof) and returns matches (basically <code>prowl()</code> without the crawling):</p>


<pre><code># Grab the top 125 subreddits.
url = "http://www.redditlist.com/"
links = panther.find(url, "#yw2 td:nth-child(2) a")
urls  = map(lambda a: a.get('href') + "gilded", links)
</code></pre>


<p>And now we throw that list of jumping-off points into <code>panther</code>:</p>


<pre><code>generator = panther.prowl(urls, gilded_selector, next_page_selector, delay=3)
subreddits = {}
for results in generator:
    for subreddit in results:
        subreddits[subreddit.text] = subreddits.get(subreddit.text, 0) + 1
</code></pre>


<p>This – after more than a few minutes – has the desired effect!</p>


<pre><code>from nvd3 import lineChart, discreteBarChart
import operator

chart = discreteBarChart(name="Reddit Gold", height=300, width=800)
sorted_subreddits = sorted(subreddits.iteritems(), key=operator.itemgetter(1))
chart.add_serie(name="gold", y=[a[1] for a in sorted_subreddits], x=[a[0] for a in sorted_subreddits])
chart.buildhtml()
open('raw_gold.html').write(chart.htmlcontent)
</code></pre>


<p><link href="/static/bower_components/nvd3/src/nv.d3.css" media="all" rel="stylesheet" type="text/css"/>
<script src="/static/bower_components/d3/d3.min.js" type="text/javascript"></script>
<script src="/static/bower_components/nvd3/nv.d3.min.js" type="text/javascript"></script></p>


<div id="RedditGold"><svg style="width:800px;height:300px;margin-left:-50px"></svg></div>


<script type="text/javascript">
    nv.addGraph(function() {
        var chart = nv.models.discreteBarChart();
        chart.showXAxis(false)
        chart.yAxis
        chart.tooltipContent(function(key, y, e, graph) {
            var x = String(graph.point.x);
            var y = String(graph.point.y);
var y = String(graph.point.y);
            tooltip_str = '<center><b>'+key+'</b></center>' + y + ' at ' + x;
            return tooltip_str;
        });
        d3.select('#RedditGold svg')
            .datum(data_RedditGold)
            .transition().duration(500)
            .attr('width', 800)
.attr('height', 300)
            .call(chart);

    return chart;
});data_RedditGold=[{"values": [{"y": 8, "x": "freebies"}, {"y": 9, "x": "humor"}, {"y": 13, "x": "spaceporn"}, {"y": 13, "x": "RoomPorn"}, {"y": 14, "x": "Art"}, {"y": 14, "x": "business"}, {"y": 15, "x": "shutupandtakemymoney"}, {"y": 15, "x": "AbandonedPorn"}, {"y": 15, "x": "gadgets"}, {"y": 16, "x": "history"}, {"y": 17, "x": "LearnUselessTalents"}, {"y": 20, "x": "Documentaries"}, {"y": 20, "x": "listentothis"}, {"y": 21, "x": "DepthHub"}, {"y": 21, "x": "nosleep"}, {"y": 22, "x": "creepy"}, {"y": 23, "x": "InternetIsBeautiful"}, {"y": 24, "x": "wallpapers"}, {"y": 26, "x": "FiftyFifty"}, {"y": 28, "x": "NetflixBestOf"}, {"y": 29, "x": "QuotesPorn"}, {"y": 31, "x": "shittyaskscience"}, {"y": 32, "x": "StarWars"}, {"y": 33, "x": "tattoos"}, {"y": 34, "x": "DoesAnybodyElse"}, {"y": 35, "x": "philosophy"}, {"y": 36, "x": "gentlemanboners"}, {"y": 43, "x": "Unexpected"}, {"y": 43, "x": "wheredidthesodago"}, {"y": 43, "x": "Cooking"}, {"y": 45, "x": "Economics"}, {"y": 46, "x": "FoodPorn"}, {"y": 48, "x": "Jokes"}, {"y": 51, "x": "HistoryPorn"}, {"y": 51, "x": "geek"}, {"y": 51, "x": "thewalkingdead"}, {"y": 51, "x": "GameDeals"}, {"y": 52, "x": "seduction"}, {"y": 54, "x": "lifehacks"}, {"y": 54, "x": "facepalm"}, {"y": 60, "x": "food"}, {"y": 60, "x": "EarthPorn"}, {"y": 60, "x": "scifi"}, {"y": 60, "x": "announcements"}, {"y": 61, "x": "dataisbeautiful"}, {"y": 64, "x": "offbeat"}, {"y": 67, "x": "comics"}, {"y": 68, "x": "YouShouldKnow"}, {"y": 68, "x": "Futurology"}, {"y": 69, "x": "fffffffuuuuuuuuuuuu"}, {"y": 70, "x": "doctorwho"}, {"y": 74, "x": "GetMotivated"}, {"y": 75, "x": "space"}, {"y": 76, "x": "skyrim"}, {"y": 77, "x": "Showerthoughts"}, {"y": 81, "x": "firstworldanarchists"}, {"y": 83, "x": "loseit"}, {"y": 86, "x": "cats"}, {"y": 89, "x": "tifu"}, {"y": 93, "x": "television"}, {"y": 96, "x": "Frugal"}, {"y": 105, "x": "apple"}, {"y": 113, "x": "nottheonion"}, {"y": 116, "x": "DIY"}, {"y": 117, "x": "sports"}, {"y": 122, "x": "4chan"}, {"y": 133, "x": "conspiracy"}, {"y": 137, "x": "woahdude"}, {"y": 145, "x": "breakingbad"}, {"y": 151, "x": "personalfinance"}, {"y": 153, "x": "gameofthrones"}, {"y": 161, "x": "TrueReddit"}, {"y": 165, "x": "photography"}, {"y": 174, "x": "JusticePorn"}, {"y": 176, "x": "anime"}, {"y": 185, "x": "LifeProTips"}, {"y": 198, "x": "books"}, {"y": 202, "x": "hiphopheads"}, {"y": 215, "x": "cringe"}, {"y": 217, "x": "programming"}, {"y": 223, "x": "reactiongifs"}, {"y": 235, "x": "guns"}, {"y": 244, "x": "pokemon"}, {"y": 264, "x": "malefashionadvice"}, {"y": 279, "x": "bestof"}, {"y": 280, "x": "Fitness"}, {"y": 281, "x": "mildlyinteresting"}, {"y": 284, "x": "Minecraft"}, {"y": 298, "x": "AskHistorians"}, {"y": 301, "x": "Games"}, {"y": 304, "x": "photoshopbattles"}, {"y": 335, "x": "TwoXChromosomes"}, {"y": 337, "x": "askscience"}, {"y": 346, "x": "sex"}, {"y": 353, "x": "Android"}, {"y": 374, "x": "soccer"}, {"y": 422, "x": "relationships"}, {"y": 425, "x": "nba"}, {"y": 427, "x": "science"}, {"y": 436, "x": "buildapc"}, {"y": 500, "x": "cringepics"}, {"y": 565, "x": "trees"}, {"y": 691, "x": "blog"}, {"y": 711, "x": "atheism"}, {"y": 747, "x": "Music"}, {"y": 806, "x": "movies"}, {"y": 822, "x": "circlejerk"}, {"y": 864, "x": "explainlikeimfive"}, {"y": 872, "x": "AdviceAnimals"}, {"y": 889, "x": "pics"}, {"y": 923, "x": "funny"}, {"y": 924, "x": "aww"}, {"y": 933, "x": "news"}, {"y": 934, "x": "leagueoflegends"}, {"y": 942, "x": "IAmA"}, {"y": 943, "x": "videos"}, {"y": 944, "x": "gaming"}, {"y": 950, "x": "WTF"}, {"y": 950, "x": "technology"}, {"y": 956, "x": "worldnews"}, {"y": 965, "x": "politics"}, {"y": 966, "x": "gifs"}, {"y": 967, "x": "AskReddit"}, {"y": 968, "x": "nfl"}, {"y": 975, "x": "todayilearned"}], "key": "gold", "yAxis": "1"}];
</script>


<p>It’s worth noting that we ran into the same weird thousand-comment limit: still, we get a very interesting distribution curve amongst the various subreddits.  However, we don’t get a good idea of relative generosity: a 600,000-subscriber subreddit with 700 recorded gildings <sup class="footnote-ref" id="fnref:2"><a href="#fn:2" rel="footnote">2</a></sup> is hardly as impressive as a subreddit with only 300 gildings but 50,000 subscribers.</p>


<p>Let’s solve this by grabbing the subscriber counts:</p>


<pre><code>subscribers = {}
for subreddit in urls:
    name = subreddit.split("/")[-2] # whee, magic
    subscribers[name] = panther.find(subreddit, ".subscribers .number")[0].text
normalized = {x: subreddits[x] / float(subscribers[x].replace(",","")) for x in subscribers}
</code></pre>


<p>Because small numbers like <code>0.000804813960057776</code> are pretty lame to read, we’ll normalize the top value to one:</p>


<pre><code>normalized = {x: normalized[x] / max(normalized.values) for x in normalized}
</code></pre>


<p>And then plotting it the same way as above, we get the following chart:</p>


<div id="RG2"><svg style="width:800px;height:300px;margin-left:-50px"></svg></div>


<script type="text/javascript">
    nv.addGraph(function() {
        var chart = nv.models.discreteBarChart();
        chart.showXAxis(false)
        chart.yAxis
        chart.tooltipContent(function(key, y, e, graph) {
            var x = String(graph.point.x);
            var y = String(graph.point.y);
var y = String(graph.point.y);
            tooltip_str = '<center><b>normalized '+key+'</b></center>' + y + ' at ' + x;
            return tooltip_str;
        });
        d3.select('#RG2 svg')
            .datum(data_RG2)
            .transition().duration(500)
            .attr('width', 800)
.attr('height', 300)
            .call(chart);

    return chart;
});data_RG2=[{"values": [{"y": 0.002518899007455927, "x": "announcements"}, {"y": 0.006688973833311991, "x": "EarthPorn"}, {"y": 0.007734418810971543, "x": "freebies"}, {"y": 0.008464214815261282, "x": "humor"}, {"y": 0.01229487041216111, "x": "television"}, {"y": 0.014442821140644659, "x": "bestof"}, {"y": 0.015311643900332421, "x": "spaceporn"}, {"y": 0.017060478151697374, "x": "Art"}, {"y": 0.017296854000510998, "x": "RoomPorn"}, {"y": 0.017587182940279535, "x": "AbandonedPorn"}, {"y": 0.017901175417158657, "x": "history"}, {"y": 0.019164384997129285, "x": "gadgets"}, {"y": 0.019372935625800773, "x": "science"}, {"y": 0.020001457447221024, "x": "shutupandtakemymoney"}, {"y": 0.020473279426961585, "x": "nosleep"}, {"y": 0.021237719364645406, "x": "listentothis"}, {"y": 0.021241013285796476, "x": "business"}, {"y": 0.022346886646469534, "x": "wallpapers"}, {"y": 0.023220174662052766, "x": "books"}, {"y": 0.02522422743786689, "x": "LearnUselessTalents"}, {"y": 0.025323609537298637, "x": "Documentaries"}, {"y": 0.027195641656552593, "x": "creepy"}, {"y": 0.02828010901740913, "x": "DepthHub"}, {"y": 0.0288273353326361, "x": "InternetIsBeautiful"}, {"y": 0.028938421071087777, "x": "fffffffuuuuuuuuuuuu"}, {"y": 0.029776941160490657, "x": "sports"}, {"y": 0.030088745994818693, "x": "tattoos"}, {"y": 0.030745711672484004, "x": "blog"}, {"y": 0.03276722538323763, "x": "askscience"}, {"y": 0.03479024097648807, "x": "Jokes"}, {"y": 0.03611274816098157, "x": "gentlemanboners"}, {"y": 0.036781519892421496, "x": "QuotesPorn"}, {"y": 0.037465707642287155, "x": "FiftyFifty"}, {"y": 0.03784069470065969, "x": "pics"}, {"y": 0.03877031181347452, "x": "funny"}, {"y": 0.03910382977033557, "x": "food"}, {"y": 0.03934112460876292, "x": "DoesAnybodyElse"}, {"y": 0.039345411069120796, "x": "wheredidthesodago"}, {"y": 0.040109483136376016, "x": "NetflixBestOf"}, {"y": 0.04022604288745706, "x": "HistoryPorn"}, {"y": 0.040950703874970386, "x": "FoodPorn"}, {"y": 0.04116974159278215, "x": "Music"}, {"y": 0.04175643140430976, "x": "AskReddit"}, {"y": 0.04284160344201661, "x": "movies"}, {"y": 0.0430007960130466, "x": "worldnews"}, {"y": 0.04308038467116615, "x": "todayilearned"}, {"y": 0.04309601817751792, "x": "IAmA"}, {"y": 0.04540269790681465, "x": "philosophy"}, {"y": 0.04558683220908597, "x": "videos"}, {"y": 0.045698939055063045, "x": "Cooking"}, {"y": 0.04576020090934438, "x": "YouShouldKnow"}, {"y": 0.04592234709525338, "x": "gaming"}, {"y": 0.04630694593064912, "x": "shittyaskscience"}, {"y": 0.04664573603109821, "x": "technology"}, {"y": 0.04675959676544922, "x": "StarWars"}, {"y": 0.04789376487996103, "x": "Unexpected"}, {"y": 0.04856430677782241, "x": "facepalm"}, {"y": 0.048770415899719595, "x": "lifehacks"}, {"y": 0.04916422342668395, "x": "comics"}, {"y": 0.04927708313706355, "x": "geek"}, {"y": 0.050180885089428494, "x": "AdviceAnimals"}, {"y": 0.05198556561219079, "x": "aww"}, {"y": 0.05394344602925081, "x": "WTF"}, {"y": 0.054451218817560106, "x": "offbeat"}, {"y": 0.05671460386371755, "x": "space"}, {"y": 0.056940156987273505, "x": "GetMotivated"}, {"y": 0.05784599925085279, "x": "LifeProTips"}, {"y": 0.06180803436195323, "x": "GameDeals"}, {"y": 0.061961594830579406, "x": "woahdude"}, {"y": 0.06282851769882443, "x": "Economics"}, {"y": 0.06360926955676377, "x": "DIY"}, {"y": 0.06390240950945654, "x": "Frugal"}, {"y": 0.06777075881932673, "x": "4chan"}, {"y": 0.07364776205924947, "x": "dataisbeautiful"}, {"y": 0.07546764173724003, "x": "Showerthoughts"}, {"y": 0.07558715648797855, "x": "seduction"}, {"y": 0.07670927550047878, "x": "thewalkingdead"}, {"y": 0.0774270449186162, "x": "politics"}, {"y": 0.07875161508573107, "x": "scifi"}, {"y": 0.08132266835920714, "x": "skyrim"}, {"y": 0.08250817889439939, "x": "news"}, {"y": 0.08263407516159066, "x": "Futurology"}, {"y": 0.08322279411584231, "x": "doctorwho"}, {"y": 0.08436025559145277, "x": "atheism"}, {"y": 0.08937259544801053, "x": "gifs"}, {"y": 0.09062347152322484, "x": "explainlikeimfive"}, {"y": 0.09763215860792616, "x": "firstworldanarchists"}, {"y": 0.09785349129729162, "x": "loseit"}, {"y": 0.10300803270268322, "x": "programming"}, {"y": 0.10673171114484382, "x": "gameofthrones"}, {"y": 0.10964270804004278, "x": "nottheonion"}, {"y": 0.11038316586384049, "x": "tifu"}, {"y": 0.11264731518771784, "x": "cats"}, {"y": 0.11414609507015724, "x": "mildlyinteresting"}, {"y": 0.13588900345983915, "x": "apple"}, {"y": 0.13673926664623653, "x": "Fitness"}, {"y": 0.13874213455404566, "x": "TrueReddit"}, {"y": 0.1429990798658495, "x": "conspiracy"}, {"y": 0.14868030404432517, "x": "reactiongifs"}, {"y": 0.15987544430463288, "x": "JusticePorn"}, {"y": 0.1618597509151802, "x": "Games"}, {"y": 0.1652207455966972, "x": "breakingbad"}, {"y": 0.1758233668253467, "x": "malefashionadvice"}, {"y": 0.17645816476372841, "x": "pokemon"}, {"y": 0.1818151711303947, "x": "Minecraft"}, {"y": 0.19555302581772224, "x": "sex"}, {"y": 0.19918558055984661, "x": "personalfinance"}, {"y": 0.21597895555966384, "x": "photoshopbattles"}, {"y": 0.21910666761483982, "x": "cringe"}, {"y": 0.22308140214097114, "x": "Android"}, {"y": 0.2296367070822581, "x": "photography"}, {"y": 0.23868704964531304, "x": "trees"}, {"y": 0.26099895893721137, "x": "AskHistorians"}, {"y": 0.26552582691830484, "x": "anime"}, {"y": 0.2731946356611361, "x": "hiphopheads"}, {"y": 0.3310026945482944, "x": "cringepics"}, {"y": 0.3434272864622793, "x": "guns"}, {"y": 0.4528287407745878, "x": "soccer"}, {"y": 0.4618764435065237, "x": "TwoXChromosomes"}, {"y": 0.48174414275242344, "x": "leagueoflegends"}, {"y": 0.5428126761552184, "x": "buildapc"}, {"y": 0.5911161940981836, "x": "nba"}, {"y": 0.604391769381842, "x": "relationships"}, {"y": 0.908950280215082, "x": "nfl"}, {"y": 1.0, "x": "circlejerk"}], "key": "gold", "yAxis": "1"}];
</script>


<p>… And <a href="http://www.reddit.com/r/circlejerk">/r/circlejerk</a> is the top subreddit.  Of course.</p>


<p>Honorary shoutouts also go to /r/nba, /r/relationships, and /r/nfls <sup class="footnote-ref" id="fnref:3"><a href="#fn:3" rel="footnote">3</a></sup> and jeers go to /r/books, /r/history, and /r/Art for being some of the stingiest donors. <sup class="footnote-ref" id="fnref:4"><a href="#fn:4" rel="footnote">4</a></sup></p>


<p>Hope you enjoyed this quick little post!  Even if it was just a reason for me to take my little library for a spin and dig up a little information about some of the communities, it was a lot of fun.  I’m honestly surprised this isn’t an avenue Reddit hasn’t gone down before – considering the success of some of the friendly competitions they’ve thrown in the past, having a ‘war of donations’ of sorts would probably light a fire under a lot of these people.</p>


<div class="footnotes">
<hr/>
<ol>
<li id="fn:1">Pretty sure this is a transient URL, so you’re gonna have to take my word for it.
 <a class="footnote-return" href="#fnref:1"><sup>[return]</sup></a></li>
<li id="fn:2">Is that a word?  Let’s pretend that’s a word.
 <a class="footnote-return" href="#fnref:2"><sup>[return]</sup></a></li>
<li id="fn:3">It stands to reason that people are most generous to strangers when they’re thinking about sports and love.  But mainly sports.
 <a class="footnote-return" href="#fnref:3"><sup>[return]</sup></a></li>
<li id="fn:4">I’d make a joke about them not having the cash to spare, being liberal arts subreddits, but /r/business only barely edged them out.
 <a class="footnote-return" href="#fnref:4"><sup>[return]</sup></a></li>
</ol>
</div>
	