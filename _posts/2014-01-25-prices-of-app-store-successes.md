---
title: "Prices of App Store successes"
Date: 2014-01-25 00:00:00
Tags: ["data"]
layout: post
---

<p>There’s a growing mythos – fueled by the massive IAP-backed successes of <em>Clash of Clans</em> and <em>Candy Crush</em> – that App Store economics (and the consumers who buy into it) dictate that the road to success is paved with upselling; put more simply, that the best way to make money on the App Store is to release your app for free and then make your moolah via in-app purchases.</p>


<p>I’m working on an iPhone app myself, and I was interested in separating the anecdotes from the raw data – I thought it would be helpful to see what proportion of top-grossing apps were IAP-only.</p>


<p>This is a task made remarkably easier by the fact that iTunes makes their top grossing/free/paid leaderboards accessible via RSS; they break things down into genres which have associated IDs.  We could just manually generate a dictionary, but I’d rather be lazy and use a list comprehension:</p>


<pre><code># Retrieved from http://www.apple.com/itunes/affiliates/resources/documentation/genre-mapping.html
GENRE_CODES = '''
6000 Business
6001 Weather
6002 Utilities
6003 Travel
6004 Sports
6005 Social Networking
6006 Reference
6007 Productivity
6008 Photo &amp; Video
6009 News
6010 Navigation
6011 Music
6012 Lifestyle
6013 Health &amp; Fitness
6014 Games'''

genre_map = {genre.split()[0] : genre.split()[1] for genre in GENRE_CODES.split('\n')[1:]}
</code></pre>


<p>Here’s the thing about RSS: it’s in XML.</p>


<p>Here’s the thing about XML: it can be absolutely awful to parse.</p>


<p>Thankfully, there exists a wonderful module called <a href="http://pythonhosted.org/cssselect/"><code>cssselect</code></a> which essentially acts as a CSS-to-XPath converter.  As someone who is well-worn by the scars of front-end development and easily scared by consecutive backslashes, this is a godsend.  It means all we have to do is specify the node within the content.  So first, specify the constants and create an empty list to store genres and data:</p>


<pre><code>API_URL = "https://itunes.apple.com/us/rss/topgrossingapplications/limit={}/genre={}/xml"
LIMIT = 50
price_dicts = []
price_index = []
</code></pre>


<p>And then we get to do the fun part!  We’re going to iterate over each genre, grab the content using <a href="docs.python-requests.org">requests</a>, select the node, and then throw it in a dictionary.</p>


<pre><code>import cssselect
from lxml import etree
from lxml.cssselect import CSSSelector

# iterate over the possible genres
for key in genre_map:

    endpoint = API_URL.format(LIMIT, key)
    response = requests.get(endpoint)
    # convert to Unicode because I hate everything
    document = etree.fromstring(response.text.encode('utf-8'))
    # escape the colon, as all things do
    prices = document.xpath(cssselect.HTMLTranslator().css_to_xpath('im\:price'))
    price_dict = {}
    for price in prices:
        # so it automatically becomes a numeric column
        parsed_price =  0.0 if price.text == "Free" else float(price.text[1:])
        price_dict[parsed_price] = price_dict.get(parsed_price, 0) + 1
    price_dicts.append(price_dict)
    price_index.append(genre_map.get(key))
</code></pre>


<p>So we have a dictionary of genre-to-initial price occurences.  This is great!  But printing said dictionary looks something like this:</p>


<pre><code>&gt; [{0.0: 13, 9.99: 2, 4.99: 4, 54.99: 1, 0.99: 4, 24.99: 1, 19.99: 4, 59.99: 1, 69.99: 1, 1.99: 7, 2.99: 5, 29.99: 2, 3.99: 3, 14.99: 2}, {0.0: 24, 12.99: 1, 4.99: 2, 3.99: 1, 0.99: 1, 7.99: 1, 19.99: 1, 79.99: 1, 1.99: 3, 2.99: 6, 17.99: 1, 6.99: 3, 9.99: 5}, {0.0: 28, 8.99: 1, 7.99: 1, 0.99: 1, 4.99: 8, 99.99: 1, 1.99: 5, 29.99: 1, 5.99: 2, 9.99: 2}, {0.0: 44, 2.99: 2, 0.99: 2, 1.99: 1, 4.99: 1}, {0.0: 22, 4.99: 3, 0.99: 2, 19.99: 2, 2.99: 7, 3.99: 2, 29.99: 1, 5.99: 2, 1.99: 9}, {0.0: 10, 0.99: 5, 4.99: 5, 3.99: 11, 2.99: 6, 19.99: 1, 7.99: 4, 9.99: 6, 1.99: 2}, {0.0: 17, 4.99: 4, 6.99: 3, 19.99: 2, 29.99: 2, 9.99: 5, 2.99: 6, 16.99: 1, 5.99: 4, 14.99: 2, 1.99: 4}, {0.0: 14, 0.99: 5, 4.99: 1, 1.99: 10, 2.99: 12, 3.99: 6, 9.99: 2}, {0.0: 17, 3.99: 6, 0.99: 2, 1.99: 11, 2.99: 9, 4.99: 4, 9.99: 1}, {0.0: 22, 2.99: 4, 0.99: 9, 4.99: 4, 1.99: 11}, {0.0: 34, 0.99: 3, 4.99: 2, 1.99: 2, 3.99: 3, 2.99: 6}, {0.0: 28, 99.99: 1, 3.99: 3, 0.99: 1, 24.99: 1, 19.99: 1, 1.99: 4, 2.99: 6, 29.99: 1, 5.99: 1, 4.99: 2, 9.99: 1}, {0.0: 11, 44.99: 1, 0.99: 6, 6.99: 1, 2.99: 3, 35.99: 1, 59.99: 2, 7.99: 1, 64.99: 1, 99.99: 1, 19.99: 2, 49.99: 3, 74.99: 1, 9.99: 5, 79.99: 1, 3.99: 4, 5.99: 1, 4.99: 1, 14.99: 2, 1.99: 2}, {0.0: 24, 7.99: 1, 6.99: 3, 19.99: 3, 4.99: 2, 1.99: 4, 2.99: 6, 3.99: 5, 14.99: 2}, {0.0: 49, 6.99: 1}]
</code></pre>


<p>Which is pretty unreadable, to put it lightly.</p>


<p>Instead, we’d ideally have a stacked bar graph with a gradient of hues for each price, so we can get a good view of the genre-by-genre breakdown.  We’ll accomplish this with minimal use of two packages: the excellent <a href="pandas.pydata.org">pandas</a> – which can accomplish just about everything related to data analysis, but we’re really only using it for data storage – and the equally excellent <a href="https://github.com/wrobstory/vincent">vincent</a>, which can bind data to pretty graphs.  (And isn’t that all we ever want from life?)</p>


<p>So we wrap up that dictionary and convert it into a chart in literally the easiest way possible:</p>


<pre><code>import pandas as pd
import vincent
dataframe = pd.DataFrame(price_dicts, index=price_index)
stack = vincent.StackedBar(dataframe)
stack.legend(title='App Price')
stack.to_json("appstore.json", html_out=True, html_path='appstore.html')
</code></pre>


<p>Seriously, that’s all you need to do.  <code>appstore.html</code> – plus some recoloring about which I’ll spare you the boring details – contains the following:</p>


<script charset="utf-8" src="http://d3js.org/d3.v3.min.js"></script>


<script src="http://d3js.org/topojson.v1.min.js"></script>


<script charset="utf-8" src="http://d3js.org/d3.geo.projection.v0.min.js"></script>


<script src="http://trifacta.github.com/vega/vega.js"></script>


<div id="vis"></div>


<script type="text/javascript">
// parse a spec and create a visualization view
function parse(spec) {
vg.parse.spec(spec, function(chart) { chart({el:"#vis", hover: true}).update(); });
}
parse("/static/appstore.json");
</script>


<p>Pretty cool, right?  The big takeaway for me is that the death of paid apps has been greatly exaggerated: while <strong>Games</strong> and <strong>Social</strong> apps are overwhelmingly dominated by the first-hit-free mentality (and make no mistake, these two genres are where the most massive of profits lie), less than half of the top grossing halves in all other genres are initially free.</p>


<p>Obviously if you’re looking for explosive growth or targetting a massive audience, pricing at free is the way to go – but if your app is targeting a specific niche, pricing your app reasonably is the way to go.</p>


<p>(Also, there’s an app that <a href="https://itunes.apple.com/us/app/vip-black/id321971059?mt=8">goes for $999.9</a>.  How ridiculous is that?)</p>
	