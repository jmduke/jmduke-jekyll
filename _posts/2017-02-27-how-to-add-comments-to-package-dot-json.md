---
title: "Adding comments to package.json"
Date: 2017-02-27 00:00:00
Tags: ["javascript"]
layout: post
---

<p>Comments are good.</p>


<p>Comments in dense, labrynthine files like <code>package.json</code> are <em>especially</em> good.</p>


<p>But comments in JSON are… if not bad, then hard.</p>


<p>When I was adding <a href="https://facebook.github.io/jest/">Jest</a> as a front-end test suite for work, I wanted a way to
explain the weird regex we use for finding test files efficiently. Unfortunately, JSON (and NPM’s parsing of <code>package.json</code>)
is persnickety, and doing something like this fails:</p>


<pre><code>{
  "name": "packageName",
  "version": "0.0.0",
  "scripts": {},
  "jest": {
      // The default testRegex has a | in the middle there -- it grabs everything
      // in __test__ and checks all folders recursively for .spec. or .test. This
      // combo of the two works better from an org standpoint and is noticeably
      // faster.
    "testRegex": "(/__tests__/.*(\\.|/)(test|spec))\\.jsx?$"
  },
  "dependencies": {},
  "devDependencies": {}
}
</code></pre>


<p>This is invalid JSON, and thus NPM is totally correct in rejecting it.</p>


<p>But how do we add comments, then?</p>


<p>I found the answer in a <a href="https://groups.google.com/forum/#!msg/nodejs/NmL7jdeuw0M/yTqI05DRQrIJ">discussion on the node.js mailing list</a></p>


<blockquote>
<p>As long as I have a say in the matter, package.json file will always
  be json.  If anything, future versions of npm and node will <em>remove</em>
  features rather than add them.  (I’m looking at you, <code>scripts.install</code>
  ;)</p>
<p>That being said, I completely understand the desire to put additional
  data into your JSON configuration files.  That’s why the “//” key will
  never be used by npm for any purpose, and is reserved for comments.</p>
<p>If you want to use a multiple line comment, you can use either an
  array, or multiple “//” keys.</p>
<p>{ “//”: “this is the first line of a comment”,
   “//”: “this is the second line of the comment” }</p>
<p>{ “//”: [
   “first line”,
   “second line” ] }</p>
</blockquote>


<p>Awesome!  I was able to tailor this to my needs like so:</p>


<pre><code>{
  "name": "packageName",
  "version": "0.0.0",
  "scripts": {},
  "jest": {
    "//": [
      "The default testRegex has a | in the middle there -- it grabs everything",
      "in __test__ and checks all folders recursively for .spec. or .test. This",
      " combo of the two works better from an org standpoint and is noticeably",
      "faster."
    ],
    "testRegex": "(/__tests__/.*(\\.|/)(test|spec))\\.jsx?$"
  },
  "dependencies": {},
  "devDependencies": {}
}
</code></pre>


<p>It’s a little clumsy, but works like a charm.</p>
	