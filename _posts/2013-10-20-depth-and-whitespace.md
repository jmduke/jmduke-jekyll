---
Title: "Depth and whitespace"
Date: 2013-10-20 00:00:00
Tags: ["development"]
layout: post
---

<p>I got to write the following unit test this week at work:</p>


<pre><code>@Test
public void testIsWhitespace() {
    Word weirdWhitespace = new Word(" ");
    assertFalse(!StringUtils.hasText(weirdWhitespace.getText()));
    assertFalse(weirdWhitespace.getText().trim().length() == 0);
    assertTrue(weirdWhitespace.isWhitespace());

    Word normalWhitespace = new Word(" ");
    assertTrue(!StringUtils.hasText(weirdWhitespace.getText()));
    assertTrue(weirdWhitespace.getText().trim().length() == 0);
    assertTrue(weirdWhitespace.isWhitespace());
}
</code></pre>


<p>So what exactly is going on here?  How does that possibly pass all of the assertions?</p>


<p>To spare you the three hours I spent switching between searching online and beating the head against the keyboard: there’s more to <code>weirdWhitespace</code> than meets the eye.  It’s the unicode representation of a non-breaking whitespace, or what front-end developers know fondly as <code>&amp;nbsp;</code> – Java’s standard list of whitespace character excludes this little fella, and as a result any builtin methods based off that standard list wouldn’t recognize this character as whitespace.</p>


<p>(This also means that if you were to try and split a long block of text into words based off of whitespace, this would be considered it’s own word.  You can imagine why that might make things tricky, and you can also probably imagine why I had to implement <code>isWhitespace()</code>.)</p>


<p>Working at Amazon has given me a newfound appreciation for edge cases that you don’t really get just from working on small projects.  When I can count on one hand the number of digits in a project’s SLOC, there’s a level of triage that tends to prioritize big changes over “tiny” ones.  On one of the <a href="http://www.reallyeasycharts.com">side projects</a> I’m currently working on, there’s a bug in which placing more than two commas in one specific field will bring the whole thing crashing down.  I haven’t touched it yet, because the mental math tells me its not worth it – why spend an hour of my time fixing a bug that affects .01% of my possible use cases when I could spend that same hour implementing a feature that improves the overall value of the project by 10%?</p>


<p>But when you’re working with proportions – and Amazon scale – that mental math proves a lot differently.  If you’ve got (more mental math) twenty million eBooks generating $3 a day each, a bug that causes .01% of those eBooks to stop working means you’re bleeding away six thousand dollars daily – which, in terms of the salary of a junior developer like myself, is well worth spending the time to fix.</p>


<p>There’s a lot that can be said about working on big projects and small projects.  I know myself well enough to cherish my side projects – and my ability to switch from spending a few minutes hammering out some frontend CSS3 kinks before switching gears to figure out the relative merits of combining Base64 and an md5 hash – but there’s something so wonderfully unique about diving incredibly deep into something as niched as so many whitespace characters.</p>


<p>To me, it’s the programming equivalent of discovering a hidden band, smiling and knowing that you’re one of the lucky few.</p>
	