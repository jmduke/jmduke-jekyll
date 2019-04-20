---
title: "Using webassets with Pelican"
Date: 2014-10-09 00:00:00
Tags: ["development","pelican"]
layout: post
---

<p>If you are like me, you are an idiot.</p>


<p>More specifically, you are an idiot about how to handle static files with Python stuff – compiling your SASS, minifying and gzipping your jank, uglifying your javascript, all of that stuff.</p>


<p>Until very recently, my process of compiling of all of that stuff prior to pushing it for S3 for <a href="http://filmscriptsonline.com">Film Scripts Online</a>, one of my new Pelican projects, was something along these longs:</p>


<ol>
<li>Run <code>scss</code> manually.</li>
<li>Modify my <code>Makefile</code> to uglify and compress my <code>js</code>.</li>
<li>Fiddle around with <code>s3cmd</code> to try and gzip on upload.</li>
<li>Watch as everything is ruined forever for reasons beyond my understanding.</li>
<li>Cry to self, drink Bulleit, hit <code>make s3_upload</code> and hope that things improve on their own.</li>
</ol>


<p>In my most recent attempt to solve this issue, for <a href="https://github.com/jmduke/terrace/">this very blog</a> – also written in Pelican – I stumbled upon <code>webassets</code>, a beautiful and wonderful solution.</p>


<p>The only problem with this wonderful and beautiful solution is that appears to be entirely undocumented.  Parts of it appear – on the plugin read, on Pelican’s readthedocs, on webasset’s readthedocs, frustrated blog posts – but hey, let’s try and actually compile the process of doing this all in one place!</p>


<p>So here goes, the full list of jank you a to do.</p>


<p>(I’m using sass/cssmin as the example here, but the same generic process applies to everything else.  The full rundown of <code>webasset</code> functionality is <a href="webassets.readthedocs.org/en/latest/builtin_filters.html">here</a>.)</p>


<h3 id="1-install-some-stuff">1.  Install some stuff.</h3>


<pre><code>sudo gem install sass

sudo pip install cssmin

sudo pip install webassets
</code></pre>


<p>As a general rule of thumb, webassets has support for all of the plugins you’d want but it doesn’t actually come installed with them.  Google is your friend here: as long as you install something that comes in the form of a Python module or a CLI, you should be good to go.</p>


<h3 id="2-webasset-ify-your-theme">2.  webasset-ify your theme.</h3>


<p>Since <code>pelican</code>’s wizardry only goes so far, you need to actually activate it as a plugin in your <code>pelicanconf.py</code> file <sup class="footnote-ref" id="fnref:1"><a href="#fn:1" rel="footnote">1</a></sup>:</p>


<pre><code>PLUGIN_PATHS = [THEME + "/plugins"] # alternatively, ["/path/to/wherever/plugins/are"]
PLUGINS = ['assets']
</code></pre>


<h3 id="3-plug-in-your-plugins">3.  Plug in your plugins.</h3>


<p>Now throw them wherever you define your static assets in your theme, hopefully in a <code>base.html</code> or <code>header.html</code>:</p>


<pre><code>{% assets filters="scss,cssmin", output="css/main.css", "css/main.scss", "css/sortable-tables.css", "css/footnotes.css" %}
    &lt;link rel="stylesheet" href="/{{ ASSET_URL }}"&gt;
{% endassets %}
</code></pre>


<p>A couple things here to note:</p>


<ul>
<li>You can chain filters, like I do by first passing it through <code>scss</code> to compile my SASS and then to <code>cssmin</code> to minify everything.</li>
<li>Most minification/uglification is actually disabled in <code>DEBUG</code> (aka running <code>./develop_server</code>) which is totally great except I didn’t realize it and was super confused as to why it wasn’t working at first.</li>
<li>You only specify one output <sup class="footnote-ref" id="fnref:2"><a href="#fn:2" rel="footnote">2</a></sup> but you can specify an infinite amount of input arguments like I do: those are available within the block as <code>ASSET_URL</code>.</li>
<li>By default, <code>webassets</code> will be reading and writing from the <code>theme</code> folder of the output directory.  If you have your theme set up in a standard way, this is good – items in your <code>static</code> folder will end up there automatically.</li>
</ul>


<h3 id="4-bask-in-the-infinite-glow">4.  Bask in the infinite glow.</h3>


<p>That’s it!  It’s super easy and will considerably lessen the effort of your static asset management.  Hope this helped!</p>


<div class="footnotes">
<hr/>
<ol>
<li id="fn:1">This is actually my one nitpick with the entire process, since you’re generally using webassets at the theme level and not the blog level.  It’s fine for my use case, but sort of icky that you’d have to go through this process to properly use some random theme that uses webassets.
 <a class="footnote-return" href="#fnref:1"><sup>[return]</sup></a></li>
<li id="fn:2">To my understanding, this is unambiguously a good thing: three calls for 100KB worth of data is worse than one call for 100KB worth of data due to the additional latency of each request.
 <a class="footnote-return" href="#fnref:2"><sup>[return]</sup></a></li>
</ol>
</div>
	