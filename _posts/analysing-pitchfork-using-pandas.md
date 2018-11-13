---
Title: "Analysing Pitchfork using Pandas"
Date: 2013-12-24 00:00:00
Tags: ["data"]
---

<p>I spend a likely-unhealthy amount of time on <a href="http://www.pitchfork.com">Pitchfork</a>, its where I get my music news and I can usually rely on their reviews to decide whether or not an album is worth a listen.  Still, they often come under fire as being — amongst other things — self-serious and overly critical: allegations have been made that their albums are graded on a too-harsh scale, with their reviews being motivated by commercial reasons as much as musical ones.</p>


<p>So, naturally, I downloaded <a href="https://classic.scraperwiki.com/scrapers/pitchfork_review_data/">all of them.</a></p>


<hr/>


<p>I decided to load the thing into Python (using the wonderful <a href="http://pandas.pydata.org/">pandas</a> library) and poke around.</p>


<pre><code>import pandas as pd
DATE_INDEX = -2
review_data = pd.read_csv('./pitchfork_review_data.csv’, parse_dates=[DATE_INDEX])
</code></pre>


<p>The immediate curiosity for me was that of score distribution: Pitchfork grades on a 0.0 — 10.0 scale, so one would expect that the average is 5.0, right?</p>


<p>Well, let’s take a look:</p>


<pre><code>review_data[‘score’].describe()
</code></pre>


<table>
<thead>
<tr>
<th></th>
<th>score</th>
</tr>
</thead>
<tbody>
<tr>
<td>count</td>
<td>14919.000000</td>
</tr>
<tr>
<td>mean</td>
<td>6.969562</td>
</tr>
<tr>
<td>std</td>
<td>1.356199</td>
</tr>
<tr>
<td>min</td>
<td>0.000000</td>
</tr>
<tr>
<td>25%</td>
<td>6.400000</td>
</tr>
<tr>
<td>50%</td>
<td>7.200000</td>
</tr>
<tr>
<td>75%</td>
<td>7.800000</td>
</tr>
<tr>
<td>max</td>
<td>10.000000</td>
</tr>
</tbody>
</table>


<p><strong>Out of all 14900 reviews, the average is 6.97 — talk about grading on a curve.</strong>  Additionally, half of all reviews fall between a 6.4 and a 7.8 — a pretty significant window considering the general sense of outrage given to reviews that throw out scores less than a 5.0 and the general ‘king making’ power of a Best New Music accolade (generally given to artists that score an 8.2 or higher).</p>


<p>Actually, speaking of Best New Music, let’s take a look at that.</p>


<pre><code>review_data[review_data.accolade == ' Best New Music '].describe()
</code></pre>


<table>
<thead>
<tr>
<th></th>
<th>score</th>
</tr>
</thead>
<tbody>
<tr>
<td>count</td>
<td>500.000000</td>
</tr>
<tr>
<td>mean</td>
<td>8.619400</td>
</tr>
<tr>
<td>std</td>
<td>0.328602</td>
</tr>
<tr>
<td>min</td>
<td>7.800000</td>
</tr>
<tr>
<td>25%</td>
<td>8.400000</td>
</tr>
<tr>
<td>50%</td>
<td>8.500000</td>
</tr>
<tr>
<td>75%</td>
<td>8.800000</td>
</tr>
<tr>
<td>max</td>
<td>10.000000</td>
</tr>
</tbody>
</table>


<pre><code>''' head() will give us the five lowest scoring reviews '''
review_data[review_data.accolade == ' Best New Music '].sort('score').head()    
''' tail() will give us the five highest '''
review_data[review_data.accolade == ' Best New Music '].sort('score’).tail()
</code></pre>


<p>Looks like the lowest score given to a BNM is 7.8 (given to <a href="http://pitchfork.com/reviews/albums/1766-me-and-giuliani-down-by-the-school-yard-a-true-story-ep/">!!!’s Me and Giuliani Down by the Schoolyard</a>, a groan-inducing name if I’ve heard of one.  Conversely, the three highest scores handed down to new music are 9.6, 9.7, and a controversial 10.0 to <em>The Fiery Furnaces</em>, <em>Arcade Fire</em>, and <em>Kanye West</em> respectively.</p>


<p>Back to the overall score distribution, though, percentile data only gives us one perspective at the data.  Graphing the rounded  scores yields some interesting results:</p>


<pre><code>import matplotlib as plt
import matplotlib.pyplot as pyplt
pyplt.hist(review_data['score'])
pyplt.show()
</code></pre>


<p><img alt="" src="http://i.imgur.com/uahiyEM.png"/></p>


<p>As expected, there’s a clustering of reviews in the 6-8 range, with a long tail approaching 0 and a steep drop off to 10.  But if we increase the granularity:</p>


<pre><code>pyplt.hist(review_data['score’], bins=20)
pyplt.show()
</code></pre>


<p><img alt="" src="http://i.imgur.com/Gd8IYC3.png"/></p>


<pre><code>pyplt.hist(review_data['score’], bins=50)
pyplt.show()
</code></pre>


<p><img alt="" src="http://i.imgur.com/C6wnpJW.png"/></p>


<p>We get a much more interesting perspective.  In particular, Pitchfork loves their 7.5s and 8.2s.  Also revealing is the relative frequency of perfect scores: mainly reserved for Beatles and jazz reissues, one can imagine the backlash if a reviewer deems <em>Kind of Blue</em> less than perfect.</p>


<p>--—</p>


<p>Another charge often levied at <em>Pitchfork</em> is that their standards have diminished as they’ve gained a larger viewership.    We can try simply plotting the reviews against their publish date, but it’s not much help:</p>


<pre><code>daily_data = review_data.groupby("publish_date")['score'].mean()
daily_data.plot()
pyplt.show()
</code></pre>


<p><img alt="" src="http://i.imgur.com/SsVUbka.png"/></p>


<p>There’s too much noise to get a good impression of any overall trends: while it looks like things tend to oscillate around the 7.0 mark, we can try plotting the mean review score of each month to get a clearer picture.</p>


<pre><code>monthly_data = daily_data.resample('M', how='mean')
monthly_data.plot()
pyplt.show()
</code></pre>


<p><img alt="" src="http://i.imgur.com/Ra3kjXg.png"/></p>


<p>Quite a bit clearer: we can attribute the early flux to the fact that Pitchfork’s first few years, they were only publishing one or two reviews per week as opposed to five a day.  It looks like  averages were relatively steady, with a slight dip from 2007 — 2010, but we can run a regression to make sure: </p>


<pre><code>monthly_data.plot()
monthly_frame = monthly_data.reset_index()
total_points = len(monthly_data)
model = pd.ols(y=monthly_frame[0], x=pd.DataFrame(range(0, total_points)), intercept=True)
</code></pre>


<p>Wow: with a RMSE of .6757 (not great, but not awful), we get a line with an intercept of <strong>6.977</strong> and slope of <strong>.000037</strong> — as in, barely any change at all.<br/>
</p>


<p>--—</p>


<p>Lastly, let’s take a look at the reviewers themselves: it’s not exactly out of the realm of possibility that certain critics are sticklers and others are more generous (I mean, anyone who gave <em>Merriweather Post Pavilion</em> a 9.6 can’t have the highest standards, right?)</p>


<pre><code>reviewer_data = review_data.groupby('reviewer')['score']
aggregated_reviewers = reviewer_data.mean()
aggregated_reviewers.sort(‘mean’)
</code></pre>


<p>Skipping over group reviews, the strongest authors at either extreme:</p>


<table>
<thead>
<tr>
<th>reviewer</th>
<th>average score</th>
</tr>
</thead>
<tbody>
<tr>
<td>Bob O. McMillan</td>
<td>3.5</td>
</tr>
<tr>
<td><a href="http://en.wikipedia.org/wiki/Alan_Smithee">Alan Smithee</a></td>
<td>4.0</td>
</tr>
<tr>
<td>Adam Ohler</td>
<td>4.2</td>
</tr>
<tr>
<td>…</td>
<td>…</td>
</tr>
<tr>
<td>Carl Wilson</td>
<td>8.5</td>
</tr>
<tr>
<td>Philip Welsh</td>
<td>8.6</td>
</tr>
<tr>
<td>Drew Daniel</td>
<td>8.6</td>
</tr>
</tbody>
</table>


<hr/>


<p>That’s all I’ve got for now — I hope you found it interesting, either from a programming perspective or a musical one!  Feel free to download the <a href="https://classic.scraperwiki.com/scrapers/pitchfork_review_data/">csv</a> and play around with it yourself — if there are any questions you’d like me to answer (or suggestions for further analysis), please let me know via email or comment.</p>
	