---
Title: "How Big Tech uses GitHub"
Date: 2013-11-07 00:00:00
Tags: ["data"]
---

<p>PayPal recently released <a href="https://github.com/paypal/kraken-js">Kraken, an open source Node.js framework</a>, on GitHub, which got me thinking about the various ways different large technology companies (particularly those which we don’t really associate with OSS) use GitHub and engage in Open Source.</p>


<p>Twenty minutes and a quick Python script later, I produced the following table, a snapshot of how popular these companies are on <a href="news.cnet.com/8301-10797_3-57495099-235/forget-linkedin-companies-turn-to-github-to-find-tech-talent/">the only network that matters to developers</a>.  You can find the script <a href="https://gist.github.com/jmduke/7622401">online</a> if you’d like to see how its done (fair warning: the code is gross.)</p>


<table>
<thead>
<tr>
<th>Company</th>
<th>Repositories</th>
<th>Forks</th>
<th>Stars</th>
<th>Language</th>
</tr>
</thead>
<tbody>
<tr>
<td>google</td>
<td>85</td>
<td>1336</td>
<td>12250</td>
<td>C</td>
</tr>
<tr>
<td>adobe</td>
<td>32</td>
<td>3862</td>
<td>19231</td>
<td>C++</td>
</tr>
<tr>
<td>twitter</td>
<td>103</td>
<td>6057</td>
<td>43780</td>
<td>C++</td>
</tr>
<tr>
<td>paypal</td>
<td>114</td>
<td>1046</td>
<td>1868</td>
<td>None</td>
</tr>
<tr>
<td>aws</td>
<td>18</td>
<td>1693</td>
<td>6221</td>
<td>Java</td>
</tr>
<tr>
<td>yahoo</td>
<td>143</td>
<td>1129</td>
<td>4805</td>
<td>JavaScript</td>
</tr>
<tr>
<td>linkedin</td>
<td>52</td>
<td>1501</td>
<td>7932</td>
<td>Java</td>
</tr>
<tr>
<td>facebook</td>
<td>102</td>
<td>15311</td>
<td>64907</td>
<td>C++</td>
</tr>
<tr>
<td>dropbox</td>
<td>19</td>
<td>178</td>
<td>1329</td>
<td>PHP</td>
</tr>
<tr>
<td>mozilla</td>
<td>687</td>
<td>11500</td>
<td>44232</td>
<td>C++</td>
</tr>
<tr>
<td>hubspot</td>
<td>63</td>
<td>1155</td>
<td>16819</td>
<td>Ruby</td>
</tr>
</tbody>
</table>


<p>A few notes:</p>


<ul>
<li>Mozilla leads the pack in terms of number of repositories, which makes sense given that everything they do is on GitHub (even their <a href="http://www.mozilla.org">home page!</a>)</li>
<li>Facebook, however, leads the pack in terms of engagement: more users fork and star their repositories than any other company.  Efforts like <a href="https://github.com/facebook/huxley">Huxley</a> and <a href="https://github.com/facebook/phabricator">Phabricator</a> are incredibly popular.</li>
</ul>


<p>It should be noted that this is a pretty naive look at the overall picture: for instance, Google’s Dart repositories are held in a completely different organization.  Still, it gives a birds-eye view of the devotion each company has for OSS (or, more cynically: the devotion each company has for attracting new developers.)</p>
	