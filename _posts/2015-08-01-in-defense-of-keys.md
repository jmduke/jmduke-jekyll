---
title: "In defense of keys"
Date: 2015-08-01 00:00:00
Tags: ["design"]
layout: post
---

<p>I’ve been going through <a href="http://www.amazon.com/Design-Everyday-Things-Donald-Norman/dp/1452654123">The Design of Everyday Things</a> by Donald Norman over the past couple days, which has been an absolute revelation and transformed the way I’ve been looking at technology. <sup class="footnote-ref" id="fnref:1"><a href="#fn:1" rel="footnote">1</a></sup>  Some great highlights, though if you define your career in any proximity to technology you owe it to yourself to read the entire book.</p>


<p><strong>On who we blame when we can’t get things to work:</strong></p>


<blockquote>
<p>It is the duty of machines and those who design them to understand people. It is not our duty to understand the arbitrary, meaningless dictates of machines.</p>
</blockquote>


<p><strong>On the tendency of technology to grow more complex <sup class="footnote-ref" id="fnref:4"><a href="#fn:4" rel="footnote">2</a></sup></strong>:</p>


<blockquote>
<p>The same technology that simplifies life by providing more functions in each device also complicates life by making the device harder to learn, harder to use. This is the paradox of technology and the challenge for the designer.</p>
</blockquote>


<p><strong>On society’s dependence on technology:</strong></p>


<blockquote>
<p>What does all of this mean? Is this bad or good? It is not a new phenomenon. Take away our gas supply and electrical service and we might starve. Take away our housing and clothes and we might freeze. We rely on commercial stores, transportation, and government services to provide us with the essentials for living. Is this bad? The partnership of technology and people makes us smarter, stronger, and better able to live in the modern world. We have become reliant on the technology and we can no longer function without it. The dependence is even stronger today than ever before, including mechanical, physical things such as housing, clothing, heating, food preparation and storage, and transportation. Now this range of dependencies is extended to information services as well: communication, news, entertainment, education, and social interaction. When things work, we are informed, comfortable, and effective. When things break, we may no longer be able to function. This dependence upon technology is very old, but every decade, the impact covers more and more activities.</p>
</blockquote>


<p>In what is likely an elegant coincidence of two independent paths reaching the same pleasant solution, Donald Norman aligns itself with the same philosophy that has informed the design and maintenance of Unix tools.  From Doug McIlroy:</p>


<blockquote>
<p>This is the Unix philosophy: Write programs that do one thing and do it well. Write programs to work together. Write programs to handle text streams, because that is a universal interface.  The notion of “intricate and beautiful complexities” is almost an oxymoron. Unix programmers vie with each other for “simple and beautiful” honors — a point that’s implicit in these rules, but is well worth making overt.</p>
</blockquote>


<p>Both advocate for simplicity and ease of use as fundamental design goals.  For Norman, it’s because it leads to the best possible user experience; for McIlroy, it’s because it lends itself to modularity and longevity.  I’m beginning to understand that these aren’t separate goals, but two lovely outcomes of the same accomplishment <sup class="footnote-ref" id="fnref:2"><a href="#fn:2" rel="footnote">3</a></sup> – that the same design patterns which make an outstanding experience for a user will, when applied properly, also make an outstanding experience for the developer.</p>


<p>But Norman highlights one of the biggest difficulties of this when he discusses a better version of a key and lock for your apartment:</p>


<blockquote>
<p>Note that a superior solution would be to solve the fundamental need—solving the root need. After all, we don’t really care about keys and locks: what we need is some way of ensuring that only authorized people can get access to whatever is being locked. Instead of redoing the shapes of physical keys, make them irrelevant. Once this is recognized, a whole set of solutions present themselves: combination locks that do not require keys, or keyless locks that can be operated only by authorized people. One method is through possession of an electronic wireless device, such as the identification badges that unlock doors when they are moved close to a sensor, or automobile keys that can stay in the pocket or carrying case. Biometric devices could identify the person through face or voice recognition, fingerprints, or other biometric measures, such as iris patterns.</p>
</blockquote>


<p>The <a href="https://lockitron.com/">Lockitron</a> solution Norman proposes is a good one, and in many ways an improvement on the current paradigm.  But the introduction of a layer of additional technology is always problematic – suddenly your deadbolt needs batteries, suddenly you can’t hand your spare key to your friend across the street or your cleaner, suddenly your key can run out of power on your commute back home.  The leap of faith of trusting a third-party service with your safety is one that, in 2015, I don’t think I’m ready to make.  <sup class="footnote-ref" id="fnref:3"><a href="#fn:3" rel="footnote">4</a></sup></p>


<p>Which is like, not to say that biometric or smartphone-based locking mechanisms are alone in these problems of sharing or security.  I can still lose my keys (or, even worse, have them stolen); I can’t duplicate them on a whim, and the act of me fumbling to find the correct key on my keychain every morning and evening is probably worth a design chapter in of itself.  And the Lockitron solutions of the world don’t have to be perfect, they just need to be an improvement – and they need to do what they do very well, with consideration not just to the root need but all of the other complications, too.</p>


<div class="footnotes">
<hr/>
<ol>
<li id="fn:1">Which is to say – I am both crankier and more optimistic than ever before.
 <a class="footnote-return" href="#fnref:1"><sup>[return]</sup></a></li>
<li id="fn:4">AKA <a href="http://www.catb.org/jargon/html/Z/Zawinskis-Law.html">Zawinski’s Law</a>.
 <a class="footnote-return" href="#fnref:4"><sup>[return]</sup></a></li>
<li id="fn:2">There’s also considerable overlap with Rams’ <a href="https://www.vitsoe.com/us/about/good-design">ten principles for good design</a>.
 <a class="footnote-return" href="#fnref:2"><sup>[return]</sup></a></li>
<li id="fn:3">This is to say nothing of one of the unspoken tenets of good design: that it is inexpensive.  Lockitron sells for $99.
 <a class="footnote-return" href="#fnref:3"><sup>[return]</sup></a></li>
</ol>
</div>
	