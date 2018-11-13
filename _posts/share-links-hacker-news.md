---
Title: "Creating Hacker News Share Links Seeded with a URL and Title"
Date: 2017-02-11 00:00:00
Tags: ["development"]
---

<p>I was building out simple share links for a client a while back; they’re a technical client, so a lot of their content makes more sense on Twitter and Hacker News than say, Facebook.  Hacker News is a great source of traffic and engagement from a hyper-technical audience, but its sharing ecosystem isn’t super baked out: we wanted a way to pre-seed a link submission with a URL and title, but couldn’t find an obvious way.</p>


<p>If you’re looking for the same thing: let me save you another five minutes of Googling!</p>


<p>Here’s all you have to do:</p>


<pre><code>https://news.ycombinator.com/submitlink?u=http://google.com&amp;t=Google
</code></pre>


<p>All you have to do is hit <code>/submitlink</code> instead of <code>/submit</code>, and supply the URL in <code>u=</code> and the title in <code>t=</code>.  (Both are optional, if you want to omit them for any reason.)</p>


<p>Here’s a clickable version of that exact link – try tinkering with the URL and title values to see how it works:</p>


<p><a href="https://news.ycombinator.com/submitlink?u=http://google.com&amp;t=Google">https://news.ycombinator.com/submitlink?u=http://google.com&amp;t=Google</a></p>


<p>Or, if you’d like, you can try the share link right below this post to see how it works 😉</p>
	