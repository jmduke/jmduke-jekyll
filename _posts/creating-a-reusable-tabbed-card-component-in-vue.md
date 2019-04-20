---
title: "Creating a reusable tabbed card component in Vue"
Date: 2017-08-06 00:00:00
Tags: []
layout: post
---

<p>I built <a href="https://buttondown.email">a thing for Buttondown</a> that lets you embed an iFrame to handle subscriptions really nicely:</p>


<p></p>
<blockquote class="twitter-tweet" data-lang="en"><p dir="ltr" lang="en">Changelog entry coming shortly, but pretty pumped about this — embeddable subscription widgets! <a href="https://t.co/uf2UjQILZt">pic.twitter.com/uf2UjQILZt</a></p>— Buttondown (@buttondownemail) <a href="https://twitter.com/buttondownemail/status/894236850767843328">August 6, 2017</a></blockquote>


<script async="" charset="utf-8" src="//platform.twitter.com/widgets.js"></script>


<!--more-->

<p>
This thing necessitated a change in the UI: The current share page was pretty gross (below), and this was going to make it grosser:</p>


<p><img alt="" src="http://i.imgur.com/Z7UvPM0.png"/>
<figcaption>The old Share page.  Not super elegant. </figcaption></p>


<p>I am admittedly not a great designer, and whenever I need to change UI I go spelunking in Bootstrap to see if I can find a paradigm that I like.</p>


<p>And I found something great! Bootstrap <a href="https://v4-alpha.getbootstrap.com/components/card/#navigation">cards with tabbed navigation</a> ended up looking really great:</p>


<p><img alt="" src="http://i.imgur.com/UHwvE4b.png"/>
<figcaption>The Bootstrap component. So pretty!</figcaption></p>


<p>I don’t actually include Bootstrap in Buttondown, though. A lot of its design cues are taken from it (and some things, like modals, are almost identically styled), but I didn’t want to deal with the additional CSS + JS overhead, especially because the jQuery-esque way of handling interactivity seems anti-Vue.</p>


<p>This seemed like a job for a Vue components: I really wanted to be able to just have a <code>tabbed-card</code> component that I could then add various dynamic tabs with transclusion.</p>


<p>Turns out, you can!  The code isn’t even that complicated: the trick is using dynamic <code>slot</code> names to handle the work for you.  You still have to pass in a list of tab names as a prop, but I think that’s totally reasonable.</p>


<p>Here’s what the TabbedCard component looks like:</p>


<pre><code>&lt;template&gt;
  &lt;div class="card"&gt;
    &lt;div class="card-header"&gt;
      &lt;ul class="card-nav nav-tabs card-header-tabs"&gt;
        &lt;li class="nav-item" v-for="tab in tabs"&gt;
          &lt;a
            :class="activeTab === tab ? 'nav-link active' : 'nav-link'"
            href="#"
            @click="(e) =&gt; activeTab = tab"
          &gt;
            {{ tab }}
          &lt;/a&gt;
        &lt;/li&gt;
      &lt;/ul&gt;
    &lt;/div&gt;
    &lt;div class="card-block"&gt;
      &lt;slot :name="tab" v-for="tab in tabs" v-if="tab === activeTab" /&gt;
    &lt;/div&gt;
  &lt;/div&gt;
&lt;/template&gt;

&lt;script&gt;
  export default {
    props: {
      tabs: Array,
    },

    data() {
      return {
        activeTab: this.tabs[0],
      };
    },

  };
&lt;/script&gt;
</code></pre>


<p>And here’s how I invoke it, in the Share screen:</p>


<pre><code>&lt;tabbed-card :tabs="['as a link', 'as a form', 'as an iFrame']"&gt;
  &lt;div slot="as a link"&gt;
    &lt;!-- Stuff. --&gt;
  &lt;/div&gt;

  &lt;div slot="as a form"&gt;
    &lt;!-- Stuff. --&gt;
  &lt;/div&gt;

  &lt;div slot="as an iFrame"&gt;
    &lt;!-- Stuff.--&gt;
  &lt;/div&gt;
&lt;/tabbed-card&gt;
</code></pre>


<p>This ends up being simple, and just leverages props and Vue’s <a href="https://vuejs.org/v2/guide/components.html#Content-Distribution-with-Slots">transclusion</a> functionality: we provide a <code>tabs</code> array, which creates both the actual tabs and a bunch of slots for content to go into.  This is nice separation of concerns: the screen declaring the tabbed card doesn’t know about how the tabbed card is formed, it just supplies a list of tabs and content for each tab.</p>


<p>And here’s the finished product:</p>


<p><img alt="Imgur" src="http://i.imgur.com/izAcy6J.gif"/></p>


<p>This is nothing groundbreaking, to be sure, but it’s really elegant and re-usable.  It makes me happy when Vue makes it easy to create clean, maintainable components — it makes me feel like I’m doing the right thing, which can be an elusive feeling in software.</p>
	