---
title: "Response Times"
Date: 2017-07-15 00:00:00
Tags: ["design"]
layout: post
---

<p>Jakob Nielsen wrote in 1993 about the <a href="https://www.nngroup.com/articles/response-times-3-important-limits/">three important demarcations in response time</a>.  This is a terrific article that I come back to every year or so and see how my interpretation of it has evolved, like reading an old book to see how your perspective of the narrative changes over time.</p>


<blockquote>
<p><strong>0.1 second</strong> is about the limit for having the user feel that the system is reacting instantaneously, meaning that no special feedback is necessary except to display the result.</p>
<p><strong>1.0 second</strong> is about the limit for the user’s flow of thought to stay uninterrupted, even though the user will notice the delay. Normally, no special feedback is necessary during delays of more than 0.1 but less than 1.0 second, but the user does lose the feeling of operating directly on the data.</p>
<p><strong>10 seconds</strong> is about the limit for keeping the user’s attention focused on the dialogue. For longer delays, users will want to perform other tasks while waiting for the computer to finish, so they should be given feedback indicating when the computer expects to be done. Feedback during the delay is especially important if the response time is likely to be highly variable, since users will then not know what to expect.</p>
</blockquote>


<p>Those three benchmarks were set in 1968; Nielsen was commenting on how remarkable it was that 25 years later they still held mostly true.</p>

<!--more-->


<p>Now it’s a bit more than 25 years after 1993, and <em>even now</em> these seem pretty accurate, right?</p>


<p>You can argue that web applications (and, even more so, native apps) demand a certain level of vivacity that you can’t achieve with a full second or even a tenth of a second, but I think Jakob precisely nails the important way to look at “sluggishness” in his 2014 update to the piece:</p>


<blockquote>
<p><strong>0.1 second</strong>: Limit for users feeling that they are directly manipulating objects in the UI. For example, this is the limit from the time the user selects a column in a table until that column should highlight or otherwise give feedback that it’s selected. Ideally, this would also be the response time for sorting the column — if so, users would feel that they are sorting the table. (As opposed to feeling that they are ordering the computer to do the sorting for them.)</p>
</blockquote>


<p><em>Sorting the table, as opposed to ordering the computer to sort the table.</em></p>


<p>It’s not about the speed: it’s about the directness — about the frictionlessness — about the sensation that there are no layers or conduits between you and your task.</p>


<p></p>
	