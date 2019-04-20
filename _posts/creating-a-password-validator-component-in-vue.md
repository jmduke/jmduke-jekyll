---
title: "Creating a password validator component in Vue"
Date: 2017-08-13 00:00:00
Tags: ["vue"]
layout: post
---

<p>Sometimes you procrastinate one feature by writing another.  Even if that other feature is pretty small and inconsequential. <sup class="footnote-ref" id="fnref:1"><a href="#fn:1" rel="footnote">1</a></sup></p>


<p>For me, that <em>other</em> feature — if you can even call it a feature — was password strength testing for <a href="http://buttondown.email">Buttondown</a>.</p>


<p></p>


<p>This is one of those things that I always liked on other sites, but didn’t really know how to implement myself!</p>

<!--more-->


<p>Turns out, the answer is “you let another library do all the heavy lifting”.  That other library is <a href="https://github.com/dropbox/zxcvbn">zxcvbn</a> by the fine folks at Dropbox: you can just pass in a string and it will return analysis on that string, including a <code>strength</code> (ranging from 0 to 4).  Then all you have to do is write a little component like this:</p>


<pre><code>&lt;template&gt;
  &lt;span class="tiny"&gt;
      &lt;pending-indicator :pending="pending" /&gt;
      &lt;span v-if="!pending"&gt;
        &lt;span class="error" v-if="strength === 0"&gt;Please choose a longer password.&lt;/span&gt;
        &lt;span class="error" v-if="strength === 1"&gt;Please choose a longer password.&lt;/span&gt;
        &lt;span class="warning" v-if="strength === 2"&gt;Better... but not quite enough.&lt;/span&gt;
        &lt;span class="info" v-if="strength === 3"&gt;This is a good password.&lt;/span&gt;
        &lt;span class="success" v-if="strength === 4"&gt;Great!  This is a secure password.&lt;/span&gt;
      &lt;/span&gt;
  &lt;/span&gt;
&lt;/template&gt;

&lt;script&gt;
  import _ from 'lodash';
  import zxcvbn from 'zxcvbn';

  export default {
    props: {
      password: String,
      onStrengthUpdate: Function,
    },

    data() {
      return {
        strength: null,
        checkedPassword: String,
      };
    },

    computed: {
      pending() {
        return !!this.password.length &amp;&amp; this.checkedPassword !== this.password;
      },
    },

    watch: {
      password: _.debounce(async function () {
        this.strength = zxcvbn(this.password).score;
        this.checkedPassword = this.password;
      }, 500),
      strength(strength) { this.onStrengthUpdate(strength); },
    },
  };
&lt;/script&gt;
</code></pre>


<p>A couple pieces of note:</p>


<ul>
<li><code>pending-indicator</code> is just a tiny component that returns a spinning icon when <code>pending</code> is true.</li>
<li>We debounce the watcher and cache the last-checked password in <code>checkedPassword</code> to avoid re-running the method every time the user types a single character.</li>
<li><code>onStrengthUpdate</code> can be used by the parent component to conditionally disable registration.</li>
</ul>


<p>And that’s it!  It’s super simple. Here it is in action:</p>


<p><img alt="" src="http://i.imgur.com/AFGf4m7.gif"/>
<figcaption>The finished product.</figcaption></p>


<div class="footnotes">
<hr/>
<ol>
<li id="fn:1">Okay, <em>especially</em> if that feature is pretty small and inconsequential.
 <a class="footnote-return" href="#fnref:1"><sup>[return]</sup></a></li>
</ol>
</div>
	