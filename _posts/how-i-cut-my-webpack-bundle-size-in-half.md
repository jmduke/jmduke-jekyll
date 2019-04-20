---
title: "How I cut my Webpack bundle size in half"
Date: 2017-09-16 00:00:00
Tags: ["development","webpack"]
layout: post
---

<p><link href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.9.0/styles/github.min.css" rel="stylesheet"/>
<style>
.post h2 {
    font-size: 18px;
}
.post h3 {
    font-size: 16px;
}
figcaption {
    margin-bottom: 2em;
}
img {
    width: 100%;
}
#bordered {
    width: 100%;
    border: 1px #ccc solid;
    border-radius: 5px;
}
p &gt; img {
    margin-bottom: -1em;
}
.d2h-wrapper{text-align:left}.d2h-file-header{padding:5px 10px;border-bottom:1px solid #d8d8d8;background-color:#f7f7f7}.d2h-file-stats{display:-webkit-box;display:-ms-flexbox;display:flex;margin-left:auto;font-size:14px}.d2h-lines-added{text-align:right;border:1px solid #b4e2b4;border-radius:5px 0 0 5px;color:#399839;padding:2px;vertical-align:middle}.d2h-lines-deleted{text-align:left;border:1px solid #e9aeae;border-radius:0 5px 5px 0;color:#c33;padding:2px;vertical-align:middle;margin-left:1px}.d2h-file-name-wrapper{display:-webkit-box;display:-ms-flexbox;display:flex;-webkit-box-align:center;-ms-flex-align:center;align-items:center;width:100%;font-family:&ldquo;Source Sans Pro&rdquo;,&ldquo;Helvetica Neue&rdquo;,Helvetica,Arial,sans-serif;font-size:15px}.d2h-file-name{white-space:nowrap;text-overflow:ellipsis;overflow-x:hidden;line-height:21px}.d2h-file-wrapper{border:1px solid #ddd;border-radius:3px;margin-bottom:1em}.d2h-diff-table{width:100%;border-collapse:collapse;font-family:Menlo,Consolas,monospace;font-size:13px}.d2h-diff-tbody&gt;tr&gt;td{height:20px;line-height:20px}.d2h-files-diff{display:block;width:100%;height:100%}.d2h-file-diff{overflow-x:scroll;overflow-y:hidden}.d2h-file-side-diff{display:inline-block;overflow-x:scroll;overflow-y:hidden;width:50%;margin-right:-4px;margin-bottom:-8px}.d2h-code-line{display:inline-block;white-space:nowrap;padding:0 10px;margin-left:80px}.d2h-code-side-line{display:inline-block;white-space:nowrap;padding:0 10px;margin-left:50px}.d2h-code-line del,.d2h-code-side-line del{display:inline-block;margin-top:-1px;text-decoration:none;background-color:#ffb6ba;border-radius:.2em}.d2h-code-line ins,.d2h-code-side-line ins{display:inline-block;margin-top:-1px;text-decoration:none;background-color:#97f295;border-radius:.2em;text-align:left}.d2h-code-line-prefix{display:inline;background:0 0;padding:0;word-wrap:normal;white-space:pre}.d2h-code-line-ctn{display:inline;background:0 0;padding:0;word-wrap:normal;white-space:pre}.line-num1{box-sizing:border-box;float:left;width:40px;overflow:hidden;text-overflow:ellipsis;padding-left:3px}.line-num2{box-sizing:border-box;float:right;width:40px;overflow:hidden;text-overflow:ellipsis;padding-left:3px}.d2h-code-linenumber{box-sizing:border-box;position:absolute;width:86px;padding-left:2px;padding-right:2px;background-color:#fff;color:rgba(0,0,0,.3);text-align:right;border:solid #eee;border-width:0 1px 0 1px;cursor:pointer}.d2h-code-side-linenumber{box-sizing:border-box;position:absolute;width:56px;padding-left:5px;padding-right:5px;background-color:#fff;color:rgba(0,0,0,.3);text-align:right;border:solid #eee;border-width:0 1px 0 1px;cursor:pointer;overflow:hidden;text-overflow:ellipsis}.d2h-del{background-color:#fee8e9;border-color:#e9aeae}.d2h-ins{background-color:#dfd;border-color:#b4e2b4}.d2h-info{background-color:#f8fafd;color:rgba(0,0,0,.3);border-color:#d5e4f2}.d2h-file-diff .d2h-del.d2h-change{background-color:#fdf2d0}.d2h-file-diff .d2h-ins.d2h-change{background-color:#ded}.d2h-file-list-wrapper{margin-bottom:10px}.d2h-file-list-wrapper a{text-decoration:none;color:#3572b0}.d2h-file-list-wrapper a:visited{color:#3572b0}.d2h-file-list-header{text-align:left}.d2h-file-list-title{font-weight:700}.d2h-file-list-line{display:-webkit-box;display:-ms-flexbox;display:flex;text-align:left;display:none;}.d2h-file-list{display:block;list-style:none;padding:0;margin:0}.d2h-file-list&gt;li{border-bottom:#ddd solid 1px;padding:5px 10px;margin:0}.d2h-file-list&gt;li:last-child{border-bottom:none}.d2h-file-switch{display:none;font-size:10px;cursor:pointer}.d2h-icon-wrapper{line-height:31px}.d2h-icon{vertical-align:middle;margin-right:10px;fill:currentColor}.d2h-deleted{color:#c33}.d2h-added{color:#399839}.d2h-changed{color:#d0b44c}.d2h-moved{color:#3572b0}.d2h-tag{display:-webkit-box;display:-ms-flexbox;display:flex;font-size:10px;margin-left:5px;padding:0 2px;background-color:#fff}.d2h-deleted-tag{border:#c33 1px solid}.d2h-added-tag{border:#399839 1px solid}.d2h-changed-tag{border:#d0b44c 1px solid}.d2h-moved-tag{border:#3572b0 1px solid}.selecting-left .d2h-code-line,.selecting-left .d2h-code-line *,.selecting-left .d2h-code-side-line,.selecting-left .d2h-code-side-line *,.selecting-right td.d2h-code-linenumber,.selecting-right td.d2h-code-linenumber *,.selecting-right td.d2h-code-side-linenumber,.selecting-right td.d2h-code-side-linenumber *{-webkit-touch-callout:none;-webkit-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none}.selecting-left .d2h-code-line ::-moz-selection,.selecting-left .d2h-code-line::-moz-selection,.selecting-left .d2h-code-side-line ::-moz-selection,.selecting-left .d2h-code-side-line::-moz-selection,.selecting-right td.d2h-code-linenumber::-moz-selection,.selecting-right td.d2h-code-side-linenumber ::-moz-selection,.selecting-right td.d2h-code-side-linenumber::-moz-selection{background:0 0}.selecting-left .d2h-code-line ::selection,.selecting-left .d2h-code-line::selection,.selecting-left .d2h-code-side-line ::selection,.selecting-left .d2h-code-side-line::selection,.selecting-right td.d2h-code-linenumber::selection,.selecting-right td.d2h-code-side-linenumber ::selection,.selecting-right td.d2h-code-side-linenumber::selection{background:0 0}
</style></p>


<blockquote>
<p>In the fall, a young man’s fancy lightly turns to thoughts of front-end performance.</p>
</blockquote>


<p>When I initially built out <a href="http://buttondown.email">Buttondown</a>, I was focused on two aspects above all else:</p>


<ol>
<li>It being built quickly.</li>
<li>It working reasonably well.</li>
</ol>


<p>Notably excluded from that list is <em>performance</em>.  Buttondown isn’t a slow app, but it is a heavy one: the bundle size while developing is measured in megabytes, and there’s a non-trivial loading time for first-time users.</p>


<p>Now that the core feature base has stabilized and nothing is particularly in an “on fire” state, I wanted to turn my eye towards maintenance work, and a big piece of that was seeing what I could do to shrink that bundle.</p>


<p></p>

<!--more-->


<p><img alt="" src="https://media.giphy.com/media/KPtSLVJfug7DO/giphy.gif"/>
<figcaption>Dramatization of Buttondown delivering its webpack bundle to hapless browsers.  The bread is delicious, delicious JavaScript.</figcaption></p>


<p>So, yeah.  A hair under four megabytes.  Sure, that’s unminified and unuglified, but it’s way too large for an app of Buttondown’s size.  I resolved to cut that size in half, and here’s how: a combination of best practices and common sense front-end principles that I really should have adopted from the start.</p>


<h2 id="0-analyzing-the-bundle">0. Analyzing the Bundle</h2>


<p>I knew the bundle was big, but I didn’t really know <em>why</em> it was big.  Thankfully, there’s a tool for that! <a href="https://www.npmjs.com/package/webpack-bundle-analyzer">webpack-bundle-analyzer</a> analyzes your webpack stats and spits out a tree-map visualizing what’s taking up so much space:</p>


<h3 id="what-the-bundle-looks-like">What the bundle looks like</h3>


<p><img alt="" src="https://pbs.twimg.com/media/DJFG3rEVwAALcnL.png"/>
<figcaption>Yeesh.</figcaption></p>


<h2 id="1-ditch-jquery">1. Ditch jQuery</h2>


<p>“Do you really need jQuery” is such a common question that it <a href="http://youmightnotneedjquery.com/">has its own site</a>, and in this case the answer was, uh, no.  Especially because Vue makes it exceptionally easy to capture events and reference the DOM, which were the only two things I was actually using it for.  Here’s what the diff looks like:</p>


<div id="diff">
<div class="d2h-file-list-wrapper">
<ol class="d2h-file-list">
<li class="d2h-file-list-line">
<span class="d2h-file-name-wrapper">
<span><svg aria-hidden="true" class="d2h-icon d2h-changed" height="16" title="modified" version="1.1" viewbox="0 0 14 16" width="14">
<path d="M13 1H1C0.45 1 0 1.45 0 2v12c0 0.55 0.45 1 1 1h12c0.55 0 1-0.45 1-1V2c0-0.55-0.45-1-1-1z m0 13H1V2h12v12zM4 8c0-1.66 1.34-3 3-3s3 1.34 3 3-1.34 3-3 3-3-1.34-3-3z"></path>
</svg></span>
<a class="d2h-file-name" href="#d2h-484953">.eslintrc.js</a>
<span class="d2h-file-stats">
<span class="d2h-lines-added">+0</span>
<span class="d2h-lines-deleted">-1</span>
</span>
</span>
</li>
<li class="d2h-file-list-line">
<span class="d2h-file-name-wrapper">
<span><svg aria-hidden="true" class="d2h-icon d2h-changed" height="16" title="modified" version="1.1" viewbox="0 0 14 16" width="14">
<path d="M13 1H1C0.45 1 0 1.45 0 2v12c0 0.55 0.45 1 1 1h12c0.55 0 1-0.45 1-1V2c0-0.55-0.45-1-1-1z m0 13H1V2h12v12zM4 8c0-1.66 1.34-3 3-3s3 1.34 3 3-1.34 3-3 3-3-1.34-3-3z"></path>
</svg></span>
<a class="d2h-file-name" href="#d2h-885678">assets/components/DraftBody.vue</a>
<span class="d2h-file-stats">
<span class="d2h-lines-added">+5</span>
<span class="d2h-lines-deleted">-9</span>
</span>
</span>
</li>
<li class="d2h-file-list-line">
<span class="d2h-file-name-wrapper">
<span><svg aria-hidden="true" class="d2h-icon d2h-changed" height="16" title="modified" version="1.1" viewbox="0 0 14 16" width="14">
<path d="M13 1H1C0.45 1 0 1.45 0 2v12c0 0.55 0.45 1 1 1h12c0.55 0 1-0.45 1-1V2c0-0.55-0.45-1-1-1z m0 13H1V2h12v12zM4 8c0-1.66 1.34-3 3-3s3 1.34 3 3-1.34 3-3 3-3-1.34-3-3z"></path>
</svg></span>
<a class="d2h-file-name" href="#d2h-744963">assets/screens/Share.vue</a>
<span class="d2h-file-stats">
<span class="d2h-lines-added">+2</span>
<span class="d2h-lines-deleted">-2</span>
</span>
</span>
</li>
<li class="d2h-file-list-line">
<span class="d2h-file-name-wrapper">
<span><svg aria-hidden="true" class="d2h-icon d2h-changed" height="16" title="modified" version="1.1" viewbox="0 0 14 16" width="14">
<path d="M13 1H1C0.45 1 0 1.45 0 2v12c0 0.55 0.45 1 1 1h12c0.55 0 1-0.45 1-1V2c0-0.55-0.45-1-1-1z m0 13H1V2h12v12zM4 8c0-1.66 1.34-3 3-3s3 1.34 3 3-1.34 3-3 3-3-1.34-3-3z"></path>
</svg></span>
<a class="d2h-file-name" href="#d2h-519664">package.json</a>
<span class="d2h-file-stats">
<span class="d2h-lines-added">+0</span>
<span class="d2h-lines-deleted">-1</span>
</span>
</span>
</li>
<li class="d2h-file-list-line">
<span class="d2h-file-name-wrapper">
<span><svg aria-hidden="true" class="d2h-icon d2h-changed" height="16" title="modified" version="1.1" viewbox="0 0 14 16" width="14">
<path d="M13 1H1C0.45 1 0 1.45 0 2v12c0 0.55 0.45 1 1 1h12c0.55 0 1-0.45 1-1V2c0-0.55-0.45-1-1-1z m0 13H1V2h12v12zM4 8c0-1.66 1.34-3 3-3s3 1.34 3 3-1.34 3-3 3-3-1.34-3-3z"></path>
</svg></span>
<a class="d2h-file-name" href="#d2h-534156">webpack.config.js</a>
<span class="d2h-file-stats">
<span class="d2h-lines-added">+0</span>
<span class="d2h-lines-deleted">-4</span>
</span>
</span>
</li>
</ol>
</div><div class="d2h-wrapper">
<div class="d2h-file-wrapper" data-lang="js" id="d2h-484953">
<div class="d2h-file-header">
<span class="d2h-file-name-wrapper">
<span class="d2h-icon-wrapper"><svg aria-hidden="true" class="d2h-icon" height="16" version="1.1" viewbox="0 0 12 16" width="12">
<path d="M6 5H2v-1h4v1zM2 8h7v-1H2v1z m0 2h7v-1H2v1z m0 2h7v-1H2v1z m10-7.5v9.5c0 0.55-0.45 1-1 1H1c-0.55 0-1-0.45-1-1V2c0-0.55 0.45-1 1-1h7.5l3.5 3.5z m-1 0.5L8 2H1v12h10V5z"></path>
</svg></span>
<span class="d2h-file-name">.eslintrc.js</span>
<span class="d2h-tag d2h-changed d2h-changed-tag">CHANGED</span></span>
</div>
<div class="d2h-file-diff">
<div class="d2h-code-wrapper">
<table class="d2h-diff-table">
<tbody class="d2h-diff-tbody">
<tr>
<td class="d2h-code-linenumber d2h-info"></td>
<td class="d2h-info">
<div class="d2h-code-line d2h-info">@@ -17,7 +17,6 @@ module.exports = {</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">17</div>
<div class="line-num2">17</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">    'Urls': true,</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">18</div>
<div class="line-num2">18</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">    'SITE_URL': true,</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">19</div>
<div class="line-num2">19</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">    'ga': true,</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-del">
<div class="line-num1">20</div>
<div class="line-num2"></div>
</td>
<td class="d2h-del">
<div class="d2h-code-line d2h-del">
<span class="d2h-code-line-prefix">-</span>
<span class="d2h-code-line-ctn">    '<!--diff2html-diff-->$: true,</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">21</div>
<div class="line-num2">20</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">    'StripeCheckout': true,</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">22</div>
<div class="line-num2">21</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">    'STRIPE_PUBLIC_KEY': true,</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">23</div>
<div class="line-num2">22</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">    'amplitude': true,</span>
</div>
</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
<div class="d2h-file-wrapper" data-lang="vue" id="d2h-885678">
<div class="d2h-file-header">
<span class="d2h-file-name-wrapper">
<span class="d2h-icon-wrapper"><svg aria-hidden="true" class="d2h-icon" height="16" version="1.1" viewbox="0 0 12 16" width="12">
<path d="M6 5H2v-1h4v1zM2 8h7v-1H2v1z m0 2h7v-1H2v1z m0 2h7v-1H2v1z m10-7.5v9.5c0 0.55-0.45 1-1 1H1c-0.55 0-1-0.45-1-1V2c0-0.55 0.45-1 1-1h7.5l3.5 3.5z m-1 0.5L8 2H1v12h10V5z"></path>
</svg></span>
<span class="d2h-file-name">assets/components/DraftBody.vue</span>
<span class="d2h-tag d2h-changed d2h-changed-tag">CHANGED</span></span>
</div>
<div class="d2h-file-diff">
<div class="d2h-code-wrapper">
<table class="d2h-diff-table">
<tbody class="d2h-diff-tbody">
<tr>
<td class="d2h-code-linenumber d2h-info"></td>
<td class="d2h-info">
<div class="d2h-code-line d2h-info">@@ -19,6 +19,7 @@</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">19</div>
<div class="line-num2">19</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">      @scroll="handleTextAreaScroll"</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">20</div>
<div class="line-num2">20</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">      @mouseup="handleTextAreaResize"</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">21</div>
<div class="line-num2">21</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">      v-model="body"</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-ins">
<div class="line-num1"></div>
<div class="line-num2">22</div>
</td>
<td class="d2h-ins">
<div class="d2h-code-line d2h-ins">
<span class="d2h-code-line-prefix">+</span>
<span class="d2h-code-line-ctn">      ref="input"</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">22</div>
<div class="line-num2">23</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">    /&gt;</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">23</div>
<div class="line-num2">24</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">      &lt;div</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">24</div>
<div class="line-num2">25</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">        :class="{</span>
</div>
</td>
</tr>
<tr>
<td class="d2h-code-linenumber d2h-info"></td>
<td class="d2h-info">
<div class="d2h-code-line d2h-info">@@ -37,6 +38,7 @@</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">37</div>
<div class="line-num2">38</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">        :class="{'hidden': !showMarkdownPreview}"</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">38</div>
<div class="line-num2">39</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">        @scroll="handlePreviewScroll"</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">39</div>
<div class="line-num2">40</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">        v-html="compiledBody"</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-ins">
<div class="line-num1"></div>
<div class="line-num2">41</div>
</td>
<td class="d2h-ins">
<div class="d2h-code-line d2h-ins">
<span class="d2h-code-line-prefix">+</span>
<span class="d2h-code-line-ctn">        ref="preview"</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">40</div>
<div class="line-num2">42</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">      /&gt;</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">41</div>
<div class="line-num2">43</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">    &lt;/div&gt;</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">42</div>
<div class="line-num2">44</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">  &lt;/div&gt;</span>
</div>
</td>
</tr>
<tr>
<td class="d2h-code-linenumber d2h-info"></td>
<td class="d2h-info">
<div class="d2h-code-line d2h-info">@@ -78,21 +80,15 @@</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">78</div>
<div class="line-num2">80</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">79</div>
<div class="line-num2">81</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">    methods: {</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">80</div>
<div class="line-num2">82</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">      handleTextAreaScroll() {</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-del">
<div class="line-num1">81</div>
<div class="line-num2"></div>
</td>
<td class="d2h-del">
<div class="d2h-code-line d2h-del">
<span class="d2h-code-line-prefix">-</span>
<span class="d2h-code-line-ctn"> <del>const</del> <del>$textarea </del>= <del>$('.draft-body__input');</del></span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-ins">
<div class="line-num1"></div>
<div class="line-num2">83</div>
</td>
<td class="d2h-ins">
<div class="d2h-code-line d2h-ins">
<span class="d2h-code-line-prefix">+</span>
<span class="d2h-code-line-ctn"> <ins>this.$refs.preview.scrollTop</ins> = <ins>this.$refs.input.scrollTop;</ins></span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-del">
<div class="line-num1">82</div>
<div class="line-num2"></div>
</td>
<td class="d2h-del">
<div class="d2h-code-line d2h-del">
<span class="d2h-code-line-prefix">-</span>
<span class="d2h-code-line-ctn">        const $preview = $('.draft-body__preview');</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-del">
<div class="line-num1">83</div>
<div class="line-num2"></div>
</td>
<td class="d2h-del">
<div class="d2h-code-line d2h-del">
<span class="d2h-code-line-prefix">-</span>
<span class="d2h-code-line-ctn">        $preview.scrollTop($textarea.scrollTop());</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">84</div>
<div class="line-num2">84</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">      },</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">85</div>
<div class="line-num2">85</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">86</div>
<div class="line-num2">86</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">      handlePreviewScroll() {</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-del">
<div class="line-num1">87</div>
<div class="line-num2"></div>
</td>
<td class="d2h-del">
<div class="d2h-code-line d2h-del">
<span class="d2h-code-line-prefix">-</span>
<span class="d2h-code-line-ctn"> <del>const</del> <del>$textarea </del>= <del>$('.draft-body__input');</del></span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-ins">
<div class="line-num1"></div>
<div class="line-num2">87</div>
</td>
<td class="d2h-ins">
<div class="d2h-code-line d2h-ins">
<span class="d2h-code-line-prefix">+</span>
<span class="d2h-code-line-ctn"> <ins>this.$refs.input.scrollTop</ins> = <ins>this.$refs.preview.scrollTop;</ins></span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-del">
<div class="line-num1">88</div>
<div class="line-num2"></div>
</td>
<td class="d2h-del">
<div class="d2h-code-line d2h-del">
<span class="d2h-code-line-prefix">-</span>
<span class="d2h-code-line-ctn">        const $preview = $('.draft-body__preview');</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-del">
<div class="line-num1">89</div>
<div class="line-num2"></div>
</td>
<td class="d2h-del">
<div class="d2h-code-line d2h-del">
<span class="d2h-code-line-prefix">-</span>
<span class="d2h-code-line-ctn">        $textarea.scrollTop($preview.scrollTop());</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">90</div>
<div class="line-num2">88</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">      },</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">91</div>
<div class="line-num2">89</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">92</div>
<div class="line-num2">90</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">      handleTextAreaResize() {</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-del">
<div class="line-num1">93</div>
<div class="line-num2"></div>
</td>
<td class="d2h-del">
<div class="d2h-code-line d2h-del">
<span class="d2h-code-line-prefix">-</span>
<span class="d2h-code-line-ctn"> <del>const</del> <del>$textarea </del>= <del>$('.draft-body__input');</del></span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-ins">
<div class="line-num1"></div>
<div class="line-num2">91</div>
</td>
<td class="d2h-ins">
<div class="d2h-code-line d2h-ins">
<span class="d2h-code-line-prefix">+</span>
<span class="d2h-code-line-ctn"> <ins>this.$refs.preview.style.height</ins> = <ins>this.$refs.input.offsetHeight;</ins></span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-del">
<div class="line-num1">94</div>
<div class="line-num2"></div>
</td>
<td class="d2h-del">
<div class="d2h-code-line d2h-del">
<span class="d2h-code-line-prefix">-</span>
<span class="d2h-code-line-ctn">        const $preview = $('.draft-body__preview');</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-del">
<div class="line-num1">95</div>
<div class="line-num2"></div>
</td>
<td class="d2h-del">
<div class="d2h-code-line d2h-del">
<span class="d2h-code-line-prefix">-</span>
<span class="d2h-code-line-ctn">        $preview.height($textarea.height());</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">96</div>
<div class="line-num2">92</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">      },</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">97</div>
<div class="line-num2">93</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">98</div>
<div class="line-num2">94</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">      startDrag(e) {</span>
</div>
</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
<div class="d2h-file-wrapper" data-lang="vue" id="d2h-744963">
<div class="d2h-file-header">
<span class="d2h-file-name-wrapper">
<span class="d2h-icon-wrapper"><svg aria-hidden="true" class="d2h-icon" height="16" version="1.1" viewbox="0 0 12 16" width="12">
<path d="M6 5H2v-1h4v1zM2 8h7v-1H2v1z m0 2h7v-1H2v1z m0 2h7v-1H2v1z m10-7.5v9.5c0 0.55-0.45 1-1 1H1c-0.55 0-1-0.45-1-1V2c0-0.55 0.45-1 1-1h7.5l3.5 3.5z m-1 0.5L8 2H1v12h10V5z"></path>
</svg></span>
<span class="d2h-file-name">assets/screens/Share.vue</span>
<span class="d2h-tag d2h-changed d2h-changed-tag">CHANGED</span></span>
</div>
<div class="d2h-file-diff">
<div class="d2h-code-wrapper">
<table class="d2h-diff-table">
<tbody class="d2h-diff-tbody">
<tr>
<td class="d2h-code-linenumber d2h-info"></td>
<td class="d2h-info">
<div class="d2h-code-line d2h-info">@@ -26,7 +26,7 @@</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">26</div>
<div class="line-num2">26</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">            action="https://jsfiddle.net/api/post/library/pure/"</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">27</div>
<div class="line-num2">27</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">          &gt;</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">28</div>
<div class="line-num2">28</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">            &lt;input type="hidden" name="html" :value="embedCode" /&gt;</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-del">
<div class="line-num1">29</div>
<div class="line-num2"></div>
</td>
<td class="d2h-del">
<div class="d2h-code-line d2h-del">
<span class="d2h-code-line-prefix">-</span>
<span class="d2h-code-line-ctn">            &lt;input style="display: none" type="submit" /&gt;</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-ins">
<div class="line-num1"></div>
<div class="line-num2">29</div>
</td>
<td class="d2h-ins">
<div class="d2h-code-line d2h-ins">
<span class="d2h-code-line-prefix">+</span>
<span class="d2h-code-line-ctn">            &lt;input <ins>id="jsFiddleSubmitButton" </ins>style="display: none" type="submit" /&gt;</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">30</div>
<div class="line-num2">30</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">            &lt;a</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">31</div>
<div class="line-num2">31</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">              class="tiny"</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">32</div>
<div class="line-num2">32</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">              href="#"</span>
</div>
</td>
</tr>
<tr>
<td class="d2h-code-linenumber d2h-info"></td>
<td class="d2h-info">
<div class="d2h-code-line d2h-info">@@ -133,7 +133,7 @@ src="${this.newsletterUrl}?as_embed=true"</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">133</div>
<div class="line-num2">133</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">  },</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">134</div>
<div class="line-num2">134</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">  methods: {</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">135</div>
<div class="line-num2">135</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">    submitForm() {</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-del">
<div class="line-num1">136</div>
<div class="line-num2"></div>
</td>
<td class="d2h-del">
<div class="d2h-code-line d2h-del">
<span class="d2h-code-line-prefix">-</span>
<span class="d2h-code-line-ctn"> <del>$('.jsfiddle-form input[type="submit"]').</del>click();</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-ins">
<div class="line-num1"></div>
<div class="line-num2">136</div>
</td>
<td class="d2h-ins">
<div class="d2h-code-line d2h-ins">
<span class="d2h-code-line-prefix">+</span>
<span class="d2h-code-line-ctn"> <ins>document.getElementById('jsFiddleSubmitButton').</ins>click();</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">137</div>
<div class="line-num2">137</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">    },</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">138</div>
<div class="line-num2">138</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">  },</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">139</div>
<div class="line-num2">139</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">  head: {</span>
</div>
</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
<div class="d2h-file-wrapper" data-lang="json" id="d2h-519664">
<div class="d2h-file-header">
<span class="d2h-file-name-wrapper">
<span class="d2h-icon-wrapper"><svg aria-hidden="true" class="d2h-icon" height="16" version="1.1" viewbox="0 0 12 16" width="12">
<path d="M6 5H2v-1h4v1zM2 8h7v-1H2v1z m0 2h7v-1H2v1z m0 2h7v-1H2v1z m10-7.5v9.5c0 0.55-0.45 1-1 1H1c-0.55 0-1-0.45-1-1V2c0-0.55 0.45-1 1-1h7.5l3.5 3.5z m-1 0.5L8 2H1v12h10V5z"></path>
</svg></span>
<span class="d2h-file-name">package.json</span>
<span class="d2h-tag d2h-changed d2h-changed-tag">CHANGED</span></span>
</div>
<div class="d2h-file-diff">
<div class="d2h-code-wrapper">
<table class="d2h-diff-table">
<tbody class="d2h-diff-tbody">
<tr>
<td class="d2h-code-linenumber d2h-info"></td>
<td class="d2h-info">
<div class="d2h-code-line d2h-info">@@ -69,7 +69,6 @@</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">69</div>
<div class="line-num2">69</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">    "inject-loader": "^2.0.1",</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">70</div>
<div class="line-num2">70</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">    "jest": "^19.0.2",</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">71</div>
<div class="line-num2">71</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">    "jest-vue-preprocessor": "^0.1.3",</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-del">
<div class="line-num1">72</div>
<div class="line-num2"></div>
</td>
<td class="d2h-del">
<div class="d2h-code-line d2h-del">
<span class="d2h-code-line-prefix">-</span>
<span class="d2h-code-line-ctn">    "jquery": "^3.1.1",</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">73</div>
<div class="line-num2">72</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">    "karma": "^1.4.1",</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">74</div>
<div class="line-num2">73</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">    "karma-coverage": "^1.1.1",</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">75</div>
<div class="line-num2">74</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">    "karma-mocha": "^1.3.0",</span>
</div>
</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
<div class="d2h-file-wrapper" data-lang="js" id="d2h-534156">
<div class="d2h-file-header">
<span class="d2h-file-name-wrapper">
<span class="d2h-icon-wrapper"><svg aria-hidden="true" class="d2h-icon" height="16" version="1.1" viewbox="0 0 12 16" width="12">
<path d="M6 5H2v-1h4v1zM2 8h7v-1H2v1z m0 2h7v-1H2v1z m0 2h7v-1H2v1z m10-7.5v9.5c0 0.55-0.45 1-1 1H1c-0.55 0-1-0.45-1-1V2c0-0.55 0.45-1 1-1h7.5l3.5 3.5z m-1 0.5L8 2H1v12h10V5z"></path>
</svg></span>
<span class="d2h-file-name">webpack.config.js</span>
<span class="d2h-tag d2h-changed d2h-changed-tag">CHANGED</span></span>
</div>
<div class="d2h-file-diff">
<div class="d2h-code-wrapper">
<table class="d2h-diff-table">
<tbody class="d2h-diff-tbody">
<tr>
<td class="d2h-code-linenumber d2h-info"></td>
<td class="d2h-info">
<div class="d2h-code-line d2h-info">@@ -65,10 +65,6 @@ module.exports = {</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">65</div>
<div class="line-num2">65</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">66</div>
<div class="line-num2">66</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">  plugins: [</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">67</div>
<div class="line-num2">67</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">    new webpack.ProvidePlugin({</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-del">
<div class="line-num1">68</div>
<div class="line-num2"></div>
</td>
<td class="d2h-del">
<div class="d2h-code-line d2h-del">
<span class="d2h-code-line-prefix">-</span>
<span class="d2h-code-line-ctn">      $: 'jquery',</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-del">
<div class="line-num1">69</div>
<div class="line-num2"></div>
</td>
<td class="d2h-del">
<div class="d2h-code-line d2h-del">
<span class="d2h-code-line-prefix">-</span>
<span class="d2h-code-line-ctn">      jquery: 'jquery',</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-del">
<div class="line-num1">70</div>
<div class="line-num2"></div>
</td>
<td class="d2h-del">
<div class="d2h-code-line d2h-del">
<span class="d2h-code-line-prefix">-</span>
<span class="d2h-code-line-ctn">      'window.jQuery': 'jquery',</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-del">
<div class="line-num1">71</div>
<div class="line-num2"></div>
</td>
<td class="d2h-del">
<div class="d2h-code-line d2h-del">
<span class="d2h-code-line-prefix">-</span>
<span class="d2h-code-line-ctn">      jQuery: 'jquery',</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">72</div>
<div class="line-num2">68</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">      Promise: 'es6-promise-promise',</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">73</div>
<div class="line-num2">69</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">    }),</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">74</div>
<div class="line-num2">70</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">    new BundleTracker({ filename: './webpack-stats.json' }),</span>
</div>
</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
</div>
</div>


<h3 id="what-the-bundle-looks-like-1">What the bundle looks like</h3>


<p><img alt="" src="https://pbs.twimg.com/media/DJFmrBsUwAAXkEJ.png"/>
<figcaption>This cleared up around <strong>250 kilobytes</strong>., bringing the bundle down to <strong>3.5 megabytes</strong>.  Not a huge amount, but not bad.</figcaption></p>


<h2 id="2-exclude-moment-locales">2. Exclude moment locales.</h2>


<p><a href="momentjs.com">Moment</a> is a heavyweight solution to an evergreen problem: date handling that doesn’t suck.  It ships with really strong locale support, which is great, but literally all I’m using it for is to format some UTC date-times, so including all of those locales seems unnecessary.  Thankfully, I found <a href="https://stackoverflow.com/questions/25384360/how-to-prevent-moment-js-from-loading-locales-with-webpack/25426019#25426019">a way to exclude them from webpack altogether</a>.</p>


<div id="diff">
<div class="d2h-file-list-wrapper">
<ol class="d2h-file-list">
<li class="d2h-file-list-line">
<span class="d2h-file-name-wrapper">
<span><svg aria-hidden="true" class="d2h-icon d2h-changed" height="16" title="modified" version="1.1" viewbox="0 0 14 16" width="14">
<path d="M13 1H1C0.45 1 0 1.45 0 2v12c0 0.55 0.45 1 1 1h12c0.55 0 1-0.45 1-1V2c0-0.55-0.45-1-1-1z m0 13H1V2h12v12zM4 8c0-1.66 1.34-3 3-3s3 1.34 3 3-1.34 3-3 3-3-1.34-3-3z"></path>
</svg></span>
<a class="d2h-file-name" href="#d2h-534156">webpack.config.js</a>
<span class="d2h-file-stats">
<span class="d2h-lines-added">+6</span>
<span class="d2h-lines-deleted">-0</span>
</span>
</span>
</li>
</ol>
</div><div class="d2h-wrapper">
<div class="d2h-file-wrapper" data-lang="js" id="d2h-534156">
<div class="d2h-file-header">
<span class="d2h-file-name-wrapper">
<span class="d2h-icon-wrapper"><svg aria-hidden="true" class="d2h-icon" height="16" version="1.1" viewbox="0 0 12 16" width="12">
<path d="M6 5H2v-1h4v1zM2 8h7v-1H2v1z m0 2h7v-1H2v1z m0 2h7v-1H2v1z m10-7.5v9.5c0 0.55-0.45 1-1 1H1c-0.55 0-1-0.45-1-1V2c0-0.55 0.45-1 1-1h7.5l3.5 3.5z m-1 0.5L8 2H1v12h10V5z"></path>
</svg></span>
<span class="d2h-file-name">webpack.config.js</span>
<span class="d2h-tag d2h-changed d2h-changed-tag">CHANGED</span></span>
</div>
<div class="d2h-file-diff">
<div class="d2h-code-wrapper">
<table class="d2h-diff-table">
<tbody class="d2h-diff-tbody">
<tr>
<td class="d2h-code-linenumber d2h-info"></td>
<td class="d2h-info">
<div class="d2h-code-line d2h-info">@@ -69,6 +69,12 @@ module.exports = {</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">69</div>
<div class="line-num2">69</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">    }),</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">70</div>
<div class="line-num2">70</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">    new BundleTracker({ filename: './webpack-stats.json' }),</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">71</div>
<div class="line-num2">71</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">    new ExtractTextPlugin('[name].css'),</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-ins">
<div class="line-num1"></div>
<div class="line-num2">72</div>
</td>
<td class="d2h-ins">
<div class="d2h-code-line d2h-ins">
<span class="d2h-code-line-prefix">+</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-ins">
<div class="line-num1"></div>
<div class="line-num2">73</div>
</td>
<td class="d2h-ins">
<div class="d2h-code-line d2h-ins">
<span class="d2h-code-line-prefix">+</span>
<span class="d2h-code-line-ctn">    // The locales are non-trivially large and we don't use 'em for anything.</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-ins">
<div class="line-num1"></div>
<div class="line-num2">74</div>
</td>
<td class="d2h-ins">
<div class="d2h-code-line d2h-ins">
<span class="d2h-code-line-prefix">+</span>
<span class="d2h-code-line-ctn">    // So we ignore them:</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-ins">
<div class="line-num1"></div>
<div class="line-num2">75</div>
</td>
<td class="d2h-ins">
<div class="d2h-code-line d2h-ins">
<span class="d2h-code-line-prefix">+</span>
<span class="d2h-code-line-ctn">    // - https://github.com/moment/moment/issues/2373</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-ins">
<div class="line-num1"></div>
<div class="line-num2">76</div>
</td>
<td class="d2h-ins">
<div class="d2h-code-line d2h-ins">
<span class="d2h-code-line-prefix">+</span>
<span class="d2h-code-line-ctn">    // - https://stackoverflow.com/questions/25384360/how-to-prevent-moment-js-from-loading-locales-with-webpack/25426019#25426019</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-ins">
<div class="line-num1"></div>
<div class="line-num2">77</div>
</td>
<td class="d2h-ins">
<div class="d2h-code-line d2h-ins">
<span class="d2h-code-line-prefix">+</span>
<span class="d2h-code-line-ctn">    new webpack.IgnorePlugin(/^\.\/locale<!--diff2html-diff-->#x2F;, /moment<!--diff2html-diff-->#x2F;),</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">72</div>
<div class="line-num2">78</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">  ],</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">73</div>
<div class="line-num2">79</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">74</div>
<div class="line-num2">80</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">  resolve: {</span>
</div>
</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
</div>
</div>


<h3 id="what-the-bundle-looks-like-2">What the bundle looks like</h3>


<p><img alt="" src="http://i.imgur.com/lSQFeN2.png"/>
<figcaption>This cleared up around <strong>250 kilobytes</strong>, bringing the bundle down to <strong>3.25 megabytes</strong>.</figcaption></p>


<h2 id="3-lazy-load-zxcvbn">3. Lazy load zxcvbn</h2>


<p>Zxcvbn is a very dope <a href="https://github.com/dropbox/zxcvbn">library by Dropbox</a> that handles password validation.  Buttondown uses it to, well, validate passwords:</p>


<p><img id="bordered" src="http://i.imgur.com/AFGf4m7.gif"/>
<figcaption>Those prompts on the right come from a “score” generated by zxcvbn from 0-4.</figcaption></p>


<p>However, it comes shipped with a 600KB list of frequently used passwords, which, uh, is non-trivially heavy.  My original instinct was to fork the repository and shrink that list down, as others have done, but that didn’t seem very futureproof.  Instead, I decided to try something that I’ve put off for a long time — <a href="https://webpack.js.org/guides/lazy-loading/">implementing Webpack lazy loading</a>.</p>


<p>It was definitely annoying to suss out some of the configuration requirements for lazy loading (notably the correct value of <code>publicPath</code>), but the final diff ended up being nice and compact.  The actual code change is a little clumsy (and I’m not thrilled about having the actual implementation being so tightly coupled with webpack), but it’s hard to argue with the results.</p>


<div id="diff">
<div class="d2h-file-list-wrapper">
<ol class="d2h-file-list">
<li class="d2h-file-list-line">
<span class="d2h-file-name-wrapper">
<span><svg aria-hidden="true" class="d2h-icon d2h-changed" height="16" title="modified" version="1.1" viewbox="0 0 14 16" width="14">
<path d="M13 1H1C0.45 1 0 1.45 0 2v12c0 0.55 0.45 1 1 1h12c0.55 0 1-0.45 1-1V2c0-0.55-0.45-1-1-1z m0 13H1V2h12v12zM4 8c0-1.66 1.34-3 3-3s3 1.34 3 3-1.34 3-3 3-3-1.34-3-3z"></path>
</svg></span>
<a class="d2h-file-name" href="#d2h-406675">.babelrc</a>
<span class="d2h-file-stats">
<span class="d2h-lines-added">+1</span>
<span class="d2h-lines-deleted">-0</span>
</span>
</span>
</li>
<li class="d2h-file-list-line">
<span class="d2h-file-name-wrapper">
<span><svg aria-hidden="true" class="d2h-icon d2h-changed" height="16" title="modified" version="1.1" viewbox="0 0 14 16" width="14">
<path d="M13 1H1C0.45 1 0 1.45 0 2v12c0 0.55 0.45 1 1 1h12c0.55 0 1-0.45 1-1V2c0-0.55-0.45-1-1-1z m0 13H1V2h12v12zM4 8c0-1.66 1.34-3 3-3s3 1.34 3 3-1.34 3-3 3-3-1.34-3-3z"></path>
</svg></span>
<a class="d2h-file-name" href="#d2h-608254">assets/components/PasswordValidator.vue</a>
<span class="d2h-file-stats">
<span class="d2h-lines-added">+1</span>
<span class="d2h-lines-deleted">-1</span>
</span>
</span>
</li>
<li class="d2h-file-list-line">
<span class="d2h-file-name-wrapper">
<span><svg aria-hidden="true" class="d2h-icon d2h-changed" height="16" title="modified" version="1.1" viewbox="0 0 14 16" width="14">
<path d="M13 1H1C0.45 1 0 1.45 0 2v12c0 0.55 0.45 1 1 1h12c0.55 0 1-0.45 1-1V2c0-0.55-0.45-1-1-1z m0 13H1V2h12v12zM4 8c0-1.66 1.34-3 3-3s3 1.34 3 3-1.34 3-3 3-3-1.34-3-3z"></path>
</svg></span>
<a class="d2h-file-name" href="#d2h-534156">webpack.config.js</a>
<span class="d2h-file-stats">
<span class="d2h-lines-added">+4</span>
<span class="d2h-lines-deleted">-1</span>
</span>
</span>
</li>
</ol>
</div><div class="d2h-wrapper">
<div class="d2h-file-wrapper" data-lang="babelrc" id="d2h-406675">
<div class="d2h-file-header">
<span class="d2h-file-name-wrapper">
<span class="d2h-icon-wrapper"><svg aria-hidden="true" class="d2h-icon" height="16" version="1.1" viewbox="0 0 12 16" width="12">
<path d="M6 5H2v-1h4v1zM2 8h7v-1H2v1z m0 2h7v-1H2v1z m0 2h7v-1H2v1z m10-7.5v9.5c0 0.55-0.45 1-1 1H1c-0.55 0-1-0.45-1-1V2c0-0.55 0.45-1 1-1h7.5l3.5 3.5z m-1 0.5L8 2H1v12h10V5z"></path>
</svg></span>
<span class="d2h-file-name">.babelrc</span>
<span class="d2h-tag d2h-changed d2h-changed-tag">CHANGED</span></span>
</div>
<div class="d2h-file-diff">
<div class="d2h-code-wrapper">
<table class="d2h-diff-table">
<tbody class="d2h-diff-tbody">
<tr>
<td class="d2h-code-linenumber d2h-info"></td>
<td class="d2h-info">
<div class="d2h-code-line d2h-info">@@ -10,6 +10,7 @@</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">10</div>
<div class="line-num2">10</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">    ]</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">11</div>
<div class="line-num2">11</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">  ],</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">12</div>
<div class="line-num2">12</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">    "plugins": [</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-ins">
<div class="line-num1"></div>
<div class="line-num2">13</div>
</td>
<td class="d2h-ins">
<div class="d2h-code-line d2h-ins">
<span class="d2h-code-line-prefix">+</span>
<span class="d2h-code-line-ctn">        "syntax-dynamic-import",</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">13</div>
<div class="line-num2">14</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">        "transform-object-rest-spread",</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">14</div>
<div class="line-num2">15</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">        "transform-runtime"</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">15</div>
<div class="line-num2">16</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">    ]</span>
</div>
</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
<div class="d2h-file-wrapper" data-lang="vue" id="d2h-608254">
<div class="d2h-file-header">
<span class="d2h-file-name-wrapper">
<span class="d2h-icon-wrapper"><svg aria-hidden="true" class="d2h-icon" height="16" version="1.1" viewbox="0 0 12 16" width="12">
<path d="M6 5H2v-1h4v1zM2 8h7v-1H2v1z m0 2h7v-1H2v1z m0 2h7v-1H2v1z m10-7.5v9.5c0 0.55-0.45 1-1 1H1c-0.55 0-1-0.45-1-1V2c0-0.55 0.45-1 1-1h7.5l3.5 3.5z m-1 0.5L8 2H1v12h10V5z"></path>
</svg></span>
<span class="d2h-file-name">assets/components/PasswordValidator.vue</span>
<span class="d2h-tag d2h-changed d2h-changed-tag">CHANGED</span></span>
</div>
<div class="d2h-file-diff">
<div class="d2h-code-wrapper">
<table class="d2h-diff-table">
<tbody class="d2h-diff-tbody">
<tr>
<td class="d2h-code-linenumber d2h-info"></td>
<td class="d2h-info">
<div class="d2h-code-line d2h-info">@@ -13,7 +13,6 @@</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">13</div>
<div class="line-num2">13</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">14</div>
<div class="line-num2">14</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">&lt;script&gt;</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">15</div>
<div class="line-num2">15</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">  import _ from 'lodash';</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-del">
<div class="line-num1">16</div>
<div class="line-num2"></div>
</td>
<td class="d2h-del">
<div class="d2h-code-line d2h-del">
<span class="d2h-code-line-prefix">-</span>
<span class="d2h-code-line-ctn">  import zxcvbn from 'zxcvbn';</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">17</div>
<div class="line-num2">16</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">18</div>
<div class="line-num2">17</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">  export default {</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">19</div>
<div class="line-num2">18</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">    props: {</span>
</div>
</td>
</tr>
<tr>
<td class="d2h-code-linenumber d2h-info"></td>
<td class="d2h-info">
<div class="d2h-code-line d2h-info">@@ -36,6 +35,7 @@</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">36</div>
<div class="line-num2">35</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">37</div>
<div class="line-num2">36</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">    watch: {</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">38</div>
<div class="line-num2">37</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">      password: _.debounce(async function() {</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-ins">
<div class="line-num1"></div>
<div class="line-num2">38</div>
</td>
<td class="d2h-ins">
<div class="d2h-code-line d2h-ins">
<span class="d2h-code-line-prefix">+</span>
<span class="d2h-code-line-ctn">        const zxcvbn = await import(/* webpackChunkName: "zxcvbn" */ 'zxcvbn');</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">39</div>
<div class="line-num2">39</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">        this.strength = zxcvbn(this.password).score;</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">40</div>
<div class="line-num2">40</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">        this.checkedPassword = this.password;</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">41</div>
<div class="line-num2">41</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">      }, 500),</span>
</div>
</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
<div class="d2h-file-wrapper" data-lang="js" id="d2h-534156">
<div class="d2h-file-header">
<span class="d2h-file-name-wrapper">
<span class="d2h-icon-wrapper"><svg aria-hidden="true" class="d2h-icon" height="16" version="1.1" viewbox="0 0 12 16" width="12">
<path d="M6 5H2v-1h4v1zM2 8h7v-1H2v1z m0 2h7v-1H2v1z m0 2h7v-1H2v1z m10-7.5v9.5c0 0.55-0.45 1-1 1H1c-0.55 0-1-0.45-1-1V2c0-0.55 0.45-1 1-1h7.5l3.5 3.5z m-1 0.5L8 2H1v12h10V5z"></path>
</svg></span>
<span class="d2h-file-name">webpack.config.js</span>
<span class="d2h-tag d2h-changed d2h-changed-tag">CHANGED</span></span>
</div>
<div class="d2h-file-diff">
<div class="d2h-code-wrapper">
<table class="d2h-diff-table">
<tbody class="d2h-diff-tbody">
<tr>
<td class="d2h-code-linenumber d2h-info"></td>
<td class="d2h-info">
<div class="d2h-code-line d2h-info">@@ -12,6 +12,8 @@ module.exports = {</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">12</div>
<div class="line-num2">12</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">  output: {</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">13</div>
<div class="line-num2">13</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">    path: process.env.NODE_ENV === 'production' ? path.resolve('./staticfiles/webpack_bundles/') : path.resolve('./assets/webpack_bundles/'),</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">14</div>
<div class="line-num2">14</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">    filename: '[name]-[hash].js',</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-ins">
<div class="line-num1"></div>
<div class="line-num2">15</div>
</td>
<td class="d2h-ins">
<div class="d2h-code-line d2h-ins">
<span class="d2h-code-line-prefix">+</span>
<span class="d2h-code-line-ctn">    chunkFilename: '[name]-[hash].js',</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-ins">
<div class="line-num1"></div>
<div class="line-num2">16</div>
</td>
<td class="d2h-ins">
<div class="d2h-code-line d2h-ins">
<span class="d2h-code-line-prefix">+</span>
<span class="d2h-code-line-ctn">    publicPath: '/static/webpack_bundles/',</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">15</div>
<div class="line-num2">17</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">  },</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">16</div>
<div class="line-num2">18</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">17</div>
<div class="line-num2">19</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">  devtool: 'eval-source-map',</span>
</div>
</td>
</tr>
<tr>
<td class="d2h-code-linenumber d2h-info"></td>
<td class="d2h-info">
<div class="d2h-code-line d2h-info">@@ -51,10 +53,11 @@ module.exports = {</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">51</div>
<div class="line-num2">53</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">        options: {</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">52</div>
<div class="line-num2">54</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">          cacheDirectory: true,</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">53</div>
<div class="line-num2">55</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">          presets: [</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-del">
<div class="line-num1">54</div>
<div class="line-num2"></div>
</td>
<td class="d2h-del">
<div class="d2h-code-line d2h-del">
<span class="d2h-code-line-prefix">-</span>
<span class="d2h-code-line-ctn"> <del>['</del>es2015',<del> { 'modules': false }],</del></span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-ins">
<div class="line-num1"></div>
<div class="line-num2">56</div>
</td>
<td class="d2h-ins">
<div class="d2h-code-line d2h-ins">
<span class="d2h-code-line-prefix">+</span>
<span class="d2h-code-line-ctn"> <ins>'</ins>es2015',</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">55</div>
<div class="line-num2">57</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">            'stage-2'</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">56</div>
<div class="line-num2">58</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">          ],</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">57</div>
<div class="line-num2">59</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">          plugins: [</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-ins">
<div class="line-num1"></div>
<div class="line-num2">60</div>
</td>
<td class="d2h-ins">
<div class="d2h-code-line d2h-ins">
<span class="d2h-code-line-prefix">+</span>
<span class="d2h-code-line-ctn">            'syntax-dynamic-import',</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">58</div>
<div class="line-num2">61</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">            "transform-object-rest-spread",</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">59</div>
<div class="line-num2">62</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">            "transform-runtime"</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">60</div>
<div class="line-num2">63</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">          ]</span>
</div>
</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
</div>
</div>


<h3 id="what-the-bundle-looks-like-3">What the bundle looks like</h3>


<p><img alt="" src="https://pbs.twimg.com/media/DJLRKvJUIAAzOuz.png"/>
<figcaption>This cleared up around <strong>750 kilobytes</strong>, bringing the bundle down to <strong>2.5 megabytes</strong>.  We’re almost there!</figcaption></p>


<h2 id="4-selectively-import-lodash">4. Selectively import lodash</h2>


<p>Lastly, I’ll close with perhaps the most canonical example of “a thing everyone tells me I should do for performance reasons but I don’t because I’m lazy”: replacing the full-on lodash import with  selected ones.</p>


<p>This is was very easy (and boring) to do, and resulted in a very boring diff, so I’m only showing you one instance of it.  Rest assured, the rest looked exactly like this:
</p>
<div id="diff">
<div class="d2h-file-list-wrapper">
<ol class="d2h-file-list">
<li class="d2h-file-list-line">
<span class="d2h-file-name-wrapper">
<span><svg aria-hidden="true" class="d2h-icon d2h-changed" height="16" title="modified" version="1.1" viewbox="0 0 14 16" width="14">
<path d="M13 1H1C0.45 1 0 1.45 0 2v12c0 0.55 0.45 1 1 1h12c0.55 0 1-0.45 1-1V2c0-0.55-0.45-1-1-1z m0 13H1V2h12v12zM4 8c0-1.66 1.34-3 3-3s3 1.34 3 3-1.34 3-3 3-3-1.34-3-3z"></path>
</svg></span>
<a class="d2h-file-name" href="#d2h-564306">assets/components/AccountEmailValidator.vue</a>
<span class="d2h-file-stats">
<span class="d2h-lines-added">+2</span>
<span class="d2h-lines-deleted">-2</span>
</span>
</span>
</li>
</ol>
</div><div class="d2h-wrapper">
<div class="d2h-file-wrapper" data-lang="vue" id="d2h-564306">
<div class="d2h-file-header">
<span class="d2h-file-name-wrapper">
<span class="d2h-icon-wrapper"><svg aria-hidden="true" class="d2h-icon" height="16" version="1.1" viewbox="0 0 12 16" width="12">
<path d="M6 5H2v-1h4v1zM2 8h7v-1H2v1z m0 2h7v-1H2v1z m0 2h7v-1H2v1z m10-7.5v9.5c0 0.55-0.45 1-1 1H1c-0.55 0-1-0.45-1-1V2c0-0.55 0.45-1 1-1h7.5l3.5 3.5z m-1 0.5L8 2H1v12h10V5z"></path>
</svg></span>
<span class="d2h-file-name">assets/components/AccountEmailValidator.vue</span>
<span class="d2h-tag d2h-changed d2h-changed-tag">CHANGED</span></span>
</div>
<div class="d2h-file-diff">
<div class="d2h-code-wrapper">
<table class="d2h-diff-table">
<tbody class="d2h-diff-tbody">
<tr>
<td class="d2h-code-linenumber d2h-info"></td>
<td class="d2h-info">
<div class="d2h-code-line d2h-info">@@ -20,7 +20,7 @@</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">20</div>
<div class="line-num2">20</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">  &lt;/span&gt;</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">21</div>
<div class="line-num2">21</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">&lt;/template&gt;</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">22</div>
<div class="line-num2">22</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">&lt;script&gt;</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-del">
<div class="line-num1">23</div>
<div class="line-num2"></div>
</td>
<td class="d2h-del">
<div class="d2h-code-line d2h-del">
<span class="d2h-code-line-prefix">-</span>
<span class="d2h-code-line-ctn">  import <del>_</del> from 'lodash';</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-ins">
<div class="line-num1"></div>
<div class="line-num2">23</div>
</td>
<td class="d2h-ins">
<div class="d2h-code-line d2h-ins">
<span class="d2h-code-line-prefix">+</span>
<span class="d2h-code-line-ctn">  import <ins>debounce</ins> from 'lodash<ins>/debounce</ins>';</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">24</div>
<div class="line-num2">24</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">25</div>
<div class="line-num2">25</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">  import { EmailValidationStatus } from 'types';</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">26</div>
<div class="line-num2">26</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">  import validateEmail from 'services/validate<em>email';</em></span>
</div>
</td>
</tr>
<tr>
<td class="d2h-code-linenumber d2h-info"></td>
<td class="d2h-info">
<div class="d2h-code-line d2h-info">@@ -38,7 +38,7 @@</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">38</div>
<div class="line-num2">38</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">    },</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">39</div>
<div class="line-num2">39</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">40</div>
<div class="line-num2">40</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">    watch: {</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-del">
<div class="line-num1">41</div>
<div class="line-num2"></div>
</td>
<td class="d2h-del">
<div class="d2h-code-line d2h-del">
<span class="d2h-code-line-prefix">-</span>
<span class="d2h-code-line-ctn">      email: <del>.</del>debounce(async function() {</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-ins">
<div class="line-num1"></div>
<div class="line-num2">41</div>
</td>
<td class="d2h-ins">
<div class="d2h-code-line d2h-ins">
<span class="d2h-code-line-prefix">+</span>
<span class="d2h-code-line-ctn">      email: debounce(async function() {</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">42</div>
<div class="line-num2">42</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">        this.status = EmailValidationStatus.PENDING;</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">43</div>
<div class="line-num2">43</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">        this.status = await validateEmail(this.email);</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">44</div>
<div class="line-num2">44</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">      }, 500),</span>
</div>
</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
</div>
</div>


<h3 id="what-the-bundle-looks-like-4">What the bundle looks like</h3>


<p><img alt="" src="https://pbs.twimg.com/media/DJLVVkJUIAAKXYr.png"/>
<figcaption>This cleared up <strong>450 kilobytes</strong>, bringing the bundle down to <strong>2.08 megabytes</strong>.  Not quite half, but close enough.</figcaption></p>


<h2 id="next-steps">Next steps</h2>


<p>Two megabytes is still a bunch (even if its unminified), and it’s larger than I want it to be, but I’m really happy with the results!  I got to learn more about Webpack, improve the quality of the codebase, and the smaller bundle size has had a non-trivial impact on bounce rate.</p>


<p>There’s definitely some stuff I could do to shrink the code footprint even more:</p>


<ol>
<li>Remove extra fonts.</li>
<li>Get rid of <code>moment</code> entirely and write a bespoke date management utility.</li>
<li>Lazy-load flatpickr (it’s only being used in a couple places).</li>
</ol>


<p>But those are projects for another day.  Now it’s time for <a href="https://trello.com/b/yrZUqnm2/public-roadmap">more features</a>.</p>


<p>And, to end with another bread gif:</p>


<p><img alt="" src="https://media.giphy.com/media/QMMt03hAmVbNu/giphy.gif"/>
<figcaption>The cat is Chrome in this metaphor, I think.</figcaption></p>


<h2 id="further-reading">Further reading</h2>


<ol>
<li><a href="https://github.com/reddit/reddit-mobile/issues/247">Paul Irish’s perf audit of Reddit</a></li>
<li><a href="https://css-tricks.com/the-critical-request/">The Critical Request</a></li>
<li><a href="https://www.voorhoede.nl/en/blog/why-our-website-is-faster-than-yours/">Why our website is faster than yours</a> <sup class="footnote-ref" id="fnref:1"><a href="#fn:1" rel="footnote">1</a></sup></li>
<li><a href="https://hackernoon.com/optimising-your-application-bundle-size-with-webpack-e85b00bab579">Optimizing your bundle size</a></li>
</ol>


<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.3/jquery.js"></script>


<script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.9.0/highlight.min.js"></script>


<script>
!function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a="function"==typeof require&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}for(var i="function"==typeof require&&require,o=0;o<r.length;o++)s(r[o]);return s}({1:[function(require,module){(function(global){!function(){function Diff2HtmlUI(config){var cfg=config||{};cfg.diff?diffJson=Diff2Html.getJsonFromDiff(cfg.diff):cfg.json&&(diffJson=cfg.json),this._initSelection()}var highlightJS=require("./highlight.js-internals.js").HighlightJS,diffJson=null,defaultTarget="body",currentSelectionColumnId=-1;Diff2HtmlUI.prototype.draw=function(targetId,config){var cfg=config||{};cfg.inputFormat="json";var $target=this._getTarget(targetId);$target.html(Diff2Html.getPrettyHtml(diffJson,cfg)),cfg.synchronisedScroll&&this.synchronisedScroll($target,cfg)},Diff2HtmlUI.prototype.synchronisedScroll=function(targetId){var $target=this._getTarget(targetId);$target.find(".d2h-file-side-diff").scroll(function(){var $this=$(this);$this.closest(".d2h-file-wrapper").find(".d2h-file-side-diff").scrollLeft($this.scrollLeft())})},Diff2HtmlUI.prototype.fileListCloseable=function(targetId,startVisible){function show(){$showBtn.hide(),$hideBtn.show(),$fileList.show()}function hide(){$hideBtn.hide(),$showBtn.show(),$fileList.hide()}var $target=this._getTarget(targetId),hashTag=this._getHashTag(),$showBtn=$target.find(".d2h-show"),$hideBtn=$target.find(".d2h-hide"),$fileList=$target.find(".d2h-file-list");"files-summary-show"===hashTag?show():"files-summary-hide"===hashTag?hide():startVisible?show():hide(),$showBtn.click(show),$hideBtn.click(hide)},Diff2HtmlUI.prototype.highlightCode=function(targetId){var that=this,$target=that._getTarget(targetId),$files=$target.find(".d2h-file-wrapper");$files.map(function(_i,file){var oldLinesState,newLinesState,$file=$(file),language=$file.data("lang"),$codeLines=$file.find(".d2h-code-line-ctn");$codeLines.map(function(_j,line){var lineState,$line=$(line),text=line.textContent,lineParent=line.parentNode;lineState=-1!==lineParent.className.indexOf("d2h-del")?oldLinesState:newLinesState;var result=hljs.getLanguage(language)?hljs.highlight(language,text,!0,lineState):hljs.highlightAuto(text);-1!==lineParent.className.indexOf("d2h-del")?oldLinesState=result.top:-1!==lineParent.className.indexOf("d2h-ins")?newLinesState=result.top:(oldLinesState=result.top,newLinesState=result.top);var originalStream=highlightJS.nodeStream(line);if(originalStream.length){var resultNode=document.createElementNS("http://www.w3.org/1999/xhtml","div");resultNode.innerHTML=result.value,result.value=highlightJS.mergeStreams(originalStream,highlightJS.nodeStream(resultNode),text)}$line.addClass("hljs"),$line.addClass(result.language),$line.html(result.value)})})},Diff2HtmlUI.prototype._getTarget=function(targetId){var $target;return"object"==typeof targetId&&targetId instanceof jQuery?$target=targetId:"string"==typeof targetId?$target=$(targetId):(console.error("Wrong target provided! Falling back to default value 'body'."),console.log("Please provide a jQuery object or a valid DOM query string."),$target=$(defaultTarget)),$target},Diff2HtmlUI.prototype._getHashTag=function(){var docUrl=document.URL,hashTagIndex=docUrl.indexOf("#"),hashTag=null;return-1!==hashTagIndex&&(hashTag=docUrl.substr(hashTagIndex+1)),hashTag},Diff2HtmlUI.prototype._distinct=function(collection){return collection.filter(function(v,i){return collection.indexOf(v)===i})},Diff2HtmlUI.prototype._initSelection=function(){var body=$("body"),that=this;body.on("mousedown",".d2h-diff-table",function(event){var target=$(event.target),table=target.closest(".d2h-diff-table");target.closest(".d2h-code-line,.d2h-code-side-line").length?(table.removeClass("selecting-left"),table.addClass("selecting-right"),currentSelectionColumnId=1):target.closest(".d2h-code-linenumber,.d2h-code-side-linenumber").length&&(table.removeClass("selecting-right"),table.addClass("selecting-left"),currentSelectionColumnId=0)}),body.on("copy",".d2h-diff-table",function(event){var clipboardData=event.originalEvent.clipboardData,text=that._getSelectedText();clipboardData.setData("text",text),event.preventDefault()})},Diff2HtmlUI.prototype._getSelectedText=function(){var sel=window.getSelection(),range=sel.getRangeAt(0),doc=range.cloneContents(),nodes=doc.querySelectorAll("tr"),text="",idx=currentSelectionColumnId;return 0===nodes.length?text=doc.textContent:[].forEach.call(nodes,function(tr,i){var td=tr.cells[1===tr.cells.length?0:idx];text+=(i?"\n":"")+td.textContent.replace(/(?:\r\n|\r|\n)/g,"")}),text},module.exports.Diff2HtmlUI=Diff2HtmlUI,global.Diff2HtmlUI=Diff2HtmlUI}()}).call(this,"undefined"!=typeof global?global:"undefined"!=typeof self?self:"undefined"!=typeof window?window:{})},{"./highlight.js-internals.js":2}],2:[function(require,module){!function(){function HighlightJS(){}function escape(value){return value.replace(/&/gm,"&amp;").replace(/</gm,"&lt;").replace(/>/gm,"&gt;")}function tag(node){return node.nodeName.toLowerCase()}var ArrayProto=[];HighlightJS.prototype.nodeStream=function(node){var result=[];return function _nodeStream(node,offset){for(var child=node.firstChild;child;child=child.nextSibling)3===child.nodeType?offset+=child.nodeValue.length:1===child.nodeType&&(result.push({event:"start",offset:offset,node:child}),offset=_nodeStream(child,offset),tag(child).match(/br|hr|img|input/)||result.push({event:"stop",offset:offset,node:child}));return offset}(node,0),result},HighlightJS.prototype.mergeStreams=function(original,highlighted,value){function selectStream(){return original.length&&highlighted.length?original[0].offset!==highlighted[0].offset?original[0].offset<highlighted[0].offset?original:highlighted:"start"===highlighted[0].event?original:highlighted:original.length?original:highlighted}function open(node){function attr_str(a){return" "+a.nodeName+'="'+escape(a.value)+'"'}result+="<"+tag(node)+ArrayProto.map.call(node.attributes,attr_str).join("")+">"}function close(node){result+="</"+tag(node)+">"}function render(event){("start"===event.event?open:close)(event.node)}for(var processed=0,result="",nodeStack=[];original.length||highlighted.length;){var stream=selectStream();if(result+=escape(value.substring(processed,stream[0].offset)),processed=stream[0].offset,stream===original){nodeStack.reverse().forEach(close);do render(stream.splice(0,1)[0]),stream=selectStream();while(stream===original&&stream.length&&stream[0].offset===processed);nodeStack.reverse().forEach(open)}else"start"===stream[0].event?nodeStack.push(stream[0].node):nodeStack.pop(),render(stream.splice(0,1)[0])}return result+escape(value.substr(processed))},module.exports.HighlightJS=new HighlightJS}()},{}]},{},[1]);
</script>


<script>
$(document).ready(function() {
  var diff2htmlUi = new Diff2HtmlUI();
  diff2htmlUi.fileListCloseable("#diff", false);
  diff2htmlUi.synchronisedScroll("#diff", false);
  diff2htmlUi.highlightCode('#diff');
});
</script>


<div class="footnotes">
<hr/>
<ol>
<li id="fn:1">Classic case of “bad headline, good content”.
 <a class="footnote-return" href="#fnref:1"><sup>[return]</sup></a></li>
</ol>
</div>
	