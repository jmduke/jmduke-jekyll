---
title: "Getting the admin link for an object in Django"
Date: 2017-03-09 00:00:00
Tags: ["django"]
layout: post
---

<p>You’re probably familiar with Django’s <code>get_absolute_url</code> method (docs <a href="https://docs.djangoproject.com/en/1.10/ref/models/instances/#get-absolute-url">here</a>)
that lets you hook up a Model instance to a specific URL.</p>


<p>This is really nice because instead of having to do something like this:</p>


<p><code>&lt;a href="/people/{{ object.id }}/"&gt;{{ object.name }}&lt;/a&gt;</code></p>


<p>You can do something like this:</p>


<p><code>&lt;a href="{{ object.get_absolute_url }}"&gt;{{ object.name }}&lt;/a&gt;</code></p>


<p>This lets you have a single source of truth tying an instance to its detail URL, meaning that if the URL configuration
ever changes you only have to change it in one place.</p>


<p>The same use case and reasoning is also true of generating admin URLs for internal use!</p>


<p>All you have to do is include this snippet:</p>


<pre><code>class MyModel(models.Model):

    def get_admin_url(self):
        content_type = ContentType.objects.get_for_model(self.__class__)
        return urlresolvers.reverse("admin:%s_%s_change" % (content_type.app_label, content_type.model), args=(self.id,))
</code></pre>


<p>And you’re good to go.  Now, you can refer to this as follows:</p>


<p><code>&lt;a href="{{ object.get_admin_url }}"&gt;{{ object.name }}&lt;/a&gt;</code></p>


<p>And get a link to edit that object in Django’s internal admin.</p>
	