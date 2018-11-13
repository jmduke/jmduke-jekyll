---
Title: "How to send emails through Python and GMail"
Date: 2013-12-29 00:00:00
Tags: ["python","development"]
---

<p>(I apologize in advance for the robotic tone of this blog post.) This is a quick blog post about sending emails through Python’s builtin SMTP library, using GMail as your email server. It’s not complicated, I promise.</p>


<p>This is how you you log into GMail in Python:</p>


<pre><code>import smtplib

# The below code never changes, though obviously those variables need values.
session = smtplib.SMTP('smtp.gmail.com', 587)
session.ehlo()
session.starttls()
session.login(GMAIL_USERNAME, GMAIL_PASSWORD)
</code></pre>


<p>This is how you send an email in Python:</p>


<pre><code>headers = "\r\n".join(["from: " + GMAIL_USERNAME,
                       "subject: " + email_subject,
                       "to: " + recipient,
                       "mime-version: 1.0",
                       "content-type: text/html"])

# body_of_email can be plaintext or html!                    
content = headers + "\r\n\r\n" + body_of_email
session.sendmail(GMAIL_USERNAME, recipient, content)
</code></pre>


<p>Depending on which side of the fence you’re on, this is either a surprisingly small amount of code or a surprisingly large amount of code.</p>


<p>Getting a program to send emails for the first time was one of those see-inside-the-Matrix moments for me, like the first time I hosted a site on GoDaddy or fooled around with JOptionPane. It’s a protocol (a simple one, when it comes to simple use cases like these), but since I used email long before I ever touched code, it still impresses me.</p>


<p>Plus, it took me north of two hours of desperate coding to figure out the above snippets for the first time, despite mountains of edge cases and special plugins and all of that jazz; so I hope this helps somebody.</p>
	