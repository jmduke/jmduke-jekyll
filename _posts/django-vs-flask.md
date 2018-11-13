---
Title: "Django vs. Flask"
Date: 2017-07-05 00:00:00
Tags: ["development","python"]
---

<p>A <a href="https://www.git-pull.com/code_explorer/django-vs-flask.html">great, thorough writeup on Django vs. Flask</a> has been floating around the past few days.  It’s a great technical breakdown, and I agree with the conclusion:</p>


<blockquote>
<p>There’s an informal perception that Batteries included may mean a growing list of ill-maintained API’s that get hooked into every request. In the case of Django, everything works across the board. When an internal Django API changes, Django’s testsuites to break and the appropriate changes are made. So stuff integrates. This is something that’s harder to do when there’s a lot of packages from different authors who have to wait for fixes to be released in Flask’s ecosystem.</p>
</blockquote>


<p>However, it also glosses over what is probably the strongest weapon in Django’s arsenal: <a href="http://django-rest-framework.org">Django Rest Framework</a>.  At this point, I essentially consider DRF a first-party package: it is so completely essential to my Python web development toolbox I can’t imagine working without it.</p>


<p>Having such a powerful, extensible approach to REST (and everything that entails: serialization, permissions, filtering…) is invaluable.  Flask is great for toy projects, but for a modern application DRF is unreplaceable, and thus so is Django.</p>


<p>(Another important thing that Django does: it forces a certain level of structure and organization to your application.  I used to think this was either unnecessarily or actively harmful: now, having seen my fair share of eldritch Python codebases, I know better.)
</p>
	