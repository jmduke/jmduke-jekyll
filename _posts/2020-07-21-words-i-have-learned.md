---
layout: post
title: Words I have learned
rss: /changes/words.xml
---
When I was in high school and even more insufferable than I am now, a friend and I started a tumblr called "sun words".  The concept of this was to collect words that we discovered that were particularly succulent or mellifluous. [^1]

I have found myself learning more and more words recently.  This is fun and good: I was worried for a while that my days of adapting and playing with the English language were largely behind me.  I thought it would be interesting and illustrative to collect a list of the words I've learned recently alongside the sources from which I've gleaned them. (I expect the majority to be from the NYT crossword, which I recommend you start doing.)

<div class="table-container">
<table>
<thead>
<tr>
<th>word</th>
<th>definition</th>
<th>source</th>
<th>date</th>
  </tr>
</thead>
<tbody>
{% for item in site.data.words %}
<tr>
<td> {{ item.name }}</td>
<td> {{ item.definition }}</td>
<td> {{ item.source | markdownify }}</td>
<td> {{ item.date}}</td></tr>
{% endfor %}
</tbody>
</table>
</div>

[^1]: Why "sun words"? Because we were high schoolers, and because we learned of the concept of "SAT words" — words that made Flesch-Kincaid salivate — and because _Sun_day comes after _Sat_urday.  (I told you — insufferable.)

<style>
table {
    border-collapse: collapse;
}

.table-container {
        border: 1px #fff dashed;
    padding: 1em;
    border-radius: 10px;
    width: calc(100% + 300px);
    margin-left: -150px
}

tr:nth-child(2n) {
    background: #ffffff10;
}

tr:hover {
    background: #ffffff30;
}

td:last-child {
    width: 120px;
    font-variant: tabular-nums;
}

table p {
    margin-bottom: 0;
}
</style>