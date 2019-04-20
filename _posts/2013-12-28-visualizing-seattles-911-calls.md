---
title: "Visualizing Seattle's 911 calls"
Date: 2013-12-28 00:00:00
Tags: ["data"]
layout: post
---

<p>&lt;!DOCTYPE html&gt;
</p>


<link href="http://cdn.leafletjs.com/leaflet-0.7/leaflet.css" rel="stylesheet"/>


<link href="http://leaflet.github.io/Leaflet.markercluster/dist/MarkerCluster.Default.css" rel="stylesheet"/>


<script src="http://cdn.leafletjs.com/leaflet-0.7/leaflet.js"></script>


<script src="http://leaflet.github.io/Leaflet.markercluster/dist/leaflet.markercluster-src.js" type="text/javascript"></script>


<script src="http://briangonzalez.github.io/jquery.adaptive-backgrounds.js/js/jquery.js"></script>


<div id="map" style="width: 960px; height: 500px"></div>


<script>

var actualMap = L.map('map').setView([47.5951, -122.3326], 12);

L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
maxZoom: 18,
attribution: 'Map data (c) <a href="http://openstreetmap.org">OpenStreetMap</a> contributors'
}).addTo(actualMap);

var map = new L.markerClusterGroup();

var THOUSANDS = 3;

var API_ENDPOINT = "http://data.seattle.gov/resource/3k2p-39jp.json?";

for (var i = 0; i < THOUSANDS; i++) {
offset = i * 1000;
jQuery.get(API_ENDPOINT + "$offset=" + offset, function(data) {
for (var index = 0; index < data.length; index++) {
incident = data[index];
loc = incident["incident_location"];
marker = L.marker([loc["latitude"], loc["longitude"]]);
marker.bindPopup(incident["event_clearance_description"]);
map.addLayer(marker);
}
});
}

actualMap.addLayer(map);

</script>


<p></p>


<p>Okay, so how did I do it?</p>


<h2 id="getting-the-data">Getting the data</h2>


<p>This part was actually the quickest of all.  The city of Seattle <a href="data.seattle.gov">releases quite a bit of interesting data</a>, and constantly-updated 911 metadata is one of those data-dumps: it came in CSV <em>and</em> API form (more about this in a second), so as a jumping-off point I downloaded the CSV.</p>


<p>The CSV was 973,569 lines.  It took some time.</p>


<h2 id="creating-the-map">Creating the map</h2>


<p>I just discovered <a href="https://github.com/wrobstory/folium">Folium</a>, which is essentially a Python wrapper around the excellent <a href="leafletjs.com">Leaflet.js</a> mapping library.  With it, creating an output map was easy:</p>


<pre><code>import folium
from collections import namedtuple

FILEPATH = "seattle_911.html"
SEATTLE_COORDINATES = (47.5951, -122.3326)
SOURCE_FILE = "Seattle_Police_Department_911_Incident_Response.csv"
MAX_LINES = 10000

seattle_map = folium.Map(location=SEATTLE_COORDINATES)

Location = namedtuple('Location', ['latitude', 'longitude']) 

with open(SOURCE_FILE, 'r') as opened_file:
    # Skip the first line because its header information.
    for call in opened_file.readlines()[1:MAX_LINES]:
        parsed_call = call.split(",")
        location = Location(parsed_call[-3], parsed_call[-4])
        seattle_map.simple_marker(location)

seattle_map.create_map(FILEPATH)
</code></pre>


<p>Open the output HTML, though, and we get this monstrosity:</p>


<p><img alt="" src="http://i.imgur.com/VZkg3Xw.png"/></p>


<p>Jeez, that’s not exactly helpful.  Plus, the final HTML file is a bit north of forty thousand lines long, since <code>folium</code> is using four lines per marker: there’s gotta be a better way than a 1.1MB file, right?</p>


<p>So, tackling the death-by-markers problem first, I turn to the <a href="https://github.com/Leaflet/Leaflet.markercluster">comically easy-to-use clustering plugin</a>:  there’s no code to show for this step, since it literally only requires you to change <code>L.LayerGroup</code> to <code>L.markerClusterGroup</code>.</p>


<p>For the second problem, I ended up sort of scrapping the existing code I had and turning from a csv+Python approach to a API+Javascript one.  All of the City of Seattle data is exposed via a simple endpoint, and we can access that with jQuery like so:</p>


<pre><code>jQuery.get(API_ENDPOINT + "$offset=" + offset, function(data) {
    for (var index = 0; index &lt; data.length; index++) {
      incident = data[index];
      loc = incident["incident_location"];
      marker = L.marker([loc["latitude"], loc["longitude"]]);
      marker.bindPopup(incident["event_clearance_description"]);
      map.addLayer(marker);
    }
}
</code></pre>


<p>Simple, right?</p>


<hr/>


<p>You can also view the <a href="https://gist.github.com/jmduke/8165668">entire source of the embedded map</a>, if you’d prefer.  Hope you enjoyed this — and let me know if there’s anything you think I can improve/include!</p>
	