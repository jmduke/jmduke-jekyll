---
title: "A nice little list of valid and invalid email addresses"
Date: 2017-07-21 00:00:00
Tags: ["development","email me"]
layout: post
---

<p>I’ve been spending a lot of time working on <a href="https://buttondown.email">Buttondown</a> lately and, as you might expect for a newsletter app, lots of this work revolves around dealing with email addresses.</p>


<p>In an effort to save myself and others some time, I’m trying to collate a list of usefully distinct and weird invalid and valid addresses for test harnesses and such.  Below is what I have so far: it’s not a complete set, but it’s comprehensive enough to handle most of the weirdnesses out there.</p>


<!--more-->

<p></p>


<h2 id="valid-addresses">Valid addresses</h2>


<pre><code>foo@baz.com
foo.bar@baz.com
foo@bar.baz.com
foo+bar@baz.com
foo@123.456.789.123
foo@[123.456.789.123]
"foo"@baz.com
123456789@baz.com
foo@baz-quz.com
_@baz.com
________@baz.com
foo@baz.name
foo@baz.co.uk
foo-bar@baz.com
foo."bar\ qux"@baz.com
foo.bar."bux".bar.com@baz.com
baz.com@baz.com
foo.bar+qux@baz.com
foo.bar-qux@baz.com
foo.bar@baz.com.
f@baz.com
"foo.(),:;&lt;&gt;[]\".FOO.\"foo@\\ \"FOO\".foo"@baz.qux.com
" "@baz.com
_foo@baz.com
foo/bar=qux@baz.com
foo."bar"@baz.com
foo@bar--baz.com
foob*ar@baz.com
"foo@bar"@baz.com
</code></pre>


<h2 id="invalid-addresses">Invalid addresses</h2>


<pre><code>foo
#@%^%#$@#$@#.com
@baz.com
Jane Doe &lt;foo@baz.com&gt;
qux.baz.com
foo@bar@baz.com
.foo@baz.com
foo.@baz.com
foo..bar@baz.com
あいうえお@baz.com
foo@baz.com (Jane Doe)
foo@baz
foo@-baz.com
foo@baz.qux
foo@123.456.789.12345
foo@baz..com
foo..123456@baz.com
a"b(c)d,e:f;g&lt;h&gt;I[j\k]l@baz.com 
foofoofoofoofoofoofoofoofoofoofoofoofoofoofoofoofoofoofoofoofoofoofoofoofoofoo@baz.com
foo bar@baz.com
foo@baz.com-
foo@baz,qux.com
foo\@bar@baz.com
foo.bar
@
@@
.@
</code></pre>


<h3 id="references">References</h3>


<ul>
<li><a href="http://codefool.tumblr.com/post/15288874550/list-of-valid-and-invalid-email-addresses">http://codefool.tumblr.com/post/15288874550/list-of-valid-and-invalid-email-addresses</a></li>
<li><a href="https://en.wikipedia.org/wiki/Email_address#Valid_email_addresses">https://en.wikipedia.org/wiki/Email_address#Valid_email_addresses</a></li>
<li><a href="http://code.iamcal.com/php/rfc822/tests/">http://code.iamcal.com/php/rfc822/tests/</a></li>
<li><a href="https://fightingforalostcause.net/content/misc/2006/compare-email-regex.php">https://fightingforalostcause.net/content/misc/2006/compare-email-regex.php</a></li>
</ul>
	