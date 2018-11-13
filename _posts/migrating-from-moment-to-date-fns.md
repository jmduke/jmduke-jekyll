---
Title: "Migrating from moment to date-fns"
Date: 2017-10-07 00:00:00
Tags: ["development"]
---

				<style>

.d2h-wrapper{text-align:left}.d2h-file-header{padding:5px 10px;border-bottom:1px solid #d8d8d8;background-color:#f7f7f7}.d2h-file-stats{display:-webkit-box;display:-ms-flexbox;display:flex;margin-left:auto;font-size:14px}.d2h-lines-added{text-align:right;border:1px solid #b4e2b4;border-radius:5px 0 0 5px;color:#399839;padding:2px;vertical-align:middle}.d2h-lines-deleted{text-align:left;border:1px solid #e9aeae;border-radius:0 5px 5px 0;color:#c33;padding:2px;vertical-align:middle;margin-left:1px}.d2h-file-name-wrapper{display:-webkit-box;display:-ms-flexbox;display:flex;-webkit-box-align:center;-ms-flex-align:center;align-items:center;width:100%;font-family:"Source Sans Pro","Helvetica Neue",Helvetica,Arial,sans-serif;font-size:15px}.d2h-file-name{white-space:nowrap;text-overflow:ellipsis;overflow-x:hidden;line-height:21px}.d2h-file-wrapper{border:1px solid #ddd;border-radius:3px;margin-bottom:1em}.d2h-diff-table{width:100%;border-collapse:collapse;font-family:Menlo,Consolas,monospace;font-size:13px}.d2h-diff-tbody>tr>td{height:20px;line-height:20px}.d2h-files-diff{display:block;width:100%;height:100%}.d2h-file-diff{overflow-x:scroll;overflow-y:hidden}.d2h-file-side-diff{display:inline-block;overflow-x:scroll;overflow-y:hidden;width:50%;margin-right:-4px;margin-bottom:-8px}.d2h-code-line{display:inline-block;white-space:nowrap;padding:0 10px;margin-left:80px}.d2h-code-side-line{display:inline-block;white-space:nowrap;padding:0 10px;margin-left:50px}.d2h-code-line del,.d2h-code-side-line del{display:inline-block;margin-top:-1px;text-decoration:none;background-color:#ffb6ba;border-radius:.2em}.d2h-code-line ins,.d2h-code-side-line ins{display:inline-block;margin-top:-1px;text-decoration:none;background-color:#97f295;border-radius:.2em;text-align:left}.d2h-code-line-prefix{display:inline;background:0 0;padding:0;word-wrap:normal;white-space:pre}.d2h-code-line-ctn{display:inline;background:0 0;padding:0;word-wrap:normal;white-space:pre}.line-num1{box-sizing:border-box;float:left;width:40px;overflow:hidden;text-overflow:ellipsis;padding-left:3px}.line-num2{box-sizing:border-box;float:right;width:40px;overflow:hidden;text-overflow:ellipsis;padding-left:3px}.d2h-code-linenumber{box-sizing:border-box;position:absolute;width:86px;padding-left:2px;padding-right:2px;background-color:#fff;color:rgba(0,0,0,.3);text-align:right;border:solid #eee;border-width:0 1px 0 1px;cursor:pointer}.d2h-code-side-linenumber{box-sizing:border-box;position:absolute;width:56px;padding-left:5px;padding-right:5px;background-color:#fff;color:rgba(0,0,0,.3);text-align:right;border:solid #eee;border-width:0 1px 0 1px;cursor:pointer;overflow:hidden;text-overflow:ellipsis}.d2h-del{background-color:#fee8e9;border-color:#e9aeae}.d2h-ins{background-color:#dfd;border-color:#b4e2b4}.d2h-info{background-color:#f8fafd;color:rgba(0,0,0,.3);border-color:#d5e4f2}.d2h-file-diff .d2h-del.d2h-change{background-color:#fdf2d0}.d2h-file-diff .d2h-ins.d2h-change{background-color:#ded}.d2h-file-list-wrapper{margin-bottom:10px}.d2h-file-list-wrapper a{text-decoration:none;color:#3572b0}.d2h-file-list-wrapper a:visited{color:#3572b0}.d2h-file-list-header{text-align:left}.d2h-file-list-title{font-weight:700}.d2h-file-list-line{display:-webkit-box;display:-ms-flexbox;display:flex;text-align:left;display:none;}.d2h-file-list{display:block;list-style:none;padding:0;margin:0}.d2h-file-list>li{border-bottom:#ddd solid 1px;padding:5px 10px;margin:0}.d2h-file-list>li:last-child{border-bottom:none}.d2h-file-switch{display:none;font-size:10px;cursor:pointer}.d2h-icon-wrapper{line-height:31px}.d2h-icon{vertical-align:middle;margin-right:10px;fill:currentColor}.d2h-deleted{color:#c33}.d2h-added{color:#399839}.d2h-changed{color:#d0b44c}.d2h-moved{color:#3572b0}.d2h-tag{display:-webkit-box;display:-ms-flexbox;display:flex;font-size:10px;margin-left:5px;padding:0 2px;background-color:#fff}.d2h-deleted-tag{border:#c33 1px solid}.d2h-added-tag{border:#399839 1px solid}.d2h-changed-tag{border:#d0b44c 1px solid}.d2h-moved-tag{border:#3572b0 1px solid}.selecting-left .d2h-code-line,.selecting-left .d2h-code-line *,.selecting-left .d2h-code-side-line,.selecting-left .d2h-code-side-line *,.selecting-right td.d2h-code-linenumber,.selecting-right td.d2h-code-linenumber *,.selecting-right td.d2h-code-side-linenumber,.selecting-right td.d2h-code-side-linenumber *{-webkit-touch-callout:none;-webkit-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none}.selecting-left .d2h-code-line ::-moz-selection,.selecting-left .d2h-code-line::-moz-selection,.selecting-left .d2h-code-side-line ::-moz-selection,.selecting-left .d2h-code-side-line::-moz-selection,.selecting-right td.d2h-code-linenumber::-moz-selection,.selecting-right td.d2h-code-side-linenumber ::-moz-selection,.selecting-right td.d2h-code-side-linenumber::-moz-selection{background:0 0}.selecting-left .d2h-code-line ::selection,.selecting-left .d2h-code-line::selection,.selecting-left .d2h-code-side-line ::selection,.selecting-left .d2h-code-side-line::selection,.selecting-right td.d2h-code-linenumber::selection,.selecting-right td.d2h-code-side-linenumber ::selection,.selecting-right td.d2h-code-side-linenumber::selection{background:0 0}
</style>

<p>I got a lot of positive feedback from my recent article on <a href="http://jmduke.com/posts/how-i-cut-my-webpack-bundle-size-in-half/">how I cut my webpack bundle size in half</a>, and a common refrain was how folks found themselves in the same position as I did in terms of deciding to migrate off of <code>moment.js</code>.</p>


<p>A handful of folks suggested <a href="https://date-fns.org">date-fns</a> as an alternative.   <code>date-fns</code> has a relatively clumsy name but offered excatly what I was looking for:</p>


<ul>
<li>Modularity and tree-shaking compatability.</li>
<li>Use of native dates</li>
<li>TypeScript support</li>
</ul>


<p>So I decided to take the plunge and try migrating: the surface area of my use of moment wasn’t that large, so I hoped it would be relatively painless.</p>


<p>(Spoiler alert: it was.)</p>

<!--more-->

<p></p>


<p>Here’s what the diff looked like:</p>


<div id="diff">
<div class="d2h-file-list-wrapper">
<ol class="d2h-file-list">
<li class="d2h-file-list-line">
<span class="d2h-file-name-wrapper">
<span><svg aria-hidden="true" class="d2h-icon d2h-changed" height="16" title="modified" version="1.1" viewbox="0 0 14 16" width="14">
<path d="M13 1H1C0.45 1 0 1.45 0 2v12c0 0.55 0.45 1 1 1h12c0.55 0 1-0.45 1-1V2c0-0.55-0.45-1-1-1z m0 13H1V2h12v12zM4 8c0-1.66 1.34-3 3-3s3 1.34 3 3-1.34 3-3 3-3-1.34-3-3z"></path>
</svg></span>
<a class="d2h-file-name" href="#d2h-447986">assets/components/DateTimePicker.vue</a>
<span class="d2h-file-stats">
<span class="d2h-lines-added">+2</span>
<span class="d2h-lines-deleted">-4</span>
</span>
</span>
</li>
<li class="d2h-file-list-line">
<span class="d2h-file-name-wrapper">
<span><svg aria-hidden="true" class="d2h-icon d2h-changed" height="16" title="modified" version="1.1" viewbox="0 0 14 16" width="14">
<path d="M13 1H1C0.45 1 0 1.45 0 2v12c0 0.55 0.45 1 1 1h12c0.55 0 1-0.45 1-1V2c0-0.55-0.45-1-1-1z m0 13H1V2h12v12zM4 8c0-1.66 1.34-3 3-3s3 1.34 3 3-1.34 3-3 3-3-1.34-3-3z"></path>
</svg></span>
<a class="d2h-file-name" href="#d2h-392232">assets/components/DraftLoadingNotice.vue</a>
<span class="d2h-file-stats">
<span class="d2h-lines-added">+3</span>
<span class="d2h-lines-deleted">-3</span>
</span>
</span>
</li>
<li class="d2h-file-list-line">
<span class="d2h-file-name-wrapper">
<span><svg aria-hidden="true" class="d2h-icon d2h-changed" height="16" title="modified" version="1.1" viewbox="0 0 14 16" width="14">
<path d="M13 1H1C0.45 1 0 1.45 0 2v12c0 0.55 0.45 1 1 1h12c0.55 0 1-0.45 1-1V2c0-0.55-0.45-1-1-1z m0 13H1V2h12v12zM4 8c0-1.66 1.34-3 3-3s3 1.34 3 3-1.34 3-3 3-3-1.34-3-3z"></path>
</svg></span>
<a class="d2h-file-name" href="#d2h-518269">assets/screens/Write.vue</a>
<span class="d2h-file-stats">
<span class="d2h-lines-added">+4</span>
<span class="d2h-lines-deleted">-3</span>
</span>
</span>
</li>
<li class="d2h-file-list-line">
<span class="d2h-file-name-wrapper">
<span><svg aria-hidden="true" class="d2h-icon d2h-changed" height="16" title="modified" version="1.1" viewbox="0 0 14 16" width="14">
<path d="M13 1H1C0.45 1 0 1.45 0 2v12c0 0.55 0.45 1 1 1h12c0.55 0 1-0.45 1-1V2c0-0.55-0.45-1-1-1z m0 13H1V2h12v12zM4 8c0-1.66 1.34-3 3-3s3 1.34 3 3-1.34 3-3 3-3-1.34-3-3z"></path>
</svg></span>
<a class="d2h-file-name" href="#d2h-162230">assets/store/actions.ts</a>
<span class="d2h-file-stats">
<span class="d2h-lines-added">+3</span>
<span class="d2h-lines-deleted">-0</span>
</span>
</span>
</li>
<li class="d2h-file-list-line">
<span class="d2h-file-name-wrapper">
<span><svg aria-hidden="true" class="d2h-icon d2h-changed" height="16" title="modified" version="1.1" viewbox="0 0 14 16" width="14">
<path d="M13 1H1C0.45 1 0 1.45 0 2v12c0 0.55 0.45 1 1 1h12c0.55 0 1-0.45 1-1V2c0-0.55-0.45-1-1-1z m0 13H1V2h12v12zM4 8c0-1.66 1.34-3 3-3s3 1.34 3 3-1.34 3-3 3-3-1.34-3-3z"></path>
</svg></span>
<a class="d2h-file-name" href="#d2h-490984">assets/utils.ts</a>
<span class="d2h-file-stats">
<span class="d2h-lines-added">+7</span>
<span class="d2h-lines-deleted">-3</span>
</span>
</span>
</li>
<li class="d2h-file-list-line">
<span class="d2h-file-name-wrapper">
<span><svg aria-hidden="true" class="d2h-icon d2h-changed" height="16" title="modified" version="1.1" viewbox="0 0 14 16" width="14">
<path d="M13 1H1C0.45 1 0 1.45 0 2v12c0 0.55 0.45 1 1 1h12c0.55 0 1-0.45 1-1V2c0-0.55-0.45-1-1-1z m0 13H1V2h12v12zM4 8c0-1.66 1.34-3 3-3s3 1.34 3 3-1.34 3-3 3-3-1.34-3-3z"></path>
</svg></span>
<a class="d2h-file-name" href="#d2h-040357">emails/services/email_analytics_fetcher.py</a>
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
<a class="d2h-file-name" href="#d2h-519664">package.json</a>
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
<a class="d2h-file-name" href="#d2h-704695">webpack-stats.json</a>
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
<a class="d2h-file-name" href="#d2h-526891">yarn.lock</a>
<span class="d2h-file-stats">
<span class="d2h-lines-added">+4</span>
<span class="d2h-lines-deleted">-4</span>
</span>
</span>
</li>
</ol>
</div><div class="d2h-wrapper">
<div class="d2h-file-wrapper" data-lang="vue" id="d2h-447986">
<div class="d2h-file-header">
<span class="d2h-file-name-wrapper">
<span class="d2h-icon-wrapper"><svg aria-hidden="true" class="d2h-icon" height="16" version="1.1" viewbox="0 0 12 16" width="12">
<path d="M6 5H2v-1h4v1zM2 8h7v-1H2v1z m0 2h7v-1H2v1z m0 2h7v-1H2v1z m10-7.5v9.5c0 0.55-0.45 1-1 1H1c-0.55 0-1-0.45-1-1V2c0-0.55 0.45-1 1-1h7.5l3.5 3.5z m-1 0.5L8 2H1v12h10V5z"></path>
</svg></span>
<span class="d2h-file-name">assets/components/DateTimePicker.vue</span>
<span class="d2h-tag d2h-changed d2h-changed-tag">CHANGED</span></span>
</div>
<div class="d2h-file-diff">
<div class="d2h-code-wrapper">
<table class="d2h-diff-table">
<tbody class="d2h-diff-tbody">
<tr>
<td class="d2h-code-linenumber d2h-info"></td>
<td class="d2h-info">
<div class="d2h-code-line d2h-info">@@ -7,16 +7,14 @@</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">7</div>
<div class="line-num2">7</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">&lt;/template&gt;</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">8</div>
<div class="line-num2">8</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">9</div>
<div class="line-num2">9</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">&lt;script&gt;</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-del">
<div class="line-num1">10</div>
<div class="line-num2"></div>
</td>
<td class="d2h-del">
<div class="d2h-code-line d2h-del">
<span class="d2h-code-line-prefix">-</span>
<span class="d2h-code-line-ctn">  import <del>moment</del> from '<del>moment</del>';</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-ins">
<div class="line-num1"></div>
<div class="line-num2">10</div>
</td>
<td class="d2h-ins">
<div class="d2h-code-line d2h-ins">
<span class="d2h-code-line-prefix">+</span>
<span class="d2h-code-line-ctn">  import <ins>format</ins> from '<ins>date-fns/format</ins>';</span>
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
<span class="d2h-code-line-ctn">  export default {</span>
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
<span class="d2h-code-line-ctn">    props: ['value'],</span>
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
<span class="d2h-code-line-ctn">    computed: {</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">16</div>
<div class="line-num2">16</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">      formattedValue() {</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-del">
<div class="line-num1">17</div>
<div class="line-num2"></div>
</td>
<td class="d2h-del">
<div class="d2h-code-line d2h-del">
<span class="d2h-code-line-prefix">-</span>
<span class="d2h-code-line-ctn">        return this.value</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-ins">
<div class="line-num1"></div>
<div class="line-num2">17</div>
</td>
<td class="d2h-ins">
<div class="d2h-code-line d2h-ins">
<span class="d2h-code-line-prefix">+</span>
<span class="d2h-code-line-ctn">        return this.value<ins> ? format(this.value, 'MM/DD/YYYY @ h:mm a') : null;</ins></span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-del">
<div class="line-num1">18</div>
<div class="line-num2"></div>
</td>
<td class="d2h-del">
<div class="d2h-code-line d2h-del">
<span class="d2h-code-line-prefix">-</span>
<span class="d2h-code-line-ctn">          ? moment(this.value).format('MM/DD/YYYY @ h:mm a')</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-del">
<div class="line-num1">19</div>
<div class="line-num2"></div>
</td>
<td class="d2h-del">
<div class="d2h-code-line d2h-del">
<span class="d2h-code-line-prefix">-</span>
<span class="d2h-code-line-ctn">          : null;</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">20</div>
<div class="line-num2">18</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">      },</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">21</div>
<div class="line-num2">19</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">    },</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">22</div>
<div class="line-num2">20</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
</div>
</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
<div class="d2h-file-wrapper" data-lang="vue" id="d2h-392232">
<div class="d2h-file-header">
<span class="d2h-file-name-wrapper">
<span class="d2h-icon-wrapper"><svg aria-hidden="true" class="d2h-icon" height="16" version="1.1" viewbox="0 0 12 16" width="12">
<path d="M6 5H2v-1h4v1zM2 8h7v-1H2v1z m0 2h7v-1H2v1z m0 2h7v-1H2v1z m10-7.5v9.5c0 0.55-0.45 1-1 1H1c-0.55 0-1-0.45-1-1V2c0-0.55 0.45-1 1-1h7.5l3.5 3.5z m-1 0.5L8 2H1v12h10V5z"></path>
</svg></span>
<span class="d2h-file-name">assets/components/DraftLoadingNotice.vue</span>
<span class="d2h-tag d2h-changed d2h-changed-tag">CHANGED</span></span>
</div>
<div class="d2h-file-diff">
<div class="d2h-code-wrapper">
<table class="d2h-diff-table">
<tbody class="d2h-diff-tbody">
<tr>
<td class="d2h-code-linenumber d2h-info"></td>
<td class="d2h-info">
<div class="d2h-code-line d2h-info">@@ -4,7 +4,7 @@</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">4</div>
<div class="line-num2">4</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">      You worked on a</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">5</div>
<div class="line-num2">5</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">      &lt;span v-if="latestDraft.subject"&gt;draft entitled &lt;strong&gt;{{ latestDraft.subject }}&lt;/strong&gt;&lt;/span&gt;</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">6</div>
<div class="line-num2">6</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">      &lt;span v-else&gt;untitled draft&lt;/span&gt;</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-del">
<div class="line-num1">7</div>
<div class="line-num2"></div>
</td>
<td class="d2h-del">
<div class="d2h-code-line d2h-del">
<span class="d2h-code-line-prefix">-</span>
<span class="d2h-code-line-ctn">      {{ latestDraftAgo <del>}}.</del></span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-ins">
<div class="line-num1"></div>
<div class="line-num2">7</div>
</td>
<td class="d2h-ins">
<div class="d2h-code-line d2h-ins">
<span class="d2h-code-line-prefix">+</span>
<span class="d2h-code-line-ctn">      {{ latestDraftAgo <ins>}} ago.</ins></span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">8</div>
<div class="line-num2">8</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">      &lt;a href="#" @click="loadDraft"&gt;&lt;strong&gt;Continue writing&lt;/strong&gt;&lt;/a&gt;.</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">9</div>
<div class="line-num2">9</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">    &lt;/div&gt;</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">10</div>
<div class="line-num2">10</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">    &lt;div class="actions"&gt;</span>
</div>
</td>
</tr>
<tr>
<td class="d2h-code-linenumber d2h-info"></td>
<td class="d2h-info">
<div class="d2h-code-line d2h-info">@@ -16,7 +16,7 @@</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">16</div>
<div class="line-num2">16</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">&lt;/template&gt;</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">17</div>
<div class="line-num2">17</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
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
<span class="d2h-code-line-ctn">&lt;script&gt;</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-del">
<div class="line-num1">19</div>
<div class="line-num2"></div>
</td>
<td class="d2h-del">
<div class="d2h-code-line d2h-del">
<span class="d2h-code-line-prefix">-</span>
<span class="d2h-code-line-ctn">  import <del>moment</del> from '<del>moment</del>';</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-ins">
<div class="line-num1"></div>
<div class="line-num2">19</div>
</td>
<td class="d2h-ins">
<div class="d2h-code-line d2h-ins">
<span class="d2h-code-line-prefix">+</span>
<span class="d2h-code-line-ctn">  import <ins>distanceInWordsToNow</ins> from '<ins>date-fns/distance_in_words_to_now</ins>';</span>
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
<span class="d2h-code-line-ctn">  import { mapState } from 'vuex';</span>
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
<span class="d2h-code-line-ctn">  import { DRAFTS } from 'store/state_types';</span>
</div>
</td>
</tr>
<tr>
<td class="d2h-code-linenumber d2h-info"></td>
<td class="d2h-info">
<div class="d2h-code-line d2h-info">@@ -41,7 +41,7 @@</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">41</div>
<div class="line-num2">41</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">    computed: {</span>
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
<span class="d2h-code-line-ctn">      latestDraftAgo() {</span>
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
<span class="d2h-code-line-ctn">        return this.latestDraft</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-del">
<div class="line-num1">44</div>
<div class="line-num2"></div>
</td>
<td class="d2h-del">
<div class="d2h-code-line d2h-del">
<span class="d2h-code-line-prefix">-</span>
<span class="d2h-code-line-ctn">          ? <del>moment</del>(this.latestDraft.modification_date<del>).fromNow()</del></span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-ins">
<div class="line-num1"></div>
<div class="line-num2">44</div>
</td>
<td class="d2h-ins">
<div class="d2h-code-line d2h-ins">
<span class="d2h-code-line-prefix">+</span>
<span class="d2h-code-line-ctn">          ? <ins>distanceInWordsToNow</ins>(this.latestDraft.modification_date<ins>)</ins></span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">45</div>
<div class="line-num2">45</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">          : null;</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">46</div>
<div class="line-num2">46</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">      },</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">47</div>
<div class="line-num2">47</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">      latestDraft() {</span>
</div>
</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
<div class="d2h-file-wrapper" data-lang="vue" id="d2h-518269">
<div class="d2h-file-header">
<span class="d2h-file-name-wrapper">
<span class="d2h-icon-wrapper"><svg aria-hidden="true" class="d2h-icon" height="16" version="1.1" viewbox="0 0 12 16" width="12">
<path d="M6 5H2v-1h4v1zM2 8h7v-1H2v1z m0 2h7v-1H2v1z m0 2h7v-1H2v1z m10-7.5v9.5c0 0.55-0.45 1-1 1H1c-0.55 0-1-0.45-1-1V2c0-0.55 0.45-1 1-1h7.5l3.5 3.5z m-1 0.5L8 2H1v12h10V5z"></path>
</svg></span>
<span class="d2h-file-name">assets/screens/Write.vue</span>
<span class="d2h-tag d2h-changed d2h-changed-tag">CHANGED</span></span>
</div>
<div class="d2h-file-diff">
<div class="d2h-code-wrapper">
<table class="d2h-diff-table">
<tbody class="d2h-diff-tbody">
<tr>
<td class="d2h-code-linenumber d2h-info"></td>
<td class="d2h-info">
<div class="d2h-code-line d2h-info">@@ -99,7 +99,7 @@</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">99</div>
<div class="line-num2">99</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">&lt;/template&gt;</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">100</div>
<div class="line-num2">100</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">101</div>
<div class="line-num2">101</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">&lt;script lang="ts"&gt;</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-del">
<div class="line-num1">102</div>
<div class="line-num2"></div>
</td>
<td class="d2h-del">
<div class="d2h-code-line d2h-del">
<span class="d2h-code-line-prefix">-</span>
<span class="d2h-code-line-ctn">import <del>moment</del> from '<del>moment</del>';</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-ins">
<div class="line-num1"></div>
<div class="line-num2">102</div>
</td>
<td class="d2h-ins">
<div class="d2h-code-line d2h-ins">
<span class="d2h-code-line-prefix">+</span>
<span class="d2h-code-line-ctn">import <ins>distanceInWordsToNow</ins> from '<ins>date-fns/distance_in_words_to_now</ins>';</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">103</div>
<div class="line-num2">103</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">import { mapState } from 'vuex';</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">104</div>
<div class="line-num2">104</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">105</div>
<div class="line-num2">105</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">import { USER } from 'store/state_types';</span>
</div>
</td>
</tr>
<tr>
<td class="d2h-code-linenumber d2h-info"></td>
<td class="d2h-info">
<div class="d2h-code-line d2h-info">@@ -138,10 +138,11 @@ export default {</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">138</div>
<div class="line-num2">138</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">    body: computeWorkingEmail('body'),</span>
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
<span class="d2h-code-line-ctn">    draftId: computeWorkingEmail('draftId'),</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">140</div>
<div class="line-num2">140</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">    timeUntilPublish() {</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-del">
<div class="line-num1">141</div>
<div class="line-num2"></div>
</td>
<td class="d2h-del">
<div class="d2h-code-line d2h-del">
<span class="d2h-code-line-prefix">-</span>
<span class="d2h-code-line-ctn"> <del>if</del> (<del>moment.utc(this.publishDate)</del> <del>&lt;</del> <del>moment())</del> <del>{</del></span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-ins">
<div class="line-num1"></div>
<div class="line-num2">141</div>
</td>
<td class="d2h-ins">
<div class="d2h-code-line d2h-ins">
<span class="d2h-code-line-prefix">+</span>
<span class="d2h-code-line-ctn"> <ins>const</ins> <ins>utcOffset = </ins>(<ins>new</ins> <ins>Date()).getTimezoneOffset()</ins> <ins>*</ins> <ins>60 * 1000;</ins></span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-ins">
<div class="line-num1"></div>
<div class="line-num2">142</div>
</td>
<td class="d2h-ins">
<div class="d2h-code-line d2h-ins">
<span class="d2h-code-line-prefix">+</span>
<span class="d2h-code-line-ctn">      if (Date.parse(this.publishDate) - utcOffset &lt; Date.now()) {</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">142</div>
<div class="line-num2">143</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">        return 'immediately';</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">143</div>
<div class="line-num2">144</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">      }</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-del">
<div class="line-num1">144</div>
<div class="line-num2"></div>
</td>
<td class="d2h-del">
<div class="d2h-code-line d2h-del">
<span class="d2h-code-line-prefix">-</span>
<span class="d2h-code-line-ctn">      return <del>moment</del>.<del>utc</del>(this.publishDate<del>).fromNow();</del></span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-ins">
<div class="line-num1"></div>
<div class="line-num2">145</div>
</td>
<td class="d2h-ins">
<div class="d2h-code-line d2h-ins">
<span class="d2h-code-line-prefix">+</span>
<span class="d2h-code-line-ctn">      return <ins>distanceInWordsToNow(Date</ins>.<ins>parse</ins>(this.publishDate<ins>) - utcOffset);</ins></span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">145</div>
<div class="line-num2">146</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">    },</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">146</div>
<div class="line-num2">147</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">    needsBilling() {</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">147</div>
<div class="line-num2">148</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">      return this.user.settings.needs_billing_information;</span>
</div>
</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
<div class="d2h-file-wrapper" data-lang="ts" id="d2h-490984">
<div class="d2h-file-header">
<span class="d2h-file-name-wrapper">
<span class="d2h-icon-wrapper"><svg aria-hidden="true" class="d2h-icon" height="16" version="1.1" viewbox="0 0 12 16" width="12">
<path d="M6 5H2v-1h4v1zM2 8h7v-1H2v1z m0 2h7v-1H2v1z m0 2h7v-1H2v1z m10-7.5v9.5c0 0.55-0.45 1-1 1H1c-0.55 0-1-0.45-1-1V2c0-0.55 0.45-1 1-1h7.5l3.5 3.5z m-1 0.5L8 2H1v12h10V5z"></path>
</svg></span>
<span class="d2h-file-name">assets/utils.ts</span>
<span class="d2h-tag d2h-changed d2h-changed-tag">CHANGED</span></span>
</div>
<div class="d2h-file-diff">
<div class="d2h-code-wrapper">
<table class="d2h-diff-table">
<tbody class="d2h-diff-tbody">
<tr>
<td class="d2h-code-linenumber d2h-info"></td>
<td class="d2h-info">
<div class="d2h-code-line d2h-info">@@ -1,6 +1,7 @@</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">1</div>
<div class="line-num2">1</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">import each from 'lodash/each';</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">2</div>
<div class="line-num2">2</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">import marked from 'marked';</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-del">
<div class="line-num1">3</div>
<div class="line-num2"></div>
</td>
<td class="d2h-del">
<div class="d2h-code-line d2h-del">
<span class="d2h-code-line-prefix">-</span>
<span class="d2h-code-line-ctn">import <del>moment</del> from '<del>moment</del>';</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-ins">
<div class="line-num1"></div>
<div class="line-num2">3</div>
</td>
<td class="d2h-ins">
<div class="d2h-code-line d2h-ins">
<span class="d2h-code-line-prefix">+</span>
<span class="d2h-code-line-ctn">import <ins>format</ins> from '<ins>date-fns/format</ins>';</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-ins">
<div class="line-num1"></div>
<div class="line-num2">4</div>
</td>
<td class="d2h-ins">
<div class="d2h-code-line d2h-ins">
<span class="d2h-code-line-prefix">+</span>
<span class="d2h-code-line-ctn">import differenceInDays from 'date-fns/difference_in_days';</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">4</div>
<div class="line-num2">5</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">import Noty from 'noty';</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">5</div>
<div class="line-num2">6</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">6</div>
<div class="line-num2">7</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">declare const SITE_URL;</span>
</div>
</td>
</tr>
<tr>
<td class="d2h-code-linenumber d2h-info"></td>
<td class="d2h-info">
<div class="d2h-code-line d2h-info">@@ -71,7 +72,7 @@ const extractLinksFromMarkdown = markdownString =&gt; {</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">71</div>
<div class="line-num2">72</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">};</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">72</div>
<div class="line-num2">73</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">73</div>
<div class="line-num2">74</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">/* Given a raw date timestamp, format it nicely. */</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-del">
<div class="line-num1">74</div>
<div class="line-num2"></div>
</td>
<td class="d2h-del">
<div class="d2h-code-line d2h-del">
<span class="d2h-code-line-prefix">-</span>
<span class="d2h-code-line-ctn">const formatDate = date =&gt; <del>moment</del>(date<del>).format('</del>MM/DD/YYYY');</span>
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
<span class="d2h-code-line-ctn">const formatDate = date =&gt; <ins>format</ins>(date<ins>, '</ins>MM/DD/YYYY');</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">75</div>
<div class="line-num2">76</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">76</div>
<div class="line-num2">77</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">const renderMarkdownWithAllLinksAsTargetBlank = markdownString =&gt; {</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">77</div>
<div class="line-num2">78</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">  // Create a custom renderer to always use target=_blank.</span>
</div>
</td>
</tr>
<tr>
<td class="d2h-code-linenumber d2h-info"></td>
<td class="d2h-info">
<div class="d2h-code-line d2h-info">@@ -83,7 +84,10 @@ const renderMarkdownWithAllLinksAsTargetBlank = markdownString =&gt; {</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">83</div>
<div class="line-num2">84</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">  return marked(markdownString, { renderer });</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">84</div>
<div class="line-num2">85</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">};</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">85</div>
<div class="line-num2">86</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-del">
<div class="line-num1">86</div>
<div class="line-num2"></div>
</td>
<td class="d2h-del">
<div class="d2h-code-line d2h-del">
<span class="d2h-code-line-prefix">-</span>
<span class="d2h-code-line-ctn">const daysSince = dateString =&gt; <del>moment().diff</del>(<del>moment(dateString), 'days');</del></span>
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
<span class="d2h-code-line-ctn">const daysSince = dateString =&gt; <ins>differenceInDays</ins>(</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-ins">
<div class="line-num1"></div>
<div class="line-num2">88</div>
</td>
<td class="d2h-ins">
<div class="d2h-code-line d2h-ins">
<span class="d2h-code-line-prefix">+</span>
<span class="d2h-code-line-ctn">    Date.now(),</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-ins">
<div class="line-num1"></div>
<div class="line-num2">89</div>
</td>
<td class="d2h-ins">
<div class="d2h-code-line d2h-ins">
<span class="d2h-code-line-prefix">+</span>
<span class="d2h-code-line-ctn">    Date.parse(dateString),</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-ins">
<div class="line-num1"></div>
<div class="line-num2">90</div>
</td>
<td class="d2h-ins">
<div class="d2h-code-line d2h-ins">
<span class="d2h-code-line-prefix">+</span>
<span class="d2h-code-line-ctn">);</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">87</div>
<div class="line-num2">91</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">88</div>
<div class="line-num2">92</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">const siteTitle = 'Buttondown';</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">89</div>
<div class="line-num2">93</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
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
<div class="d2h-code-line d2h-info">@@ -41,6 +41,7 @@</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">41</div>
<div class="line-num2">41</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">    "cross-env": "^3.1.4",</span>
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
<span class="d2h-code-line-ctn">    "cross-spawn": "^5.0.1",</span>
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
<span class="d2h-code-line-ctn">    "css-loader": "^0.26.2",</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-ins">
<div class="line-num1"></div>
<div class="line-num2">44</div>
</td>
<td class="d2h-ins">
<div class="d2h-code-line d2h-ins">
<span class="d2h-code-line-prefix">+</span>
<span class="d2h-code-line-ctn">    "date-fns": "^1.28.5",</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">44</div>
<div class="line-num2">45</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">    "diff-match-patch": "^1.0.0",</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">45</div>
<div class="line-num2">46</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">    "email-validator": "^1.0.7",</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">46</div>
<div class="line-num2">47</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">    "emoji-regex": "^6.4.2",</span>
</div>
</td>
</tr>
<tr>
<td class="d2h-code-linenumber d2h-info"></td>
<td class="d2h-info">
<div class="d2h-code-line d2h-info">@@ -85,7 +86,6 @@</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">85</div>
<div class="line-num2">86</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">    "marked": "^0.3.6",</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">86</div>
<div class="line-num2">87</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">    "md5": "^2.2.1",</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">87</div>
<div class="line-num2">88</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">    "mocha": "^3.2.0",</span>
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
<span class="d2h-code-line-ctn">    "moment": "^2.18.1",</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">89</div>
<div class="line-num2">89</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">    "nightwatch": "^0.9.12",</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">90</div>
<div class="line-num2">90</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">    "node-sass": "latest",</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">91</div>
<div class="line-num2">91</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">    "noty": "^3.1.0-beta",</span>
</div>
</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
<div class="d2h-file-wrapper" data-lang="json" id="d2h-704695">
<div class="d2h-file-header">
<span class="d2h-file-name-wrapper">
<span class="d2h-icon-wrapper"><svg aria-hidden="true" class="d2h-icon" height="16" version="1.1" viewbox="0 0 12 16" width="12">
<path d="M6 5H2v-1h4v1zM2 8h7v-1H2v1z m0 2h7v-1H2v1z m0 2h7v-1H2v1z m10-7.5v9.5c0 0.55-0.45 1-1 1H1c-0.55 0-1-0.45-1-1V2c0-0.55 0.45-1 1-1h7.5l3.5 3.5z m-1 0.5L8 2H1v12h10V5z"></path>
</svg></span>
<span class="d2h-file-name">webpack-stats.json</span>
<span class="d2h-tag d2h-changed d2h-changed-tag">CHANGED</span></span>
</div>
<div class="d2h-file-diff">
<div class="d2h-code-wrapper">
<table class="d2h-diff-table">
<tbody class="d2h-diff-tbody">
<tr>
<td class="d2h-code-linenumber d2h-info"></td>
<td class="d2h-info">
<div class="d2h-code-line d2h-info">@@ -1 +1 @@</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-del">
<div class="line-num1">1</div>
<div class="line-num2"></div>
</td>
<td class="d2h-del">
<div class="d2h-code-line d2h-del">
<span class="d2h-code-line-prefix">-</span>
<span class="d2h-code-line-ctn">{"status":"done","chunks":{"main":[{"name":"main-<del>fac5e0e7c6f62e7e200c</del>.js","path":"/Users/jmduke/workspaces/buttondown/assets/webpack_bundles/main-<del>fac5e0e7c6f62e7e200c</del>.js<del>"}]},"error</del>":"<del>ModuleError</del>","<del>message":"\n</del>/Users/jmduke/workspaces/buttondown/assets/<del>store</del>/<del>actions</del>.js<del>\n  61:5   warning  Unexpected console statement  no</del>-<del>console\n  61:30  </del>error<del>    Missing</del> <del>semicolon             semi\n\n✖</del> <del>2</del> <del>problems</del> <del>(1</del> <del>error,</del> <del>1 warning)\n"}</del></span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-ins">
<div class="line-num1"></div>
<div class="line-num2">1</div>
</td>
<td class="d2h-ins">
<div class="d2h-code-line d2h-ins">
<span class="d2h-code-line-prefix">+</span>
<span class="d2h-code-line-ctn">{"status":"done","<ins>publicPath":"/static/webpack_bundles/","</ins>chunks":{"<ins>zxcvbn":[{"name":"zxcvbn-376b5b3616c0f1ab29a7.js","publicPath":"/static/webpack_bundles/zxcvbn-376b5b3616c0f1ab29a7.js","path":"/Users/jmduke/workspaces/buttondown/assets/webpack_bundles/zxcvbn-376b5b3616c0f1ab29a7.js"}],"flatpickr":[{"name":"flatpickr-376b5b3616c0f1ab29a7.js","publicPath":"/static/webpack_bundles/flatpickr-376b5b3616c0f1ab29a7.js","path":"/Users/jmduke/workspaces/buttondown/assets/webpack_bundles/flatpickr-376b5b3616c0f1ab29a7.js"}],"</ins>main":[{"name":"main-<ins>376b5b3616c0f1ab29a7</ins>.js","<ins>publicPath":"/static/webpack_bundles/main-376b5b3616c0f1ab29a7.js","</ins>path":"/Users/jmduke/workspaces/buttondown/assets/webpack_bundles/main-<ins>376b5b3616c0f1ab29a7</ins>.js<ins>"}],"miscellany":[{"name</ins>":"<ins>miscellany-376b5b3616c0f1ab29a7.js</ins>","<ins>publicPath":"/static</ins>/<ins>webpack_bundles/miscellany-376b5b3616c0f1ab29a7.js","path":"/</ins>Users/jmduke/workspaces/buttondown/assets/<ins>webpack_bundles</ins>/<ins>miscellany-376b5b3616c0f1ab29a7</ins>.js<ins>"},{"name":"miscellany.css","publicPath":"/static/webpack_bundles/miscellany.css","path":"/Users/jmduke/workspaces/buttondown/assets/webpack_bundles/miscellany.css"}]},"error":"unknown</ins>-error<ins>","message":"(3,20):</ins> <ins>error</ins> <ins>TS2307:</ins> <ins>Cannot</ins> <ins>find</ins> <ins>module</ins> <ins>'moment'."}</ins></span>
</div>
</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
<div class="d2h-file-wrapper" data-lang="lock" id="d2h-526891">
<div class="d2h-file-header">
<span class="d2h-file-name-wrapper">
<span class="d2h-icon-wrapper"><svg aria-hidden="true" class="d2h-icon" height="16" version="1.1" viewbox="0 0 12 16" width="12">
<path d="M6 5H2v-1h4v1zM2 8h7v-1H2v1z m0 2h7v-1H2v1z m0 2h7v-1H2v1z m10-7.5v9.5c0 0.55-0.45 1-1 1H1c-0.55 0-1-0.45-1-1V2c0-0.55 0.45-1 1-1h7.5l3.5 3.5z m-1 0.5L8 2H1v12h10V5z"></path>
</svg></span>
<span class="d2h-file-name">yarn.lock</span>
<span class="d2h-tag d2h-changed d2h-changed-tag">CHANGED</span></span>
</div>
<div class="d2h-file-diff">
<div class="d2h-code-wrapper">
<table class="d2h-diff-table">
<tbody class="d2h-diff-tbody">
<tr>
<td class="d2h-code-linenumber d2h-info"></td>
<td class="d2h-info">
<div class="d2h-code-line d2h-info">@@ -2099,6 +2099,10 @@ data-uri-to-buffer@1:</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">2099</div>
<div class="line-num2">2099</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">  version "1.2.0"</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">2100</div>
<div class="line-num2">2100</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">  resolved "https://registry.yarnpkg.com/data-uri-to-buffer/-/data-uri-to-buffer-1.2.0.tgz#77163ea9c20d8641b4707e8f18abdf9a78f34835"</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">2101</div>
<div class="line-num2">2101</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-ins">
<div class="line-num1"></div>
<div class="line-num2">2102</div>
</td>
<td class="d2h-ins">
<div class="d2h-code-line d2h-ins">
<span class="d2h-code-line-prefix">+</span>
<span class="d2h-code-line-ctn">date-fns@^1.28.5:</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-ins">
<div class="line-num1"></div>
<div class="line-num2">2103</div>
</td>
<td class="d2h-ins">
<div class="d2h-code-line d2h-ins">
<span class="d2h-code-line-prefix">+</span>
<span class="d2h-code-line-ctn">  version "1.28.5"</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-ins">
<div class="line-num1"></div>
<div class="line-num2">2104</div>
</td>
<td class="d2h-ins">
<div class="d2h-code-line d2h-ins">
<span class="d2h-code-line-prefix">+</span>
<span class="d2h-code-line-ctn">  resolved "https://registry.yarnpkg.com/date-fns/-/date-fns-1.28.5.tgz#257cfc45d322df45ef5658665967ee841cd73faf"</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-ins">
<div class="line-num1"></div>
<div class="line-num2">2105</div>
</td>
<td class="d2h-ins">
<div class="d2h-code-line d2h-ins">
<span class="d2h-code-line-prefix">+</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">2102</div>
<div class="line-num2">2106</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">date-now@^0.1.4:</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">2103</div>
<div class="line-num2">2107</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">  version "0.1.4"</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">2104</div>
<div class="line-num2">2108</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">  resolved "https://registry.yarnpkg.com/date-now/-/date-now-0.1.4.tgz#eaf439fd4d4848ad74e5cc7dbef200672b9e345b"</span>
</div>
</td>
</tr>
<tr>
<td class="d2h-code-linenumber d2h-info"></td>
<td class="d2h-info">
<div class="d2h-code-line d2h-info">@@ -5142,10 +5146,6 @@ mocha@^3.2.0:</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">5142</div>
<div class="line-num2">5146</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">    mkdirp "0.5.1"</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">5143</div>
<div class="line-num2">5147</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">    supports-color "3.1.2"</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">5144</div>
<div class="line-num2">5148</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-del">
<div class="line-num1">5145</div>
<div class="line-num2"></div>
</td>
<td class="d2h-del">
<div class="d2h-code-line d2h-del">
<span class="d2h-code-line-prefix">-</span>
<span class="d2h-code-line-ctn">moment@^2.18.1:</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-del">
<div class="line-num1">5146</div>
<div class="line-num2"></div>
</td>
<td class="d2h-del">
<div class="d2h-code-line d2h-del">
<span class="d2h-code-line-prefix">-</span>
<span class="d2h-code-line-ctn">  version "2.18.1"</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-del">
<div class="line-num1">5147</div>
<div class="line-num2"></div>
</td>
<td class="d2h-del">
<div class="d2h-code-line d2h-del">
<span class="d2h-code-line-prefix">-</span>
<span class="d2h-code-line-ctn">  resolved "https://registry.yarnpkg.com/moment/-/moment-2.18.1.tgz#c36193dd3ce1c2eed2adb7c802dbbc77a81b1c0f"</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-del">
<div class="line-num1">5148</div>
<div class="line-num2"></div>
</td>
<td class="d2h-del">
<div class="d2h-code-line d2h-del">
<span class="d2h-code-line-prefix">-</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">5149</div>
<div class="line-num2">5149</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">ms@0.7.1:</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">5150</div>
<div class="line-num2">5150</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">  version "0.7.1"</span>
</div>
</td>
</tr><tr>
<td class="d2h-code-linenumber d2h-cntx">
<div class="line-num1">5151</div>
<div class="line-num2">5151</div>
</td>
<td class="d2h-cntx">
<div class="d2h-code-line d2h-cntx">
<span class="d2h-code-line-prefix"> </span>
<span class="d2h-code-line-ctn">  resolved "https://registry.yarnpkg.com/ms/-/ms-0.7.1.tgz#9cd13c03adbff25b65effde7ce864ee952017098"</span>
</div>
</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
</div>
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
<p>As you can see, nothing too crazy.  A couple notes:</p>
<ul>
<li>Half of the stuff is straight-up API parity, like <code>format</code> adn <code>distance_in_words</code>.</li>
<li>The only tricky part was replacing <code>moment.utc</code>, since it didn’t seem like <code>date-fns</code> had that much timezone support.  (It’s also entirely possible there is a much easier way to do this that eluded me.)</li>
<li>Buttondown’s bundle is now 150 kilobytes thinner. 🎉</li>
</ul>
<p>So, yeah!  Check out <code>date-fns</code>.  It’s very nice.  I would still like to take another stab at unifying Buttondown’s use of datetime (just to make migrations like this easier in the future), but I’m super happy with how pleasant (and rewarding) this process was.</p>

	