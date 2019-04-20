---
title: "Hugo's internal templates, demystified"
Date: 2017-07-02 00:00:00
Tags: ["development","hugo"]
layout: post
---

<p>In my effort to throw a new coat of paint on this site, I was diving into Hugo’s internal templates to see how to improve their builtin pagination.  It was invoked by calling <code>_internal/pagination.html</code>, so I assumed the template was something along the lines of <code>pagination.html</code>.</p>


<p>Turns out all the internal templates are hard-coded in the Hugo library itself, in a <a href="https://github.com/gohugoio/hugo/blob/master/tpl/tplimpl/template_embedded.go">file named template_embedded.go</a>.  Rather than filing a snarky comment on the wisdom of this approach, I thought it might be helpful to list them out, as it’s definitely annoying to read in the source file.</p>


<p></p>


<h3 id="ref-html">ref.html</h3>


<pre><code>{{ if len .Params | eq 2 }}{{ ref .Page (.Get 0) (.Get 1) }}{{ else }}{{ ref .Page (.Get 0) }}{{ end }}
</code></pre>


<h3 id="relref-html">relref.html</h3>


<pre><code>{{ if len .Params | eq 2 }}{{ relref .Page (.Get 0) (.Get 1) }}{{ else }}{{ relref .Page (.Get 0) }}{{ end }}
</code></pre>


<h3 id="highlight-html">highlight.html</h3>


<pre><code>{{ if len .Params | eq 2 }}{{ highlight .Inner (.Get 0) (.Get 1) }}{{ else }}{{ highlight .Inner (.Get 0) "" }}{{ end }}
</code></pre>


<h3 id="test-html">test.html</h3>


<pre><code>This is a simple Test
</code></pre>


<h3 id="figure-html">figure.html</h3>


<pre><code>&lt;!-- image --&gt;
&lt;figure {{ with .Get "class" }}class="{{.}}"{{ end }}&gt;
    {{ with .Get "link"}}&lt;a href="{{.}}"&gt;{{ end }}
        &lt;img src="{{ .Get "src" }}" {{ if or (.Get "alt") (.Get "caption") }}alt="{{ with .Get "alt"}}{{.}}{{else}}{{ .Get "caption" }}{{ end }}" {{ end }}{{ with .Get "width" }}width="{{.}}" {{ end }}/&gt;
    {{ if .Get "link"}}&lt;/a&gt;{{ end }}
    {{ if or (or (.Get "title") (.Get "caption")) (.Get "attr")}}
    &lt;figcaption&gt;{{ if isset .Params "title" }}
        &lt;h4&gt;{{ .Get "title" }}&lt;/h4&gt;{{ end }}
        {{ if or (.Get "caption") (.Get "attr")}}&lt;p&gt;
        {{ .Get "caption" }}
        {{ with .Get "attrlink"}}&lt;a href="{{.}}"&gt; {{ end }}
            {{ .Get "attr" }}
        {{ if .Get "attrlink"}}&lt;/a&gt; {{ end }}
        &lt;/p&gt; {{ end }}
    &lt;/figcaption&gt;
    {{ end }}
&lt;/figure&gt;
&lt;!-- image --&gt;
</code></pre>


<h3 id="speakerdeck-html">speakerdeck.html</h3>


<pre><code>&lt;script async class='speakerdeck-embed' data-id='{{ index .Params 0 }}' data-ratio='1.33333333333333' src='//speakerdeck.com/assets/embed.js'&gt;&lt;/script&gt;
</code></pre>


<h3 id="youtube-html">youtube.html</h3>


<pre><code>{{ if .IsNamedParams }}
&lt;div {{ if .Get "class" }}class="{{ .Get "class" }}"{{ else }}style="position: relative; padding-bottom: 56.25%; padding-top: 30px; height: 0; overflow: hidden;"{{ end }}&gt;
  &lt;iframe src="//www.youtube.com/embed/{{ .Get "id" }}?{{ with .Get "autoplay" }}{{ if eq . "true" }}autoplay=1{{ end }}{{ end }}" 
  {{ if not (.Get "class") }}style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;" {{ end }}allowfullscreen frameborder="0"&gt;&lt;/iframe&gt;
&lt;/div&gt;{{ else }}
&lt;div {{ if len .Params | eq 2 }}class="{{ .Get 1 }}"{{ else }}style="position: relative; padding-bottom: 56.25%; padding-top: 30px; height: 0; overflow: hidden;"{{ end }}&gt;
  &lt;iframe src="//www.youtube.com/embed/{{ .Get 0 }}" {{ if len .Params | eq 1 }}style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;" {{ end }}allowfullscreen frameborder="0"&gt;&lt;/iframe&gt;
 &lt;/div&gt;
{{ end }}
</code></pre>


<h3 id="vimeo-html">vimeo.html</h3>


<pre><code>{{ if .IsNamedParams }}&lt;div {{ if .Get "class" }}class="{{ .Get "class" }}"{{ else }}style="position: relative; padding-bottom: 56.25%; padding-top: 30px; height: 0; overflow: hidden;"{{ end }}&gt;
  &lt;iframe src="//player.vimeo.com/video/{{ .Get "id" }}" {{ if not (.Get "class") }}style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;" {{ end }}webkitallowfullscreen mozallowfullscreen allowfullscreen&gt;&lt;/iframe&gt;
 &lt;/div&gt;{{ else }}
&lt;div {{ if len .Params | eq 2 }}class="{{ .Get 1 }}"{{ else }}style="position: relative; padding-bottom: 56.25%; padding-top: 30px; height: 0; overflow: hidden;"{{ end }}&gt;
  &lt;iframe src="//player.vimeo.com/video/{{ .Get 0 }}" {{ if len .Params | eq 1 }}style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;" {{ end }}webkitallowfullscreen mozallowfullscreen allowfullscreen&gt;&lt;/iframe&gt;
 &lt;/div&gt;
{{ end }}
</code></pre>


<h3 id="gist-html">gist.html</h3>


<pre><code>&lt;script src="//gist.github.com/{{ index .Params 0 }}/{{ index .Params 1 }}.js{{if len .Params | eq 3 }}?file={{ index .Params 2 }}{{end}}"&gt;&lt;/script&gt;
</code></pre>


<h3 id="tweet-html">tweet.html</h3>


<pre><code>{{ (getJSON "https://api.twitter.com/1/statuses/oembed.json?id=" (index .Params 0)).html | safeHTML }}
</code></pre>


<h3 id="instagram-html">instagram.html</h3>


<pre><code>{{ if len .Params | eq 2 }}{{ if eq (.Get 1) "hidecaption" }}{{ with getJSON "https://api.instagram.com/oembed/?url=https://instagram.com/p/" (index .Params 0) "/&amp;hidecaption=1" }}{{ .html | safeHTML }}{{ end }}{{ end }}{{ else }}{{ with getJSON "https://api.instagram.com/oembed/?url=https://instagram.com/p/" (index .Params 0) "/&amp;hidecaption=0" }}{{ .html | safeHTML }}{{ end }}{{ end }}
</code></pre>


<h3 id="rss-xml">rss.xml</h3>


<pre><code>&lt;rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom"&gt;
  &lt;channel&gt;
    &lt;title&gt;{{ if eq  .Title  .Site.Title }}{{ .Site.Title }}{{ else }}{{ with .Title }}{{.}} on {{ end }}{{ .Site.Title }}{{ end }}&lt;/title&gt;
    &lt;link&gt;{{ .Permalink }}&lt;/link&gt;
    &lt;description&gt;Recent content {{ if ne  .Title  .Site.Title }}{{ with .Title }}in {{.}} {{ end }}{{ end }}on {{ .Site.Title }}&lt;/description&gt;
    &lt;generator&gt;Hugo -- gohugo.io&lt;/generator&gt;{{ with .Site.LanguageCode }}
    &lt;language&gt;{{.}}&lt;/language&gt;{{end}}{{ with .Site.Author.email }}
    &lt;managingEditor&gt;{{.}}{{ with $.Site.Author.name }} ({{.}}){{end}}&lt;/managingEditor&gt;{{end}}{{ with .Site.Author.email }}
    &lt;webMaster&gt;{{.}}{{ with $.Site.Author.name }} ({{.}}){{end}}&lt;/webMaster&gt;{{end}}{{ with .Site.Copyright }}
    &lt;copyright&gt;{{.}}&lt;/copyright&gt;{{end}}{{ if not .Date.IsZero }}
    &lt;lastBuildDate&gt;{{ .Date.Format "Mon, 02 Jan 2006 15:04:05 -0700" | safeHTML }}&lt;/lastBuildDate&gt;{{ end }}
    {{ with .OutputFormats.Get "RSS" }}
	{{ printf "&lt;atom:link href=%q rel=\"self\" type=%q /&gt;" .Permalink .MediaType | safeHTML }}
    {{ end }}
    {{ range .Data.Pages }}
    &lt;item&gt;
      &lt;title&gt;{{ .Title }}&lt;/title&gt;
      &lt;link&gt;{{ .Permalink }}&lt;/link&gt;
      &lt;pubDate&gt;{{ .Date.Format "Mon, 02 Jan 2006 15:04:05 -0700" | safeHTML }}&lt;/pubDate&gt;
      {{ with .Site.Author.email }}&lt;author&gt;{{.}}{{ with $.Site.Author.name }} ({{.}}){{end}}&lt;/author&gt;{{end}}
      &lt;guid&gt;{{ .Permalink }}&lt;/guid&gt;
      &lt;description&gt;{{ .Summary | html }}&lt;/description&gt;
    &lt;/item&gt;
    {{ end }}
  &lt;/channel&gt;
&lt;/rss&gt;
</code></pre>


<h3 id="sitemap-xml">sitemap.xml</h3>


<pre><code>&lt;urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
  xmlns:xhtml="http://www.w3.org/1999/xhtml"&gt;
  {{ range .Data.Pages }}
  &lt;url&gt;
    &lt;loc&gt;{{ .Permalink }}&lt;/loc&gt;{{ if not .Lastmod.IsZero }}
    &lt;lastmod&gt;{{ safeHTML ( .Lastmod.Format "2006-01-02T15:04:05-07:00" ) }}&lt;/lastmod&gt;{{ end }}{{ with .Sitemap.ChangeFreq }}
    &lt;changefreq&gt;{{ . }}&lt;/changefreq&gt;{{ end }}{{ if ge .Sitemap.Priority 0.0 }}
    &lt;priority&gt;{{ .Sitemap.Priority }}&lt;/priority&gt;{{ end }}{{ if .IsTranslated }}{{ range .Translations }}
    &lt;xhtml:link
                rel="alternate"
                hreflang="{{ .Lang }}"
                href="{{ .Permalink }}"
                /&gt;{{ end }}
    &lt;xhtml:link
                rel="alternate"
                hreflang="{{ .Lang }}"
                href="{{ .Permalink }}"
                /&gt;{{ end }}
  &lt;/url&gt;
  {{ end }}
&lt;/urlset&gt;
</code></pre>


<h3 id="sitemapindex-xml">sitemapindex.xml</h3>


<pre><code>&lt;sitemapindex xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"&gt;
	{{ range . }}
	&lt;sitemap&gt;
	   	&lt;loc&gt;{{ .SitemapAbsURL }}&lt;/loc&gt;
		{{ if not .LastChange.IsZero }}
	   	&lt;lastmod&gt;{{ .LastChange.Format "2006-01-02T15:04:05-07:00" | safeHTML }}&lt;/lastmod&gt;
		{{ end }}
	&lt;/sitemap&gt;
	{{ end }}
&lt;/sitemapindex&gt;
</code></pre>


<h3 id="pagination-html">pagination.html</h3>


<pre><code>{{ $pag := $.Paginator }}
{{ if gt $pag.TotalPages 1 }}
&lt;ul class="pagination"&gt;
    {{ with $pag.First }}
    &lt;li&gt;
        &lt;a href="{{ .URL }}" aria-label="First"&gt;&lt;span aria-hidden="true"&gt;&amp;laquo;&amp;laquo;&lt;/span&gt;&lt;/a&gt;
    &lt;/li&gt;
    {{ end }}
    &lt;li
    {{ if not $pag.HasPrev }}class="disabled"{{ end }}&gt;
    &lt;a href="{{ if $pag.HasPrev }}{{ $pag.Prev.URL }}{{ end }}" aria-label="Previous"&gt;&lt;span aria-hidden="true"&gt;&amp;laquo;&lt;/span&gt;&lt;/a&gt;
    &lt;/li&gt;
    {{ $.Scratch.Set "__paginator.ellipsed" false }}
    {{ range $pag.Pagers }}
    {{ $right := sub .TotalPages .PageNumber }}
    {{ $showNumber := or (le .PageNumber 3) (eq $right 0) }}
    {{ $showNumber := or $showNumber (and (gt .PageNumber (sub $pag.PageNumber 2)) (lt .PageNumber (add $pag.PageNumber 2)))  }}
    {{ if $showNumber }} 
        {{ $.Scratch.Set "__paginator.ellipsed" false }}
        {{ $.Scratch.Set "__paginator.shouldEllipse" false }}
    {{ else }}
        {{ $.Scratch.Set "__paginator.shouldEllipse" (not ($.Scratch.Get "__paginator.ellipsed") ) }}
        {{ $.Scratch.Set "__paginator.ellipsed" true }}
    {{ end }}
    {{ if $showNumber }}
    &lt;li
    {{ if eq . $pag }}class="active"{{ end }}&gt;&lt;a href="{{ .URL }}"&gt;{{ .PageNumber }}&lt;/a&gt;&lt;/li&gt;
    {{ else if ($.Scratch.Get "__paginator.shouldEllipse") }}
    &lt;li class="disabled"&gt;&lt;span aria-hidden="true"&gt;&amp;hellip;&lt;/span&gt;&lt;/li&gt;
    {{ end }}
    {{ end }}
    &lt;li
    {{ if not $pag.HasNext }}class="disabled"{{ end }}&gt;
    &lt;a href="{{ if $pag.HasNext }}{{ $pag.Next.URL }}{{ end }}" aria-label="Next"&gt;&lt;span aria-hidden="true"&gt;&amp;raquo;&lt;/span&gt;&lt;/a&gt;
    &lt;/li&gt;
    {{ with $pag.Last }}
    &lt;li&gt;
        &lt;a href="{{ .URL }}" aria-label="Last"&gt;&lt;span aria-hidden="true"&gt;&amp;raquo;&amp;raquo;&lt;/span&gt;&lt;/a&gt;
    &lt;/li&gt;
    {{ end }}
&lt;/ul&gt;
{{ end }}
</code></pre>


<h3 id="disqus-html">disqus.html</h3>


<pre><code>{{ if .Site.DisqusShortname }}&lt;div id="disqus_thread"&gt;&lt;/div&gt;
&lt;script&gt;
    var disqus_config = function () {
    {{with .GetParam "disqus_identifier" }}this.page.identifier = '{{ . }}';{{end}}
    {{with .GetParam "disqus_title" }}this.page.title = '{{ . }}';{{end}}
    {{with .GetParam "disqus_url" }}this.page.url = '{{ . | html  }}';{{end}}
    };
    (function() {
        if (["localhost", "127.0.0.1"].indexOf(window.location.hostname) != -1) {
            document.getElementById('disqus_thread').innerHTML = 'Disqus comments not available by default when the website is previewed locally.';
            return;
        }
        var d = document, s = d.createElement('script'); s.async = true;
        s.src = '//' + {{ .Site.DisqusShortname }} + '.disqus.com/embed.js';
        s.setAttribute('data-timestamp', +new Date());
        (d.head || d.body).appendChild(s);
    })();
&lt;/script&gt;
&lt;noscript&gt;Please enable JavaScript to view the &lt;a href="http://disqus.com/?ref_noscript"&gt;comments powered by Disqus.&lt;/a&gt;&lt;/noscript&gt;
&lt;a href="http://disqus.com" class="dsq-brlink"&gt;comments powered by &lt;span class="logo-disqus"&gt;Disqus&lt;/span&gt;&lt;/a&gt;{{end}}
</code></pre>


<h3 id="opengraph-html">opengraph.html</h3>


<pre><code>&lt;meta property="og:title" content="{{ .Title }}" /&gt;
&lt;meta property="og:description" content="{{ with .Description }}{{ . }}{{ else }}{{if .IsPage}}{{ .Summary }}{{ else }}{{ with .Site.Params.description }}{{ . }}{{ end }}{{ end }}{{ end }}" /&gt;
&lt;meta property="og:type" content="{{ if .IsPage }}article{{ else }}website{{ end }}" /&gt;
&lt;meta property="og:url" content="{{ .Permalink }}" /&gt;
{{ with .Params.images }}{{ range first 6 . }}
  &lt;meta property="og:image" content="{{ . | absURL }}" /&gt;
{{ end }}{{ end }}
{{ if .IsPage }}
{{ if not .PublishDate.IsZero }}&lt;meta property="article:published_time" content="{{ .PublishDate.Format "2006-01-02T15:04:05-07:00" | safeHTML }}"/&gt;
{{ else if not .Date.IsZero }}&lt;meta property="article:published_time" content="{{ .Date.Format "2006-01-02T15:04:05-07:00" | safeHTML }}"/&gt;{{ end }}
{{ if not .Lastmod.IsZero }}&lt;meta property="article:modified_time" content="{{ .Lastmod.Format "2006-01-02T15:04:05-07:00" | safeHTML }}"/&gt;{{ end }}
{{ else }}
{{ if not .Date.IsZero }}&lt;meta property="og:updated_time" content="{{ .Date.Format "2006-01-02T15:04:05-07:00" | safeHTML }}"/&gt;{{ end }}
{{ end }}{{ with .Params.audio }}
&lt;meta property="og:audio" content="{{ . }}" /&gt;{{ end }}{{ with .Params.locale }}
&lt;meta property="og:locale" content="{{ . }}" /&gt;{{ end }}{{ with .Site.Params.title }}
&lt;meta property="og:site_name" content="{{ . }}" /&gt;{{ end }}{{ with .Params.videos }}
{{ range .Params.videos }}
  &lt;meta property="og:video" content="{{ . | absURL }}" /&gt;
{{ end }}{{ end }}
&lt;!-- If it is part of a series, link to related articles --&gt;
{{ $permalink := .Permalink }}
{{ $siteSeries := .Site.Taxonomies.series }}{{ with .Params.series }}
{{ range $name := . }}
  {{ $series := index $siteSeries $name }}
  {{ range $page := first 6 $series.Pages }}
    {{ if ne $page.Permalink $permalink }}&lt;meta property="og:see_also" content="{{ $page.Permalink }}" /&gt;{{ end }}
  {{ end }}
{{ end }}{{ end }}
{{ if .IsPage }}
{{ range .Site.Authors }}{{ with .Social.facebook }}
&lt;meta property="article:author" content="https://www.facebook.com/{{ . }}" /&gt;{{ end }}{{ with .Site.Social.facebook }}
&lt;meta property="article:publisher" content="https://www.facebook.com/{{ . }}" /&gt;{{ end }}
&lt;meta property="article:section" content="{{ .Section }}" /&gt;
{{ with .Params.tags }}{{ range first 6 . }}
  &lt;meta property="article:tag" content="{{ . }}" /&gt;{{ end }}{{ end }}
{{ end }}{{ end }}
&lt;!-- Facebook Page Admin ID for Domain Insights --&gt;
{{ with .Site.Social.facebook_admin }}&lt;meta property="fb:admins" content="{{ . }}" /&gt;{{ end }}
</code></pre>


<h3 id="twitter-cards-html">twitter_cards.html</h3>


<pre><code>{{ if .IsPage }}
{{ with .Params.images }}
&lt;!-- Twitter summary card with large image must be at least 280x150px --&gt;
  &lt;meta name="twitter:card" content="summary_large_image"/&gt;
  &lt;meta name="twitter:image:src" content="{{ index . 0 | absURL }}"/&gt;
{{ else }}
  &lt;meta name="twitter:card" content="summary"/&gt;
{{ end }}
&lt;!-- Twitter Card data --&gt;
&lt;meta name="twitter:text:title" content="{{ .Title }}"/&gt;
&lt;meta name="twitter:title" content="{{ .Title }}"/&gt;
&lt;meta name="twitter:description" content="{{ with .Description }}{{ . }}{{ else }}{{if .IsPage}}{{ .Summary }}{{ else }}{{ with .Site.Params.description }}{{ . }}{{ end }}{{ end }}{{ end }}"/&gt;
{{ with .Site.Social.twitter }}&lt;meta name="twitter:site" content="@{{ . }}"/&gt;{{ end }}
{{ range .Site.Authors }}
  {{ with .twitter }}&lt;meta name="twitter:creator" content="@{{ . }}"/&gt;{{ end }}
{{ end }}{{ end }}
</code></pre>


<h3 id="google-news-html">google_news.html</h3>


<pre><code>{{ if .IsPage }}{{ with .Params.news_keywords }}
  &lt;meta name="news_keywords" content="{{ range $i, $kw := first 10 . }}{{ if $i }},{{ end }}{{ $kw }}{{ end }}" /&gt;
{{ end }}{{ end }}
</code></pre>


<h3 id="schema-html">schema.html</h3>


<pre><code>{{ with .Site.Social.GooglePlus }}&lt;link rel="publisher" href="{{ . }}"/&gt;{{ end }}
&lt;meta itemprop="name" content="{{ .Title }}"&gt;
&lt;meta itemprop="description" content="{{ with .Description }}{{ . }}{{ else }}{{if .IsPage}}{{ .Summary }}{{ else }}{{ with .Site.Params.description }}{{ . }}{{ end }}{{ end }}{{ end }}"&gt;
{{if .IsPage}}{{ $ISO8601 := "2006-01-02T15:04:05-07:00" }}{{ if not .PublishDate.IsZero }}
&lt;meta itemprop="datePublished" content="{{ .PublishDate.Format $ISO8601 | safeHTML }}" /&gt;{{ end }}
{{ if not .Date.IsZero }}&lt;meta itemprop="dateModified" content="{{ .Date.Format $ISO8601 | safeHTML }}" /&gt;{{ end }}
&lt;meta itemprop="wordCount" content="{{ .WordCount }}"&gt;
{{ with .Params.images }}{{ range first 6 . }}
  &lt;meta itemprop="image" content="{{ . | absURL }}"&gt;
{{ end }}{{ end }}
&lt;!-- Output all taxonomies as schema.org keywords --&gt;
&lt;meta itemprop="keywords" content="{{ if .IsPage}}{{ range $index, $tag := .Params.tags }}{{ $tag }},{{ end }}{{ else }}{{ range $plural, $terms := .Site.Taxonomies }}{{ range $term, $val := $terms }}{{ printf "%s," $term }}{{ end }}{{ end }}{{ end }}" /&gt;
{{ end }}
</code></pre>


<h3 id="google-analytics-html">google_analytics.html</h3>


<pre><code>{{ with .Site.GoogleAnalytics }}
&lt;script&gt;
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','https://www.google-analytics.com/analytics.js','ga');
ga('create', '{{ . }}', 'auto');
ga('send', 'pageview');
&lt;/script&gt;
{{ end }}
</code></pre>


<h3 id="robots-txt">robots.txt</h3>


<pre><code>User-agent: x
</code></pre>
	