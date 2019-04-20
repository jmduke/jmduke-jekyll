---
title: "Better beer snobbery through data"
Date: 2014-05-17 00:00:00
Tags: ["data"]
layout: post
---

<p>Ever since moving to Seattle, I’ve felt that I needed to step my beer game up in a very serious way: gone are the magical, innocent days of my youth where I could feel dignified drinking a PBR and waxing poetic about the differences between Natural and Keystone Light.  I’ve been very quickly introduced to the rabbit-hole of microbreweries, which has resulted in some very happy, very hoppy experiences <sup class="footnote-ref" id="fnref:1"><a href="#fn:1" rel="footnote">1</a></sup> – but the dizzying array of selections in your average Seattle beer shop left me feeling as though there should be an easy way to streamline the entire process.</p>


<p><img alt="" src="http://macadoodles.com/wp-content/uploads/2011/09/Beer-Room.jpg"/></p>


<p>For fun, I decided to hop <sup class="footnote-ref" id="fnref:2"><a href="#fn:2" rel="footnote">2</a></sup> over to my new favorite site, <a href="http://www.beeradvocate.com">BeerAdvocate</a>, and see if they had anything that would make my life easier.</p>


<p>Thankfully, they’ve got a list of the <a href="http://www.beeradvocate.com/lists/top/">top 250 beers</a> as rated by users, and I thought it would be interesting to tinker with the data and see if I could get any decent heuristics to make my ale-sipping lifestyle any easier.</p>


<p>Grabbing the data proved to be an absolute slog, due to – how do I put this kindly? – <em>less than semantic</em> markup in the tables themselves.  Thankfully, <a href="https://www.kimonolabs.com/">Kimono</a> – sort of a WYSIWYG web scraper – condensed four hours of flailing around in Python into five minutes of clicking around.  One csv later, and I was off to the races!</p>


<p>The first thing I wanted to do was identify top-notch breweries to keep my eye out for.  Using pandas, this was a cinch:</p>


<pre><code>filename = 'beer.csv'
data = pandas.read_csv(filename)

breweries =  data.groupby('brewery/_text').count()['brewery/_text'].order()
</code></pre>


<p>The results are graphed below, with <strong>Hill Farmstead Brewery</strong>, <strong>The Bruery</strong>, and <strong>Brasserie Cantillon</strong> leading the pack:</p>


<div id="Breweries"><svg style="width:800px;height:300px;"></svg></div>


<script type="text/javascript">
    nv.addGraph(function() {
        var chart = nv.models.discreteBarChart().color(['#F15B29', '#F26B3E', '#F37B53', '#F58C69', '#F69C7E', '#F8AD94']);
        chart.showXAxis(false)
        chart.yAxis
        chart.tooltipContent(function(key, y, e, graph) {
            var x = String(graph.point.x);
            var y = String(graph.point.y);
var y = String(graph.point.y);
            tooltip_str = '<center><b>'+key+'</b></center>' + y + ' at ' + x;
            return tooltip_str;
        });
        d3.select('#Breweries svg')
            .datum(data_Breweries)
            .transition().duration(500)
            .attr('width', 800)
.attr('height', 300)
            .call(chart);

    return chart;
});data_Breweries=[{"values": [{"y": 1, "x": "Anchorage Brewing Company"}, {"y": 1, "x": "Bi\u00e8res de Chimay S.A."}, {"y": 1, "x": "Bootlegger's Brewery"}, {"y": 1, "x": "Boston Beer Company (Samuel Adams)"}, {"y": 1, "x": "Boulevard Brewing Co."}, {"y": 1, "x": "Brasserie Dieu Du Ciel"}, {"y": 1, "x": "Brasserie Fant\u00f4me"}, {"y": 1, "x": "Brouwerij Bockor N.V."}, {"y": 1, "x": "Brouwerij Bosteels"}, {"y": 1, "x": "Brouwerij Duvel Moortgat NV"}, {"y": 1, "x": "Brouwerij Het Anker"}, {"y": 1, "x": "Brouwerij St. Bernardus NV"}, {"y": 1, "x": "Brouwerij Westmalle"}, {"y": 1, "x": "Captain Lawrence Brewing Co."}, {"y": 1, "x": "Columbus Brewing Company"}, {"y": 1, "x": "DC Brau Brewing Co."}, {"y": 1, "x": "Deschutes Brewery"}, {"y": 1, "x": "Dogfish Head Brewery"}, {"y": 1, "x": "Dry Dock Brewing Co."}, {"y": 1, "x": "Epic Brewing Company"}, {"y": 1, "x": "FiftyFifty Brewing Co."}, {"y": 1, "x": "Foothills Brewing Company"}, {"y": 1, "x": "Fremont Brewing Company"}, {"y": 1, "x": "Funky Buddha Brewery"}, {"y": 1, "x": "Green Flash Brewing Co."}, {"y": 1, "x": "Gueuzerie Tilquin"}, {"y": 1, "x": "Hoppin' Frog Brewery"}, {"y": 1, "x": "Ithaca Beer Company"}, {"y": 1, "x": "Jester King Brewery"}, {"y": 1, "x": "Kern River Brewing Company"}, {"y": 1, "x": "La Cumbre Brewing Co."}, {"y": 1, "x": "Lagunitas Brewing Company"}, {"y": 1, "x": "Live Oak Brewing Company"}, {"y": 1, "x": "Logsdon Farmhouse Ales"}, {"y": 1, "x": "Mikkeller ApS"}, {"y": 1, "x": "Minneapolis Town Hall Brewery"}, {"y": 1, "x": "N\u00e4rke Kulturbryggeri AB"}, {"y": 1, "x": "Olde Hickory Brewery"}, {"y": 1, "x": "Oskar Blues Grill & Brew"}, {"y": 1, "x": "Otter Creek Brewing / Wolaver's"}, {"y": 1, "x": "Peg's Cantina & Brewpub / Cycle Brewing"}, {"y": 1, "x": "Pelican Pub & Brewery"}, {"y": 1, "x": "Port Brewing"}, {"y": 1, "x": "Privatbrauerei Franz Inselkammer KG / Brauerei Aying"}, {"y": 1, "x": "Societe Brewing Co."}, {"y": 1, "x": "Southern Tier Brewing Company"}, {"y": 1, "x": "Terrapin Beer Company"}, {"y": 1, "x": "The Brew Kettle Taproom & Smokehouse / Production Works"}, {"y": 1, "x": "Thirsty Dog Brewing Company"}, {"y": 1, "x": "Tree House Brewing Company"}, {"y": 1, "x": "Tr\u00f6egs Brewing Company"}, {"y": 1, "x": "Unibroue"}, {"y": 1, "x": "Victory Brewing Company"}, {"y": 1, "x": "Voodoo Brewing Company"}, {"y": 1, "x": "Weisses Br\u00e4uhaus G. Schneider & Sohn GmbH"}, {"y": 1, "x": "Westbrook Brewing Co."}, {"y": 2, "x": "Allagash Brewing Company"}, {"y": 2, "x": "Avery Brewing Company"}, {"y": 2, "x": "Ballast Point Brewing Company"}, {"y": 2, "x": "Bayerische Staatsbrauerei Weihenstephan"}, {"y": 2, "x": "Brasserie de Rochefort"}, {"y": 2, "x": "Brouwerij Rodenbach N.V."}, {"y": 2, "x": "Brouwerij Westvleteren (Sint-Sixtusabdij van Westvleteren)"}, {"y": 2, "x": "Central Waters Brewing Co."}, {"y": 2, "x": "Dark Horse Brewing Company"}, {"y": 2, "x": "Evil Twin Brewing"}, {"y": 2, "x": "Fat Heads Brewery & Saloon"}, {"y": 2, "x": "Great Divide Brewing Company"}, {"y": 2, "x": "Lawson's Finest Liquids"}, {"y": 2, "x": "Maine Beer Company"}, {"y": 2, "x": "Midnight Sun Brewing Co."}, {"y": 2, "x": "New Belgium Brewing"}, {"y": 2, "x": "New England Brewing Co."}, {"y": 2, "x": "North Coast Brewing Co."}, {"y": 2, "x": "Odell Brewing Company"}, {"y": 2, "x": "Perennial Artisan Ales"}, {"y": 2, "x": "Pipeworks Brewing Company"}, {"y": 2, "x": "Prairie Artisan Ales"}, {"y": 2, "x": "The Alchemist"}, {"y": 3, "x": "Bell's Brewery Inc."}, {"y": 3, "x": "Boneyard Beer Company"}, {"y": 3, "x": "De Struise Brouwers"}, {"y": 3, "x": "Great Lakes Brewing Co."}, {"y": 3, "x": "Hair of the Dog Brewing Company / Brewery and Tasting Room"}, {"y": 3, "x": "Jack's Abby Brewing"}, {"y": 3, "x": "The Lost Abbey"}, {"y": 4, "x": "Brouwerij Drie Fonteinen"}, {"y": 4, "x": "Cascade Brewing / Raccoon Lodge & Brewpub"}, {"y": 4, "x": "Kuhnhenn Brewing Company"}, {"y": 4, "x": "Surly Brewing Company"}, {"y": 5, "x": "Firestone Walker Brewing Co."}, {"y": 5, "x": "Goose Island Beer Co."}, {"y": 5, "x": "New Glarus Brewing Company"}, {"y": 6, "x": "AleSmith Brewing Company"}, {"y": 6, "x": "Founders Brewing Company"}, {"y": 6, "x": "Toppling Goliath Brewing Company"}, {"y": 7, "x": "Cigar City Brewing"}, {"y": 7, "x": "Stone Brewing Co."}, {"y": 7, "x": "Three Floyds Brewing Co. & Brewpub"}, {"y": 8, "x": "Alpine Beer Company"}, {"y": 9, "x": "Russian River Brewing Company"}, {"y": 11, "x": "Brasserie Cantillon"}, {"y": 13, "x": "The Bruery"}, {"y": 16, "x": "Hill Farmstead Brewery"}], "key": "brewerycount", "yAxis": "1"}];
</script>


<p>I thought it’d also be interesting to see where all of these amazing breweries were located.  Since BeerAdvocate has profile pages for each brewery, it was relatively easy to grab the data:</p>


<pre><code>import panther
import us

breweries = list(set(data['brewery']))
selector = "a[href*='/place/directory/9/US']"
locations = panther.pounce(breweries, selector)
locations = map(lambda x: x[0].text if x else None, locations)
locations = filter(lambda x: x is not None, locations)
locations = Counter(locations)

all_locations = {state: 0 for state in map(str, us.states.STATES)}
all_locations.update(locations)
</code></pre>


<p>The winners <sup class="footnote-ref" id="fnref:5"><a href="#fn:5" rel="footnote">3</a></sup>, somewhat unsurprisingly, are Oregon, Colorado, Michigan, and California.  Only one Washington-based brewery made it, which is something of a travesty.</p>


<p>As a matter of personal curiosity, I wanted to see what styles were most popular as well.</p>


<pre><code>styles = data.groupby('style/_text').count()['style/_text'].order()
</code></pre>


<p>Unsurprisingly, stouts and IPAs lead the pack, though two styles had surprisingly high (at least for me) representation: Russian Imperial Stouts and what BeerAdvocate classifies as <em>Lambic - Fruit</em>, which is described as:</p>


<blockquote>
<p>In the case of Fruit Lambics, whole fruits are traditionally added after spontaneous fermentation has started. Kriek (cherries), Frambroise (raspberries), Pache (peach) and Cassis (black currant) are common fruits, all producing subtle to intense fruit characters respectively. Once the fruit is added, the beer is subjected to additional maturation before bottling. Malt and hop characters are generally low to allow the fruit to consume the palate. Alcohol content tends to be low.</p>
</blockquote>


<p>(Also, a quick aside about why IPAs are called IPAs – back in the day when England had colonies in India, their typical beer wouldn’t last the long ocean voyages to the Indian colonies: as a result, they added more hops to act as something of a preservative, which of course resulted in a much stronger – and tastier – beverage. <sup class="footnote-ref" id="fnref:3"><a href="#fn:3" rel="footnote">4</a></sup>)</p>


<div id="Styles"><svg style="width:800px;height:300px;"></svg></div>


<script type="text/javascript">
    nv.addGraph(function() {
        var chart = nv.models.discreteBarChart().color(['#F15B29', '#F26B3E', '#F37B53', '#F58C69', '#F69C7E', '#F8AD94']);
                chart.showXAxis(false)

        chart.yAxis
        chart.tooltipContent(function(key, y, e, graph) {
            var x = String(graph.point.x);
            var y = String(graph.point.y);
var y = String(graph.point.y);
            tooltip_str = '<center><b>'+key+'</b></center>' + y + ' at ' + x;
            return tooltip_str;
        });
        d3.select('#Styles svg')
            .datum(data_Styles)
            .transition().duration(500)
            .attr('width', 800)
.attr('height', 300)
            .call(chart);

    return chart;
});data_Styles=[{"values": [{"y": 1, "x": "American Amber / Red Ale"}, {"y": 1, "x": "American Pale Lager"}, {"y": 1, "x": "Baltic Porter"}, {"y": 1, "x": "Belgian IPA"}, {"y": 1, "x": "Belgian Strong Pale Ale"}, {"y": 1, "x": "Doppelbock"}, {"y": 1, "x": "Dubbel"}, {"y": 1, "x": "Eisbock"}, {"y": 1, "x": "Flanders Oud Bruin"}, {"y": 1, "x": "Lambic - Unblended"}, {"y": 1, "x": "Milk / Sweet Stout"}, {"y": 1, "x": "Pumpkin Ale"}, {"y": 2, "x": "American Barleywine"}, {"y": 2, "x": "American Double / Imperial Pilsner"}, {"y": 2, "x": "Hefeweizen"}, {"y": 2, "x": "Scotch Ale / Wee Heavy"}, {"y": 2, "x": "Weizenbock"}, {"y": 3, "x": "Belgian Strong Dark Ale"}, {"y": 3, "x": "Fruit / Vegetable Beer"}, {"y": 3, "x": "Saison / Farmhouse Ale"}, {"y": 4, "x": "Flanders Red Ale"}, {"y": 4, "x": "Tripel"}, {"y": 5, "x": "Old Ale"}, {"y": 5, "x": "Quadrupel (Quad)"}, {"y": 6, "x": "English Barleywine"}, {"y": 6, "x": "Gueuze"}, {"y": 7, "x": "American Porter"}, {"y": 7, "x": "American Strong Ale"}, {"y": 8, "x": "American Pale Ale (APA)"}, {"y": 10, "x": "Lambic - Fruit"}, {"y": 20, "x": "Russian Imperial Stout"}, {"y": 22, "x": "American Wild Ale"}, {"y": 24, "x": "American IPA"}, {"y": 42, "x": "American Double / Imperial IPA"}, {"y": 49, "x": "American Double / Imperial Stout"}], "key": "style", "yAxis": "1"}];
</script>


<p>Lastly, I thought it’d be interesting to look at the actual alcohol content of these prize beers.  One of the biggest surprises to me – coming from the collegiate world where a Natty Ice would pack a <em>whopping</em> 5.9% ABV – is how strong a good beer could be (which required me to untrain myself from binging through a six-pack on Friday nights, as I would quickly realize on Saturday mornings).  Turns out most great beers hover around the 7-9% mark, with some absolutely insane outliers like <a href="http://www.beeradvocate.com/beer/profile/35/25759/">Sam Adams Utopias</a> at 29% ABV –</p>


<pre><code>import numpy as np
vals, keys = np.histogram(list(data['abv']), bins=range(30))
</code></pre>


<div id="ABV"><svg style="width:800px;height:300px;"></svg></div>


<script type="text/javascript">
    nv.addGraph(function() {
        var chart = nv.models.discreteBarChart().color(['#F15B29', '#F26B3E', '#F37B53', '#F58C69', '#F69C7E', '#F8AD94']);
                chart.showXAxis(false)

        chart.yAxis
        chart.tooltipContent(function(key, y, e, graph) {
            var x = String(graph.point.x);
            var y = String(graph.point.y);
var y = String(graph.point.y);
            tooltip_str = '<center><b>'+key+'</b></center>' + y + ' at ' + x;
            return tooltip_str;
        });
        d3.select('#ABV svg')
            .datum(data_ABV)
            .transition().duration(500)
            .attr('width', 800)
.attr('height', 300)
            .call(chart);

    return chart;
});data_ABV=[{"values": [{"y": 0, "x": 0}, {"y": 0, "x": 1}, {"y": 0, "x": 2}, {"y": 0, "x": 3}, {"y": 3, "x": 4}, {"y": 24, "x": 5}, {"y": 22, "x": 6}, {"y": 35, "x": 7}, {"y": 34, "x": 8}, {"y": 29, "x": 9}, {"y": 27, "x": 10}, {"y": 26, "x": 11}, {"y": 15, "x": 12}, {"y": 8, "x": 13}, {"y": 9, "x": 14}, {"y": 8, "x": 15}, {"y": 1, "x": 16}, {"y": 0, "x": 17}, {"y": 1, "x": 18}, {"y": 3, "x": 19}, {"y": 0, "x": 20}, {"y": 0, "x": 21}, {"y": 0, "x": 22}, {"y": 0, "x": 23}, {"y": 0, "x": 24}, {"y": 0, "x": 25}, {"y": 1, "x": 26}, {"y": 0, "x": 27}, {"y": 1, "x": 28}], "key": "ABV", "yAxis": "1"}];
</script>


<p>So, the obvious insight to take away from this analysis is that if you want to drink good beer, make sure it’s a 7% IPA from California.  Happy drinking and let me know if you have any questions!</p>


<div class="footnotes">
<hr/>
<ol>
<li id="fn:1">Personal favorites so far: the Lagunitas IPA and Elysian Split Shot.  But I am still a neophyte.
 <a class="footnote-return" href="#fnref:1"><sup>[return]</sup></a></li>
<li id="fn:2">See what I did there?  It’s a pun.  Because beer has hops.  Why aren’t you laughing?
 <a class="footnote-return" href="#fnref:2"><sup>[return]</sup></a></li>
<li id="fn:5">This analysis is kinda fundamentally flawed because we’re looking at absolute occurences instead of relative frequencies of great breweries in a given state, but who cares?
 <a class="footnote-return" href="#fnref:5"><sup>[return]</sup></a></li>
<li id="fn:3">I’m only like 65% sure this is accurate.  The person who told me had spent the past four hours becoming well-acquainted with the subject matter, so to speak.
 <a class="footnote-return" href="#fnref:3"><sup>[return]</sup></a></li>
</ol>
</div>
	