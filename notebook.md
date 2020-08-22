---
layout: page
title: Notebook
rss: /changes/notebook.xml
---

<style>
    .notebook-item__source {
        font-weight: bold;
        font-style: italic;
    }

    .notebook-item {
        margin-bottom: 4em;
    }

    .notebook-item__metadata {
        font-style: normal;
        font-weight: 400;
        opacity: 0.5;
    }
</style>

{% assign sorted = site.data.notebook|sort: 'name'|reverse %}
{% for item in sorted %}
<div class="notebook-item">
<div class="notebook-item__text">
    {{item.text | markdownify }}
</div>
<div class="notebook-item__source">
{% if item.source %}
    <a href="/content/{{ item.source.name | slugify }}">{{ item.source.name }}</a>
{% else %}
    <a href="{{ item.source_url }}">{{ item.author }}</a>
{% endif %}
</div>
</div>
{% endfor %}