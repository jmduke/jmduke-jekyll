---
title: "Hey, let's crawl Svbtle!"
Date: 2013-06-06 00:00:00
Tags: ["data"]
layout: post
---

<p>Inspired by <a href="http://tomtunguz.com/crawling-the-most-
under-rated-hack">Tomasz Tunguz’s post</a> on the underrated art of web crawling, I decided to crawl
<a href="http://www.svbtle.com">Svbtle</a>, Dustin Curtis’s blog network/“magazine of the
future” thingy. I chose Svbtle because, despite some of its misgivings, it’s
generally an interesting source of content.</p>


<p>I’ll be using <a href="http://scrapy.org">Scrapy</a> for the first time. Scrapy, as I
discovered, is a pretty awesome crawling package for Python – it definitely
embraces a ‘batteries included’ moniker, and I’ll get into some of the details
and tricky areas throughout the post.</p>


<h3 id="1-what-do-i-want-to-crawl">1. What do I want to crawl?</h3>


<p>Svbtle posts, like regular blog posts, aren’t exactly tricky to parse: they’ve
got an author, a title, content, yadda yadda. I figured that I’d grab all of
the discrete info that I could, to make my analysis a little more flexible
down the road. I envisioned my end result as a .csv with a row for each post I
could find – since I didn’t really set out with a definite analytical goal, I
decided to err on the side of data:</p>


<ul>
<li>author</li>
<li>word count</li>
<li>title</li>
<li>title</li>
<li>when it was published</li>
<li>kudos (kudos, for the uninitiated, are Svbtle’s take on Likes/+1s/Retweets).</li>
</ul>


<p>Plugging this into Scrapy is pretty easy: Scrapy takes an OOP-inspired
approach to crawling, so defining what I want to find is as simple as creating
a class for it:</p>


<pre><code>class Article(Item):
    author = Field()
    url = Field()
    kudos = Field()
    word_count = Field()
    title = Field()
    published = Field()
</code></pre>


<p>Now, to actually populate these fields, we extend Scrapy’s <code>CrawlSpider</code> class
and, amongst a few other things, add a <code>parse_article</code> method that takes a
<code>Response</code> object and spits out an <code>Article</code>. Scrapy’s default way of handling
this is using <code>HtmlXPathSelector</code>, which is basically jQuery selection with
some weird syntactic sugar. For example:</p>


<ul>
<li>Grabbing all the links on a page is <code>\\a</code>.</li>
<li>Grabbing all the divs with a class of ‘foo’ is <code>\\div[@class='foo']</code>.</li>
<li>Grabbing all the second paragraphs of a given div is `\div\p[2]‘.</li>
</ul>


<p>Dustin did a lovely job of minimizing spaghetti code (at least outwardly) in
Svbtle, and as a result writing selectors for all of our fields is easy:</p>


<pre><code>def parse_article(self, response):
    x = HtmlXPathSelector(response)

    article = Article()
    article['url'] = response.url
    article['author'] = "/".join(response.url.split('/')[:3])
    article['kudos'] = x.select("//div[@class='num']/text()").extract()[0]
    words = x.select("//article[@class='post']").extract()
    article['word_count'] = len(words[0].split())
    article['title'] = x.select("//title/text()").extract()[0].split('|')[0].strip()
    article['published'] = x.select("//time/text()").extract()[0]

return article
</code></pre>


<p>(Note: even if <code>select()</code> only yields one result, that result’s still wrapped
in a tuple.)</p>


<p>So, if we get the HTML for a svbtle post, we can scrape all the good stuff and
save it as an <code>Article</code> object! Yay! What’s next?</p>


<h3 id="2-where-do-i-want-to-crawl">2. Where do I want to crawl?</h3>


<p>Crawlers, in a way, work just like us: they need a jumping-off point (or <em>root
url</em>) and they start madly clicking on hyperlinks from there. Ideally, our
root url would be a link to every single Svbtle blog out there –
unfortunately, no such page exists (Svbtle <em>used</em> to have a list, but it
vanished a while back.)</p>


<p>Scrapy isn’t wonderful enough to automagically find every blog using the
Svbtle backend – since blogs are hosted on individual domains (for example,
Dustin’s blog is on <a href="http://dcurt.is">dcurt.is</a>, not dcurtis.svbtle.com), it’s
going to be tricky to magically get a list of authors/blogs. For starters,
let’s just use the <a href="http://svbtle.com/feed">main feed</a>, which gives us twenty
or so recent posts:</p>


<pre><code>start_urls = "http://www.svbtle.com/feed"
</code></pre>


<p>(<code>start_urls</code> is an attribute of <code>CrawlSpider</code> – it takes either a string or
a list/tuple of strings.)</p>


<p>Lastly, we give the spider a <strong>rule</strong> – the <a href="http://doc.scrapy.org/en/latest/topics/spiders.html#crawling-rules">Scrapy
docs</a> give
a better explanation of rules than I ever could, but they’re essentially
regular expressions that denote whether or not the spider ‘clicks’ on a link.
These rules generally are based off of the <code>href</code> of the link, but you can
also use XPaths like we did with parsing a minute ago to specify which DOM
elements to look at.</p>


<p>To keep things simple at first, we’re going to accept any link we find within
the body of an article (crawling veterans will probably twitch a little bit at
that) and point it towards our custom parsing method:</p>


<pre><code>rules = [Rule(
        SgmlLinkExtractor(
            allow=r'.*',
            restrict_xpaths="//article"
        ), 
        callback='parse_article', 
        follow=True)
]
</code></pre>


<h3 id="3-firing-up-the-web">3. Firing up the web</h3>


<p>And that’s all we have to do! That’s like, twenty lines of Python, and Scrapy
handles all the gory details. We fire it up with the CLI:</p>


<pre><code>scrapy runspider svbtle_scraper.py
</code></pre>


<p>And to output everything into a nice li’l CSV:</p>


<pre><code>scrapy runspider svbtle_scraper.py -o scraped.csv -t csv
</code></pre>


<p>And now we wait!</p>


<h3 id="4-oh-god-what-have-i-done">4. Oh god what have I done</h3>


<p>There’s a reason that the ‘web’ is such an apt metaphor for the internet:
while the average web page only has around <a href="http://wwwold.iit.cnr.i
t/staff/marco.pellegrini/papiri/www015-pellegrini.pdf">7.5 links</a>, the massive breadth of
the internet explodes that number thanks to the powers of exponential growth.
(Quick napkin math: <code>7.5 ** 10 == 563 million</code>)</p>


<p>To give you an anecdotal proof of this: I run my poor, naive spider for the
first time and, as one might expect from such a SV-centric set of bloggers,
one of the posts I crawl has a <a href="http://www.techcrunch.com">TechCrunch</a> quote.
And, of course, the quote is cited: so my poor, naive spider suddenly starts
to crawl TechCrunch, looking furiously for something that resembles a Svbtle
post – and, after ten minutes and a few hundred requests, I’m down the
rabbithole of a massive stack of hyperlinks.</p>


<p>I furiously mash Ctrl+C. This approach isn’t going to work – and besides,
even if I play whack-a-mole by excluding bigger domains (by adding another
rule), this isn’t going to be a feasible solution.</p>


<p>I took a step back. I knew what I needed: a definitive list of Svbtle-backed
sites. If I pass those all as a massive rule, I can force the spider to stay
only on those sites, like an overprotective mother too nervous to let their
kid on AOL without parental controls (that metaphor might betray my age to the
audience, but whatever).</p>


<p>But how do I get such a list?</p>


<h3 id="5-doing-things-the-dumb-and-easy-way">5. Doing things the dumb (and easy) way</h3>


<p>I did some poking around and found <a href="https://twitter.com/svbtlefeed">a twitter
stream</a> that corresponds with Svbtle’s home
page – and instead of 20 posts, it has 875! It’s probably not all of the
authors ever, but it’s much more than I had before. Now how do I grab all of
the sites quickly?</p>


<p><strong>The elegant way</strong>: Use Twitter’s API and grab all of the tweets in JSON (dealing with OAuth and the hellish v1.1 API along the way), then parse the tweets for the URLs. Hope I don’t hit the usage cap along the way!</p>


<p><strong>My way</strong>: Keep scrolling down until I load all 875 tweets and then save the HTML file and parse it with XPath.</p>


<p>You know what? My way took ninety seconds and six lines of code. I stand by
it.</p>


<pre><code>def get_svbtle_blogs():
    plainhtml = '\n'.join(open('svbtlefeed.html').readlines())

    # Gotta create a fake 'Response' object so Scrapy's utils can scan it:
    # for some reason, they can't handle basic `str`s.
    fake_response = TextResponse('http://www.svbtle.com')
    fake_response = fake_response.replace(body=plainhtml)

    x = HtmlXPathSelector(fake_response)
    all_links = x.select("//a[@class='twitter-timeline-link']/@title").extract()
    base_links = ["/".join(x.split('/')[:3]) for x in all_links]
    base_links = list(set(base_links))

    return base_links
</code></pre>


<p>And we can plug this guy back into our extension of CrawlSpider – we’ll use
it to both set a list of root urls AND restrict where our spider can go:</p>


<pre><code>start_urls = get_svbtle_blogs()
rules = [Rule(
                SgmlLinkExtractor(
                    allow= get_svbtle_blogs(),
                ), 
                callback='parse_article', 
                follow=True)
        ]
</code></pre>


<h3 id="6-closing-thoughts">6. Closing thoughts</h3>


<p>This pretty much worked perfectly. It took me around fifteen minutes to
successfully scrape fifteen hundredish posts; while there’s still some
sanitation I need to do (Scrapy interpreted pagination in a relatively funky
manner), I couldn’t be more pleased with the results. I highly recommend
Scrapy: while you’ll have to do some tinkering on your own (the tutorial and
documentation are a little out of date) it makes life much, much easier than
trying to roll your own with Requests and BeautifulSoup.</p>
	