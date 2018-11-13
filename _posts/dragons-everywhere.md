---
Title: "There are still dragons everywhere"
Date: 2017-08-02 00:00:00
Tags: ["development"]
---

<p>I’ve been programming for the better part of a decade, and I’ve been programming in Python for the better part of that better part.</p>


<p>As loathe as I am to assume the mantel of “X Engineer”, if I were to describe my career in relation to any technology it would be “Python Engineer”.</p>


<p>It is the language I feel most comfortable with; it is the language I reach to first when starting a new project; it is the language I write daily.  It is as frictionless as English.</p>


<p>And yet I <em>still</em> find myself losing hours to things I thought I had mastered.</p>

<!--more-->

<hr/>


<p>The other night, I played with the idea of bumping <a href="https://buttondown.email">Buttondown</a> to Python 3.6 from 3.5 — I wanted cooler types and faster dictionaries, and it seemed like a painless process, so I ran <code>brew upgrade python</code> and was off to the races.</p>


<p>Except something broke: there was an issue with how I was using <code>grequests</code> that was fine in 3.5 but not 3.6, and I decided to revert.</p>


<p>So I hit up <a href="https://github.com/pyenv/pyenv">pyenv</a> to try and grab 3.5 (since it was no longer the latest thing installed on my machine) and use that to recreate my virtualenv.</p>


<p>Except now psycopg2 was broken for some reason?</p>


<p>It kept on throwing a bizarre error that had like, three matches on Google total:</p>


<pre><code>ImportError: datetime initialization failed
</code></pre>


<p>So, I do what I’ve learned to do: <em>nuke everything and start over</em>.</p>


<p>Except now <code>virtualenv</code> is broken, looking for a global python installation that doesn’t exist: <code>no such file or directory</code>, it snaps back at me.</p>


<p>After a few hours of fruitless Googling and tinkering, I do the thing I’m not supposed to do: I just re-install the old version of Python with brew:</p>


<pre><code>brew install https://raw.githubusercontent.com/Homebrew/homebrew-core/ec545d45d4512ace3570782283df4ecda6bb0044/Formula/python3.rb
</code></pre>


<p>And suddenly everything works.  I recreate the virtualenv; I reinstall the dependencies; I get back to work.</p>


<hr/>


<p>There’s no big lesson here.  I probably should have stuck with 3.6 and figured out the grequests issue; I probably should have been more disciplined with installing 3.6 through <code>pyenv</code> and managing my environments.</p>


<p>But I think it feels good to get lost in a sea of arcana and development hell for an afternoon.  I mean, it sucks in the moment — there’s no denying that.  But once the moment passes, you’re reminded about how much left there is to learn and to master.</p>


<p></p>
	