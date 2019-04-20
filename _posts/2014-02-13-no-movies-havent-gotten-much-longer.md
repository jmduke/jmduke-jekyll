---
title: "No, movies haven't gotten (much) longer"
Date: 2014-02-13 00:00:00
Tags: ["data"]
layout: post
---

<p>Have movies gotten longer?</p>


<p>It often feels like they have, right?  I mean, <em>The Hobbit</em> was just under three hours (and felt like just over four!) – <em>The Avengers</em> was 142 minutes, and the sheer volume of people complaining about how long movies are lends some credence to the theory that yes, Hollywood has decided to drown their consumers in running time.</p>


<p>But I just caught <em>The Good, The Bad, and The Ugly</em> on Netflix <sup class="footnote-ref" id="fnref:1"><a href="#fn:1" rel="footnote">1</a></sup> and here’s the thing: despite being a very old movie – and a very good movie – it is also a very long movie.  In fact, the English dub clocks in at 179 minutes – literally one minute less than three hours.  Is it possible that movies haven’t gotten longer, and that our attention spans have just gotten shorter?</p>


<p>I decided to answer this question in the best way possible – with large amounts of data.</p>


<h3 id="preprocessing">Preprocessing</h3>


<p>Getting the data was actually incredibly simple.  I was so ready to write a scraper or two, but then IMDB had to go and <a href="http://www.imdb.com/interfaces">release all of their data for public consumption</a>.  In particular, they have a file called <code>running-times.list</code>, which contains exactly what you might think it contains.</p>


<p>The format, though, leaves something to be desired.  Take this snippet from near the beginning of the file:</p>


<pre><code>"#OscarTheOuch" (2013)                  30
"#Yaprava" (2013)                   60  (with commercials)
"#lovemilla" (2013)                 6   (approx.)
"#waszurwahl" (2013)                    25
"$#*! My Dad Says" (2010)               USA:30
"$#*! My Dad Says" (2010) {Code Ed (#1.4)}      30
"$#*! My Dad Says" (2010) {Goodson Goes Deep (#1.12)}   30
"$#*! My Dad Says" (2010) {Make a Wish (#1.9)}      30
"$#*! My Dad Says" (2010) {Pilot (#1.1)}        30
"$#*! My Dad Says" (2010) {Wi-Fight (#1.2)}     30
"$100 Makeover" (2010)                  USA:30
</code></pre>


<p>A few issues jump out immediately:</p>


<ul>
<li>The data dump includes television shows.</li>
<li>The data’s not standardized at all: running times are prepended with countries, or appended with annotations.</li>
<li>They turned <a href="https://twitter.com/shitmydadsays">@shitmydadsays</a> into a TV show?  Seriously?</li>
</ul>


<p>There are a few approaches we can take to clean this data, considering all we care about is release date and run time.  First, lets load the thing into memory and grab the relevant lines:</p>


<pre><code>all_data = open('running-times.list').readlines()[15:-2]
&gt;&gt;&gt; len(all_data)
876277
</code></pre>


<p>Jeez, that’s a lot of (mainly awful) data.  Let’s try and munge it a little, shall we?</p>


<p>First, the two columns (name + release date and running time) are separated by tabs, so lets split those up and do some basic cleanup.</p>


<pre><code>for line in all_data:
    split_line = line.split('\t')
    try:

        # Get the first column.
        release_date = split_line[0]
        # First column looks like MOVIE_NAME (RELEASE_YEAR), so split at "(" and grab everything after.
        release_date = release_date.split("(")[1]
        # Years are four digits (and numerical), right?
        release_date = int(release_date[:4])

        # Get the last column if it's got what we want; otherwise grab the one before it, for cases like:
        # &gt; Zubin and the I.P.O. (1983) (TV)            USA:59  (with commercials)
        run_time = split_line[-1] if "(" not in split_line[-1] else split_line[-2]
        # Some of the lines are in the form of COUNTRY:TIME, so split at the colon. 
        run_time = run_time.split(":")[-1]
        # Strip the newline character and convert to integer.
        run_time = int(run_time.strip())

        parsed_data.append([release_date, run_time])

    except:
        print "Ugh, edge case."
</code></pre>


<p>And if we were to print the first ten lines now, they look something like this:</p>


<pre><code>[[2013, 7], [2013, 7], [2013, 7], [2013, 6], [2013, 6], [2013, 30], [2013, 60], [2013, 6], [2013, 25], [2010, 30]]
</code></pre>


<p>Excellent!</p>


<p>Now, we need to make sure that we aren’t catching any TV shows in this list, so lets filter out anything with a run time of exactly thirty or sixty minutes:</p>


<pre><code>parsed_films = filter(lambda x: x[1] % 30, parsed_data)
</code></pre>


<h3 id="the-fun-stuff">The Fun Stuff</h3>


<p>Excellent!  Now we’re ready to do the fun stuff.  Let’s load this bad boy into <code>pandas</code>.</p>


<pre><code>import pandas as pd
films = pd.DataFrame(parsed_films)
films.describe()
</code></pre>


<p>And the output:</p>


<pre><code>                   0              1
count  682406.000000  682406.000000
mean     1993.398848      50.930266
std        22.807275      47.485743
min       100.000000       1.000000
25%      1984.000000      14.000000
50%      2003.000000      43.000000
75%      2010.000000      85.000000
max      2019.000000    3608.000000
</code></pre>


<p>Well, that’s strange, right?  Some things look normal – the average release date is 1993 – but the average run-time is fifty minutes?  The latest movie is from <a href="http://www.imdb.com/title/tt2640694/">five years in the future</a>?  Something’s gotta be off – we’re not done cleaning things up yet.</p>


<p>The second answer is obvious – IMDB’s going to have some inaccurate and irrelevant data, and with around six hundred thousand items a few outliers aren’t going to harm the integrity of our analysis.  Still, the first question is a bit more concerning, and the answer is probably obvious for someone with experience in the field <sup class="footnote-ref" id="fnref:2"><a href="#fn:2" rel="footnote">2</a></sup> – television shows aren’t <em>actually</em> thirty or sixty minutes long.  Without commercials, they tend to be 21 and 42 respectively: since there’s some variance, I’m going to be lazy and assume that anything shorter than 45 minutes is on the small screen.  Pandas makes filtering easy:</p>


<pre><code>filtered_films = films[(films[0] &lt; 2015) &amp; (films[1] &lt; 45)]
</code></pre>


<p>And the new summary statistics:</p>


<pre><code>                   0              1
count  318319.000000  318319.000000
mean     1988.178550      89.202935
std        23.106662      43.874200
min      1725.000000      46.000000
25%      1974.000000      70.000000
50%      1996.000000      87.000000
75%      2007.000000     100.000000
max      2014.000000    3608.000000
</code></pre>


<p>Oh man, that looks great, doesn’t it?  <sup class="footnote-ref" id="fnref:3"><a href="#fn:3" rel="footnote">3</a></sup>  We have a bonified collection of x and y values, and now all we need to do is group them by release date to have a genuine time-series dataframe on our hands.  And, of course, that’s super easy:</p>


<pre><code>films_by_year = filtered_films.groupby(0).mean()
</code></pre>


<p>And then we just throw that into a line graph:</p>


<pre><code>import vincent
line = vincent.Line(films_by_year)
line.axis_titles(x='Year', y='Run time')
line.to_json('movies.json', html_out=True, html_path='movies_template.html')
</code></pre>


<p>And we get our result!:</p>


<script charset="utf-8" src="http://d3js.org/d3.v3.min.js"></script>


<script src="http://d3js.org/topojson.v1.min.js"></script>


<script charset="utf-8" src="http://d3js.org/d3.geo.projection.v0.min.js"></script>


<script src="http://trifacta.github.com/vega/vega.js"></script>


<div id="vis"></div>


<script type="text/javascript">
// parse a spec and create a visualization view
function parse(spec) {
  vg.parse.spec(spec, function(chart) { chart({el:"#vis"}).update(); });
}
parse("/static/movies.json");
</script>


<h3 id="conclusion">Conclusion</h3>


<p>Average running time of 1973 movies: <strong>87.47 minutes</strong>.</p>


<p>Average running time of 1993 movies <strong>89.9 minutes</strong>.</p>


<p>Average running time of 2013 movies: <strong>88.1 minutes</strong>.</p>


<p>So, yeah, unless you spend enough money at the cinema to be able to deduce a slight upward trend of three extra minutes per movie per year, chances are it’s all in your head.  There are some definite Hollywood trends – the reglorification of the blockbuster superhero movie, the phoenix-esque death and rebirth of Matthew McConaughey <sup class="footnote-ref" id="fnref:4"><a href="#fn:4" rel="footnote">4</a></sup> – but longer run times are not one of them.  It exists, but – especially ignoring the pre-1960 trend, which I feel like doesn’t apply to the majority of today’s moviegoers – is incredibly exaggerated.</p>


<div class="footnotes">
<hr/>
<ol>
<li id="fn:1">If you haven’t seen <em>The Good, The Bad, and The Ugly</em>, close this tab, watch it immediately, and then reopen this tab.  Trust me, it’s worth it.
 <a class="footnote-return" href="#fnref:1"><sup>[return]</sup></a></li>
<li id="fn:2">Or, more likely, someone with experience binging Netflix.
 <a class="footnote-return" href="#fnref:2"><sup>[return]</sup></a></li>
<li id="fn:3">If you’re concerned about that movie with a run-time of sixty hours, have a <a href="http://www.imdb.com/title/tt1488085/">look</a> for yourself.
 <a class="footnote-return" href="#fnref:3"><sup>[return]</sup></a></li>
<li id="fn:4">A McConaughssance, if you will.
 <a class="footnote-return" href="#fnref:4"><sup>[return]</sup></a></li>
</ol>
</div>
	