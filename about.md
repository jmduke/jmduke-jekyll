---
layout: page
title: About
permalink: /
---

<style>.post-header { display: none; } .post-content { font-size: 20px; line-height: 30px;} p { margin-bottom: 1em; }</style>

**Justin Duke**

Hello! I currently spend most of my time writing and thinking about software (vaguely in that order). 
Are you interested in a curriculum vitae? Here it is, with the caveat that I am very much not interested
in a new job:

<table>
<tr>
<td>2018 —</td>
<td><a href='https://stripe.com'>Stripe</a></td>
</tr>
<tr>
<td>2016 — 2018</td>
<td><a href='https://tenantbase.com'>TenantBase</a></td>
</tr>
<tr>
<td>2013 — 2016</td>
<td><a href='https://amazon.com'>Amazon</a></td>
</tr>
</table>

Or perhaps you are interested in some of my projects:

<table>
<tr>
<td>2017 —</td>
<td><a href='https://buttondown.email'>Buttondown</a></td>
</tr>
<tr>
<td>2016 —</td>
<td><a href='https://spoonbill.io'>Spoonbill</a></td>
</tr>
<tr>
<td>2013 — 2017</td>
<td><a href='https://getbarback.com'>Barback</a></td>
</tr>
</table>

I also love books and video games! I'm currently:

<table>
{% for item in site.data.currently %}
<tr>
<td> {{ item.verb }}</td>
<td> <a href='/content/{{ item['name_(from_content)'][0] | slugify }}'>{{ item['name_(from_content)'] }}</a></td>
</tr>
{% endfor %}
</table>

I [love getting email](mailto:me@jmduke.com).

<style>
    table {
        width: 100%;
        margin-bottom: 1em;
    }
    td:last-child {
        text-align: right;
    }
    td:first-child {
        opacity: 0.7;
    }
</style>