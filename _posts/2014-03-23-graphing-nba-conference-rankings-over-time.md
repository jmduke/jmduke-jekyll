---
title: "Graphing NBA conference rankings over time."
Date: 2014-03-23 00:00:00
Tags: ["data"]
layout: post
---

<p>Bored by the relative lack of Eastern conference drama at this point in the season, I thought it would be a fun experiment to graph the relative rankings of NBA teams over the past few seasons.</p>


<p>Getting the data was surprisingly easy: major sports data is notoriously hard to retrieve, but there exists a (likely illegal) <a href="https://erikberg.com/api">API</a> that had exactly what I wanted, mapping dates to relative rankings across the conferences.  Scraping the code with Python relatively painless as well.</p>


<pre><code>import requests
import datetime
import logging
import time

# Takes a datetime in format of YYYYMMDD
base_url = "https://erikberg.com/nba/standings/{}.json"

outfile = open('nba2011.txt', 'w')

season_start = datetime.date(2011, 12, 25)
weeks = [season_start]
while weeks[-1] &lt; datetime.date(2012, 4, 23):
    weeks.append(weeks[-1] + datetime.timedelta(weeks=1))
weeks = [week.isoformat().replace('-', '') for week in weeks]

team_ids = []
rankings = {"east": [], "west": []}

for week in weeks:
    query_url = base_url.format(week)
    data = requests.get(query_url).json().get('standing')
    east_data = {rank.get('team_id'): str(rank.get('rank')) for rank in data if rank.get('conference') == 'EAST'}
    west_data = {rank.get('team_id'): str(rank.get('rank')) for rank in data if rank.get('conference') == 'WEST'}
    rankings['east'].append(east_data)
    rankings['west'].append(west_data)
    if not team_ids:
        team_ids = {"east": east_data.keys(), "west": west_data.keys()}

    # To avoid hitting the rate limit.
    time.sleep(10)

for conference in ["east", "west"]:
    outfile.write("date" + "\t" + "\t".join(team_ids.get(conference)) + "\n")
    for ind in range(len(rankings.get(conference))):
            outfile.write(weeks[ind] + "\t" + "\t".join([rankings.get(conference)[ind].get(team) for team in team_ids.get(conference)]) + "\n")
</code></pre>


<p>I graphed this all up in D3 (view source if you’re particularly intrigued), and while I was too lazy to get the actual lines to match with team colors I think the results are particularly cool.  Check out the Western Conference:</p>


<style type="text/css">

#west, #east, #both {
    font-size: 10px;
}

.axis path,
.axis line {
  fill: none;
  stroke: #000;
  shape-rendering: crispEdges;
}
 
.x.axis path {
  display: none;
}
 
.line {
  fill: none;
  stroke: steelblue;
  stroke-width: 1.5px;
}
 
.line:hover {
  stroke-width: 6px;
}
 
</style>


<p><select name="west">
<option value="2013">2013-2014</option>
<option value="2012">2012-2013</option>
<option value="2011">2011-2012</option>
</select>
</p>
<div id="west"></div>


<p>A few things are evident:</p>


<ul>
<li>The San Antonio Spurs are very very good at basketball</li>
<li>Most of the poorly-ranked teams seem to do a good job immediately plummeting to their level of performance – with the exception of the Suns, who hit something like a sinusoidal curve as they approach theirs</li>
<li>We’re only two years removed from a 23-43 Warriors team</li>
<li>No really, the Spurs are very good</li>
</ul>


<p>And compare it to the East:</p>


<p><select name="east">
<option value="2013">2013-2014</option>
<option value="2012">2012-2013</option>
<option value="2011">2011-2012</option>
</select>
</p>
<div id="east"></div>


<script src="http://d3js.org/d3.v3.js"></script>


<script type="text/javascript">
(function(){
    var margin = {top: 20, right: 80, bottom: 30, left: 50},
        width = 600 - margin.left - margin.right,
        height = 500 - margin.top - margin.bottom;

     
    var parseDate = d3.time.format("%Y%m%d").parse;
     
    var x = d3.time.scale()
        .range([0, width]);
     
    var y = d3.scale.linear()
        .range([height, 0]);
     
    var color = d3.scale.category10();
     
    var xAxis = d3.svg.axis()
        .scale(x)
        .orient("bottom");
     
    var yAxis = d3.svg.axis()
        .scale(y)
        .orient("left");
     
    var line = d3.svg.line()
        .interpolate("basis")
        .x(function(d) { return x(d.date); })
        .y(function(d) { return y(d.temperature); });
     
    var svg = d3.select("#west").append("svg")
        .attr("width", width + margin.left + margin.right)
        .attr("height", height + margin.top + margin.bottom)
      .append("g")
        .attr("transform", "translate(" + margin.left + "," + margin.top + ")");
     
    function fromCSV(filename) {
        d3.csv(filename, function(error, data) {
          color.domain(d3.keys(data[0]).filter(function(key) { return key !== "date"; }));
         
          data.forEach(function(d) {
            d.date = parseDate(d.date);
          });
         
          var cities = color.domain().map(function(name) {
            return {
              name: name,
              values: data.map(function(d) {
                return {date: d.date, temperature: +d[name]};
              })
            };
          });
         
          x.domain(d3.extent(data, function(d) { return d.date; }));
         
          y.domain([
            d3.max(cities, function(c) { return d3.max(c.values, function(v) { return v.temperature; }); }),
            d3.min(cities, function(c) { return d3.min(c.values, function(v) { return v.temperature; }); })
          ]);
         
          svg.append("g")
              .attr("class", "x axis")
              .attr("transform", "translate(0," + height + ")")
              .call(xAxis);
         
          svg.append("g")
              .attr("class", "y axis")
              .call(yAxis)
            .append("text")
              .attr("transform", "rotate(-90)")
              .attr("y", 6)
              .attr("dy", ".71em")
              .style("text-anchor", "end")
              .text("Ranking");
         
          var city = svg.selectAll(".city")
              .data(cities)
              .enter()
              .append("g")
              .attr("class", "city")
         
          city.append("path")
              .attr("class", "line")
              .attr("d", function(d) { return line(d.values); })
              .style("stroke", function(d) { 
                return color(d.name);
              });
         
          city.append("text")
              .datum(function(d) { return {name: d.name, value: d.values[d.values.length - 1]}; })
              .attr("transform", function(d) { return "translate(" + x(d.value.date) + "," + y(d.value.temperature) + ")"; })
              .attr("x", 3)
              .attr("dy", ".35em")
              .text(function(d) { return d.name; });
        });
    }

    fromCSV("/static/nbaw2013.txt");

    $("select[name='west']").change(function(e) {
        svg.selectAll(".city").remove();
        svg.selectAll(".axis").remove();
        fromCSV("/static/nbaw" + $("select[name='west']").val() + ".txt");
    });
})();
</script>


<script type="text/javascript">
(function(){
    var margin = {top: 20, right: 80, bottom: 30, left: 50},
        width = 600 - margin.left - margin.right,
        height = 500 - margin.top - margin.bottom;
     
    var parseDate = d3.time.format("%Y%m%d").parse;
     
    var x = d3.time.scale()
        .range([0, width]);
     
    var y = d3.scale.linear()
        .range([height, 0]);
     
    var color = d3.scale.category10();
     
    var xAxis = d3.svg.axis()
        .scale(x)
        .orient("bottom");
     
    var yAxis = d3.svg.axis()
        .scale(y)
        .orient("left");

    var voronoi = d3.geom.voronoi()
        .x(function(d) { return x(d.date); })
        .y(function(d) { return y(d.value); })
        .clipExtent([[-margin.left, -margin.top], [width + margin.right, height + margin.bottom]]);


    var line = d3.svg.line()
        .interpolate("basis")
        .x(function(d) { return x(d.date); })
        .y(function(d) { return y(d.temperature); });
     
    var svg = d3.select("#east").append("svg")
        .attr("width", width + margin.left + margin.right)
        .attr("height", height + margin.top + margin.bottom)
      .append("g")
        .attr("transform", "translate(" + margin.left + "," + margin.top + ")")


    var voronoiGroup = svg.append("g")
      .attr("class", "voronoi");
     
    function fromCSV(filename) {
        d3.csv(filename, function(error, data) {
          color.domain(d3.keys(data[0]).filter(function(key) { return key !== "date"; }));
         
          data.forEach(function(d) {
            d.date = parseDate(d.date);
          });
         
          var cities = color.domain().map(function(name) {
            return {
              name: name,
              values: data.map(function(d) {
                return {date: d.date, temperature: +d[name]};
              })
            };
          });
         
          x.domain(d3.extent(data, function(d) { return d.date; }));
         
          y.domain([
            d3.max(cities, function(c) { return d3.max(c.values, function(v) { return v.temperature; }); }),
            d3.min(cities, function(c) { return d3.min(c.values, function(v) { return v.temperature; }); })
          ]);
         
          svg.append("g")
              .attr("class", "x axis")
              .attr("transform", "translate(0," + height + ")")
              .call(xAxis);
         
          svg.append("g")
              .attr("class", "y axis")
              .call(yAxis)
            .append("text")
              .attr("transform", "rotate(-90)")
              .attr("y", 6)
              .attr("dy", ".71em")
              .style("text-anchor", "end")
              .text("Ranking");
         
          var city = svg.selectAll(".city")
              .data(cities)
              .enter()
              .append("g")
              .attr("class", "city")

         
          city.append("path")
              .attr("class", "line")
              .attr("d", function(d) { return line(d.values); })
              .style("stroke", function(d) { return color(d.name); });
         
          city.append("text")
              .datum(function(d) { return {name: d.name, value: d.values[d.values.length - 1]}; })
              .attr("transform", function(d) { return "translate(" + x(d.value.date) + "," + y(d.value.temperature) + ")"; })
              .attr("x", 3)
              .attr("dy", ".35em")
              .text(function(d) { return d.name; });
        });
    }

    fromCSV("/static/nbae2013.txt");

    $("select[name='east']").change(function(e) {
        svg.selectAll(".city").remove();
        svg.selectAll(".axis").remove();
        fromCSV("/static/nbae" + $("select[name='east']").val() + ".txt");
    });
})();
</script>


<p>Man, the East has actually been exciting – on paper, at least – as long as you remove the constant victory/defeat of the Pacers, Heat, and Bucks.  It’s pretty impressive to see the Nets’ steady rise into a playoff contender, and the fight for the five through eight seeds is particularly spirited <sup class="footnote-ref" id="fnref:1"><a href="#fn:1" rel="footnote">1</a></sup>.</p>


<p>And, of course, this doesn’t get into the larger issue of disparity between the East and West.  If we graph the win-loss differential over the course of the season, we see how the two teams stack up against each other (Western teams in blue, Eastern teams in orange):</p>


<pre><code>all_teams = team_ids.get("west") + team_ids.get("east")
rankings["all"] = []
for ind in range(len(rankings.get("west"))):
    merged_dict = dict(rankings.get("west")[ind].items() + rankings.get("east")[ind].items())
    rankings["all"].append(merged_dict)
outfile.write("date" + "\t" + "\t".join(all_teams) + "\n")
for ind in range(len(rankings.get("all"))):
        outfile.write(weeks[ind] + "\t" + "\t".join([rankings.get("all")[ind].get(team) for team in all_teams]) + "\n")
</code></pre>


<p><select name="both">
<option value="2013">2013-2014</option>
<option value="2012">2012-2013</option>
<option value="2011">2011-2012</option>
</select>
</p>
<div id="both"></div>


<script type="text/javascript">
(function(){
    var margin = {top: 20, right: 80, bottom: 30, left: 50},
        width = 600 - margin.left - margin.right,
        height = 500 - margin.top - margin.bottom;
     
    var parseDate = d3.time.format("%Y%m%d").parse;

    var east_teams = ["chicago-bulls","charlotte-bobcats","miami-heat","new-jersey-nets","philadelphia-76ers","milwaukee-bucks","new-york-knicks","detroit-pistons","cleveland-cavaliers","boston-celtics","washington-wizards","indiana-pacers","orlando-magic","toronto-raptors","atlanta-hawks"];
     
    var x = d3.time.scale()
        .range([0, width]);
     
    var y = d3.scale.linear()
        .range([height, 0]);
     
    var color = d3.scale.category10();
     
    var xAxis = d3.svg.axis()
        .scale(x)
        .orient("bottom");
     
    var yAxis = d3.svg.axis()
        .scale(y)
        .orient("left");

    var voronoi = d3.geom.voronoi()
        .x(function(d) { return x(d.date); })
        .y(function(d) { return y(d.value); })
        .clipExtent([[-margin.left, -margin.top], [width + margin.right, height + margin.bottom]]);


    var line = d3.svg.line()
        .interpolate("basis")
        .x(function(d) { return x(d.date); })
        .y(function(d) { return y(d.temperature); });
     
    var svg = d3.select("#both").append("svg")
        .attr("width", width + margin.left + margin.right)
        .attr("height", height + margin.top + margin.bottom)
      .append("g")
        .attr("transform", "translate(" + margin.left + "," + margin.top + ")")


    var voronoiGroup = svg.append("g")
      .attr("class", "voronoi");
     
    function fromCSV(filename) {
        d3.csv(filename, function(error, data) {
          color.domain(d3.keys(data[0]).filter(function(key) { return key !== "date"; }));
         
          data.forEach(function(d) {
            d.date = parseDate(d.date);
          });
         
          var cities = color.domain().map(function(name) {
            return {
              name: name,
              values: data.map(function(d) {
                return {date: d.date, temperature: +d[name]};
              })
            };
          });
         
          x.domain(d3.extent(data, function(d) { return d.date; }));
         
          y.domain([
            d3.min(cities, function(c) { return d3.min(c.values, function(v) { return v.temperature; }); }),
            d3.max(cities, function(c) { return d3.max(c.values, function(v) { return v.temperature; }); })
          ]);
         
          svg.append("g")
              .attr("class", "x axis")
              .attr("transform", "translate(0," + height + ")")
              .call(xAxis);
         
          svg.append("g")
              .attr("class", "y axis")
              .call(yAxis)
            .append("text")
              .attr("transform", "rotate(-90)")
              .attr("y", 6)
              .attr("dy", ".71em")
              .style("text-anchor", "end")
              .text("Win-Loss differential");
         
          var city = svg.selectAll(".city")
              .data(cities)
              .enter()
              .append("g")
              .attr("class", "city")

         
          city.append("path")
              .attr("class", "line")
              .attr("d", function(d) { return line(d.values); })
              .style("stroke", function(d) { 
                if (east_teams.indexOf(d.name) > -1)
                return color("1"); 
                return color("10");
              });
         
          city.append("text")
              .datum(function(d) { return {name: d.name, value: d.values[d.values.length - 1]}; })
              .attr("transform", function(d) { return "translate(" + x(d.value.date) + "," + y(d.value.temperature) + ")"; })
              .attr("x", 0)
              .attr("dy", ".35em")
              .text(function(d) { return d.name; });
        });
    }

    fromCSV("/static/nba2013b.txt");

    $("select[name='both']").change(function(e) {
        svg.selectAll(".city").remove();
        svg.selectAll(".axis").remove();
        fromCSV("/static/nba" + $("select[name='both']").val() + "b.txt");
    });
})();
</script>


<p>So the worst teams in the East are really, really bad.  Two years ago that distinction went to the Bobcats; last year it was shared by the Bobcats and the Magic; this year, its the Bucks and the Sixers. <sup class="footnote-ref" id="fnref:2"><a href="#fn:2" rel="footnote">2</a></sup></p>


<div class="footnotes">
<hr/>
<ol>
<li id="fn:1">This is slightly buoyed by the fact that you don’t necessarily need to have a winning record to be in the playoffs in the East.  Whammy.
 <a class="footnote-return" href="#fnref:1"><sup>[return]</sup></a></li>
<li id="fn:2">The latter of which Bill Simmons would argue <a href="http://grantland.com/the-triangle/nba-bag-figuring-out-the-ever-changing-pick-swapping-2014-draft/">would not even get past the Sweet 16</a>.
 <a class="footnote-return" href="#fnref:2"><sup>[return]</sup></a></li>
</ol>
</div>
	