---
title: "Crawling Tumblr with multiprocessing"
Date: 2014-12-20 00:00:00
Tags: ["python"]
layout: post
---

<p>Let’s say you want to crawl Tumblr.</p>


<p>I’m choosing Tumblr here because it’s a relatively interesting example: unlike Twitter, which is super transparent about its social graph, or Facebook, whose social graph is fairly dense across geographic spectra <sup class="footnote-ref" id="fnref:1"><a href="#fn:1" rel="footnote">1</a></sup>, there’s not that much known about the Tumblr social graph.  Plus, getting follower and following lists programmatically is impossible for anyone besides yourself, barring OAuth (which doesn’t exactly jive with the whole crawling thing).</p>


<p>However, Tumblr does expose one thing: post lists (this makes sense, since all usernames expose them via <code>username.tumblr.com</code> anyway).  Post lists contain a <code>source_url</code> field unless it’s original content <sup class="footnote-ref" id="fnref:2"><a href="#fn:2" rel="footnote">2</a></sup>, which sometimes is an external link but usually points back to someone else’s tumblr.  So it’s not a complete guarantee, but it’s a pretty strong proxy.</p>


<p>So let’s plot out a general plan of attack:</p>


<ol>
<li>Start with two lists: <code>crawlable</code>, which is a list of all the tumblrs we can check for posts; and <code>crawled</code>, which is just a list of all tumblrs we’ve come across.</li>
<li>Populate <code>crawlable</code> with a single root node to check for posts first – in this case, <a href="http://jmduke.tumblr.com">my tumblr</a> should serve nicely.</li>
<li>Pop the first item in <code>crawlable</code> – so, to start, <code>jmduke</code> – and grab all <sup class="footnote-ref" id="fnref:3"><a href="#fn:3" rel="footnote">3</a></sup> of its posts.</li>
<li>For each post we grab, extract the name of the tumblr (if it exists). If we have already looked up that tumblr before, ignore it.  Otherwise, add it to <code>crawlable</code> and <code>crawled</code>.</li>
<li>If, at the end of this, <code>crawlable</code> is empty: yay!  You’re done!  Otherwise, go back to step 3.</li>
</ol>


<p>Tumblr actually exposes <a href="https://github.com/tumblr/pytumblr">PyTumblr</a>, a first-party API library.  Using it, we easily can write something like this:</p>


<pre><code>def process_username(username):

    # Grab posts from tumblr.
    response = client.posts(username)

    # Sometimes the usernames are bad; let's just ignore them.
    if 'posts' not in response:
        logging.warning("Posts not found for name: {}".format(username))
        return

    posts = response['posts']
    for post in posts:

        # Only grab reblogs.
        if 'source_url' not in post:
            continue
        url = post['source_url']

        # Don't go circular.
        if username in url:
            continue

        # Sources can be external, so ignore those.
        if 'tumblr' not in url or "www.tumblr.com" in url:
            continue

        # Should look like "http://{username}.tumblr.com/{otherstuff}".
        # (Regex is probably a better way to do this.)
        try:
            new_name = url.split(".tumblr.com")[0]
            if "https" in new_name:
                new_name = new_name.split("https://")[1]
            elif "http" in new_name:
                new_name = new_name.split("http://")[1]
            if "www" == new_name[0:3]:
                new_name = new_name.split(".")[1]
        except:
            logging.warning("Can't find username in url: {}".format(url))
            continue

        if new_name not in crawled_names:
            # Add it to crawled_names immediately to make sure other threads don't try it.
            crawlable_names.add(new_name)
            crawled_names.add(new_name)
            logging.info("Found new username: {}".format(new_name))
</code></pre>


<p>Nothing too crazy, right?  And all wee need is some scaffolding to continuously feed in usernames from <code>crawlable_names</code>:</p>


<pre><code>if __name__ == "__main__":
    crawlable_names.add("jmduke")
    while len(crawled_names) &lt; 5000:
        username = crawlable_names.pop()
        process_username(username)

    with open("tumblr_usernames.csv", "w") as outfile:
        outfile.write("\n".join(crawled_names).encode('utf-8'))
</code></pre>


<p>As you can see, I decided to stop at 5000 just to see how long it would take.</p>


<p>I run this script with the lovely <a href="https://docs.python.org/2/library/profile.html#module-cProfile">cProfile module</a> and discover:</p>


<pre><code>[jmduke:~]$ python -m cProfile -s cumtime crawl_tumblr.py
81769 function calls (81279 primitive calls) in 423.316 seconds
</code></pre>


<p>Oof, that’s slow.  The bottleneck here is clearly the API call, seeing as we’re not doing much of anything else: <code>cProfile</code> says we spend around 925 ms in <code>api_helper.py</code> per call, which is a total bummer.</p>


<p>No matter how we slice it, grabbing the post is gonna take around a second, and if we extrapolate from the small run we can only get around twelve usernames per second.  That’s… unfortunate, especially if we want to build a substantial dataset of at least a million or so nodes.</p>


<p>So: what’s the solution?</p>


<h3 id="multithreading-is-fucking-awesome">Multithreading is fucking awesome</h3>


<p>I’ve never really played around with multithreading in Python.  I’ve heard grave mumblings about the GIL, and a general lack of support for concurrency, but nothing super positive – nor the real need to use it.  But this seemed like as good as an opportunity to play around with it, right?</p>


<p>After all, each API call is fairly autonomous: once we have a couple dozen crawlable names, we should be able to spin up threads and make each call individually: even if we’re not speeding up the actual response time, we’re firing off enough requests to make up for it.</p>


<blockquote>
<p>But wait.  Don’t you need to worry about thread safety?  How do you keep track of the crawled names across threads?  Won’t this be crazy complicated?</p>
</blockquote>


<p>Turns out – nah.  There’s a bunch of scaffolding you need to build, but nothing too crazy – and all of it is first party.</p>


<p>First, we convert the set of crawlable names to a <a href="https://docs.python.org/2/library/queue.html">Queue</a>, which is a synchronized queue class that fits our use case perfectly:</p>


<pre><code>from queue import Queue
crawlable_names = Queue()
</code></pre>


<p>Queues behave very much like you’d expect, the only difference is the names of the methods we need:</p>


<ul>
<li>instead of calling <code>crawlable_names.add(username)</code>, we call <code>crawlable_names.put(username)</code></li>
<li>instead of calling <code>len(crawlable_names)</code>, we call <code>crawlable_names.qsize()</code></li>
<li>Most importantly: instead of calling <code>crawlable_names.pop()</code>, we call <code>crawlable_names.get()</code></li>
</ul>


<p>Next, we have to make a <em>worker</em> method.  To try and avoid diving too deep in multiprocessing jargon, this method is basically designed to be fired over and over by a thread until the thread terminates.  So ours looks like this:</p>


<pre><code>def worker():
    while True:
        username = crawlable_names.get()
        process_username(username)
        crawlable_names.task_done()
</code></pre>


<p>The only weird-ish thing here is the <code>task_done()</code> call, which is our way of telling the <code>Queue</code> that we’ve finished messing around with the last item we got and we’re ready to move on.  The other missing piece is actually creating the threads:</p>


<pre><code>def spin_threads():
    thread_count = 50
    for i in range(thread_count):
        thread = Thread(target=worker)
        thread.start()
</code></pre>


<p>Nothing too crazy here, either.  We wrap it all together by rewriting the main invocation:</p>


<pre><code>if __name__ == "__main__":
    try:
        crawlable_names.put("jmduke")
        spin_threads()
        while active_count() &gt; 0:
            time.sleep(0.1)
</code></pre>


<p>Aaaand we give it a whirl, by using <code>cProfile</code> again:</p>


<pre><code>[jmduke:~]$ python -m cProfile -s cumtime crawl_tumblr_multithreaded.py
81769 function calls (81279 primitive calls) in 15.423 seconds
</code></pre>


<p>Welp.  Was legitimately not expecting it to be that effective: it doesn’t scale <em>quite</em> exactly, due to the additional overhead of managing the threads, but a 50x increase in threads brings with it a 28.2x increase in throughput.  Pretty great.</p>


<h3 id="other-cool-jank-to-try">Other cool jank to try</h3>


<p>So, <a href="https://gist.github.com/jmduke/6281ef0e8c7ef8fa466e">here</a> is the final script – plus some convenience to let you actually terminate it with Ctrl+C.  Run it, DDOS Tumblr, whatever.</p>


<p>I think there’s inherent value in being able to summon millions of usernames (whether for benign or nefarious means), but there are a number of things to do with this meager code:</p>


<ul>
<li>You can easily rip out the whole Tumblr part of it altogether and replace it with your network of choice.  Twitter comes to mind, due to how easy it is to crawl.</li>
<li>Right now, all it’s doing is printing out usernames, as opposed to actually constructing a graph of connections – which would be infinitely cooler.</li>
<li>At some point, there has to be diminishing returns on the number of threads we spin up, right?  Since you can actually import <code>cProfile</code> within a script, it would be super-neat to figure that out programmatically.</li>
<li>If we were really trying to be speed demons: the bottleneck here is gonna be the number of threads on a single machine, since all of the queue synchronization is done offline.  We could plug this into a queuing service – like <a href="http://aws.amazon.com/sqs/">SQS</a> – to try and run it on a bunch of random hosts and scale that way as well.</li>
</ul>


<p>(For my part: I’m going to try and grab around ~two million connections and see if I can get some <a href="http://en.wikipedia.org/wiki/Dunbar%27s_number">Dunbar’s number</a> insights from it.  But more about that in 2015.)</p>


<p>Hope you liked this!  Shoot me any questions you have in the comments.</p>


<div class="footnotes">
<hr/>
<ol>
<li id="fn:1">If you’re in Seattle, you’ll be Facebook friends with lots of other people in Seattle, etc. etc.
 <a class="footnote-return" href="#fnref:1"><sup>[return]</sup></a></li>
<li id="fn:2">Spoiler alert: this is very rare.
 <a class="footnote-return" href="#fnref:2"><sup>[return]</sup></a></li>
<li id="fn:3">I say <em>all</em>, but in reality I’m only grabbing the first twenty or so, as Tumblr’s API paginates the posts.  This is due solely to laziness on my part.
 <a class="footnote-return" href="#fnref:3"><sup>[return]</sup></a></li>
</ol>
</div>
	