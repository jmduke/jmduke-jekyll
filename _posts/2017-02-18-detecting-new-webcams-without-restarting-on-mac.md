---
title: "Detecting new webcams without restarting on Mac"
Date: 2017-02-18 00:00:00
Tags: ["mac"]
layout: post
---

<p>Okay, this is a small and trivial post for a small and trivial issue.</p>


<p>If you are like me, you have:</p>


<ul>
<li>The built-in webcam in your MacBook</li>
<li>A better, external webcam on top of your external monitor.</li>
</ul>


<p>The problem is that when you plug in that second one (which I have to do a couple times a day, because my laptop rarely
stays plugged into all of its peripherals), the laptop can’t recognize it without restarting.</p>


<p>And I <em>hate</em> restarting my laptop.</p>


<p>So here’s what you do:</p>


<p><strong>First</strong>, you open Terminal.</p>


<p><strong>Second</strong>, you type the two magic lines (hitting enter and possibly filling out your password after each one):</p>


<pre><code>sudo killall VDCAssistant
sudo killall AppleCameraAssistant
</code></pre>


<p>Voilà!</p>


<p>This kills the builtin webcam processes running on macOS, forcing the computer to restart them (and picking up the new
devices in the process!)</p>


<p>You might have to relaunch the tab or application that was using the webcam, but that’s it.</p>


<p>I hope this saves you a couple minutes of annoyance: it certainly has for me.</p>
	