---
layout: page
title: Notebook
---

<style>
    .notebook-item__source {
        font-weight: bold;
        font-style: italic;
    }

    .notebook-item {
        margin-bottom: 4em;
    }
</style>

{% for item in site.data.notebook %}
<div class="notebook-item">
<div class="notebook-item__text">
    {{item.text | markdownify }}
</div>
<div class="notebook-item__source">
{% if item.source %}
    {{ item.source.name }}
{% else %}
    <a href="{{ item.source_url }}">{{ item.author }}</a>
{% endif %}
</div>
</div>
{% endfor %}