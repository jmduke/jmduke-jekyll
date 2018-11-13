---
Title: "Ten lines of code"
Date: 2014-10-01 00:00:00
Tags: ["development","personal"]
---

<p>Working in a big company is about depth.  It’s inevitable, given the math: given X thousand programmers, your individual work as a programming generally averages out to some multiple of one thousandth of the entire surface area of the company.</p>


<p>This is generally pretty awesome (as I’ve <a href="http://jmduke.com/posts/depth-and-whitespace/">talked about before</a>).</p>


<p>It means that the seemingly mundane parts of programming suddenly deserve intense thought and analysis.</p>


<p>It means picking away at the bad scabs of a utility method that might be fine for a side project or problem set but you can see where it might cause problems two years down the line because hey, you’re gonna have to worry about it two years down the line.</p>


<p>It means worrying about the extra 30 milliseconds on that unnecessary service call because, hey, 30 milliseconds is a lot when you’re struggling at 50 TPS per host.  <sup class="footnote-ref" id="fnref:1"><a href="#fn:1" rel="footnote">1</a></sup></p>


<p>It also means that, in any given class, ten lines of code doesn’t do particularly much.  It might handle something relatively mundane like request validation; it might be something like centrally logic.  But you’re probably not accomplishing anything too crazy in ten lines of production-quality code.</p>


<p>Ten lines of code can do a shit-ton, though.</p>


<p>Ten lines of AppleScript <sup class="footnote-ref" id="fnref:2"><a href="#fn:2" rel="footnote">2</a></sup> can check if your selected text fits in a tweet.  Which seems like a dumb thing – <em>hurrrr, just copy it into the Tweet box!</em> – but when you have to check it fifty times a day, those seconds add up into (billable) hours pretty quickly:</p>


<pre><code>tell application "System Events"
    keystroke "c" using command down
end tell
delay 0.5
set myChars to count (the clipboard)

if myChars ≤ 140 then
    do shell script "afplay /System/Library/Sounds/Glass.aiff"
else
    do shell script "afplay /System/Library/Sounds/Purr.aiff"
end if
</code></pre>


<p>Ten lines of Python <sup class="footnote-ref" id="fnref:3"><a href="#fn:3" rel="footnote">3</a></sup> can parse a flat list of outputted CRM files for an important match and print out the tallies, which is something that would be a relatively agonizing task without scripting:</p>


<pre><code>import os

directory_to_search = "."
search_string = "~!~"

possible_files = os.listdir(directory_to_search)
for current_file in possible_files:
  occurences = 0
  try:
    with open(current_file) as f:
      for line in f:
        occurences += line.count(search_string)
  print(current_file + ": " + str(occurences))
</code></pre>


<p>Both of these are, even in a slightly grand scheme of things, trivial tasks: I was asked if I could code them and it seemed like <em>well, sure</em>, almost as if it was beneath me.  But the truth is, I love doing this stuff – no deployments with fallback sanity checks, no thread safety auditing, just a one-off bit of magic that makes people’s lives easier.  It’s why I got into programming in the first place, tinkering with Geocities and AngelFire so many years ago – at the end of the day, it’s the #1 reason why I still love it.</p>


<p>Sure, the habit of doing this software thing for a career has shifted me much more significantly into the realm of Serious Development where it is important to do things well, to do things right, and to do things completely.  And that usually requires a lot.</p>


<p>But you can still do things pretty awesome with ten lines of code.</p>


<p>(Thanks to Molly and Ben for inspiring this.)</p>


<div class="footnotes">
<hr/>
<ol>
<li id="fn:1">I know this isn’t even a huge rate, but there’s a part of me who still thinks programming anything more intense than my Geocities guestbook plugin is beyond my realm.
 <a class="footnote-return" href="#fnref:1"><sup>[return]</sup></a></li>
<li id="fn:2">AppleScript is insane.  It’s like piloting the Death Star with an NES controller.
 <a class="footnote-return" href="#fnref:2"><sup>[return]</sup></a></li>
<li id="fn:3">Granted, you could do this in a shell one-liner, which merits a post all by itself.
 <a class="footnote-return" href="#fnref:3"><sup>[return]</sup></a></li>
</ol>
</div>
	