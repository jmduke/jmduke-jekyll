---
title: "Extracting an image from an RSS feed in Python"
Date: 2016-02-11 00:00:00
Tags: ["python"]
layout: post
---

<p>I have a bit of a social media automation thing set up for Barback, in which I tweet articles from some of my favorite cocktail and liquor blogs.  I’m pretty new to the whole social media shtick, but a lot of places recommend adding images and other media to increase engagement, so I set out looking for a way to grab images from the RSS feeds where I get articles.</p>


<p>Despite my assumptions, there’s no actual room in the RSS spec for an image.  Most articles throw it in the summary or just the raw content (since the actual articles themselves have them pretty high up), but there’s nothing standard.</p>


<p>Thankfully, I was already using <a href="https://github.com/kurtmckee/feedparser">feedparser</a> to parse the RSS itself:</p>


<pre><code>feed_url = “http://rss.artofdrink.com/theartofdrink”
feed = feedparser.parse(feed_url)
articles = feed['entries']
</code></pre>


<p>So we’ve got a list of articles.  Now, we can just use the summary — which itself is HTML — to look for images, letting the wonderful <a href="http://www.crummy.com/software/BeautifulSoup/">BeautifulSoup</a> package do the heavy lifting:</p>


<pre><code>for article in articles:
    soup = BeautifulSoup(article.summary)
    image_url = soup.find('img')['src']
    if image_url:
        # Hey, we have an image!
</code></pre>


<p>It’s that simple!  You’re leaning on two heavy libraries to do all the work for you, but it’s better than trying to parse HTML itself, which is for all intents and purposes a toxic hellscape.</p>
	