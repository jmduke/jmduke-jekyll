---
Title: "Basic linear regressions in Python"
Date: 2014-03-11 00:00:00
Tags: ["python","development"]
---

<p>Linear regressions are a great tool for any level of data exploration: chances are, if you’re looking to investigate the relationship between two variables, somewhere along the line you’re going to want to conjure a regression.  So how do you accomplish that in Python?</p>


<p>First, let’s grab some test data from <a href="http://people.sc.fsu.edu/~jburkardt/">John Burkardt</a> at FSU: specifically, some <a href="http://people.sc.fsu.edu/~jburkardt/datasets/regression/x27.txt">toy housing data</a> which contains – amongst other things – the area of the site in thousands of square feet and the final selling price.  We’ll investigate a pretty simple hypothesis: as the area of the site increases, the selling price increases as well.</p>


<p>Creating the regression itself is pretty simple if you go the route of NumPy:</p>


<pre><code>import pandas as pd
import numpy as np

COLUMN_SEPARATOR = '  '
housing_data = pd.DataFrame.from_csv('housing.csv', sep=COLUMN_SEPARATOR, header=None)

AREA_INDEX = 4
SELLING_PRICE_INDEX = 13
x = housing_data[AREA_INDEX]
y = housing_data[SELLING_PRICE_INDEX]
regression = np.polyfit(x, y, 1)
</code></pre>


<p><code>regression</code> prints as <code>[  3.87739108  13.10587299]</code>, which is a list of the coefficients in descending power.  That is, this is the same as the following equation:</p>


<pre><code>y = 3.87739108 * x + 13.10587299.
</code></pre>


<p>So, our hypothesis turns out to be sane!  For every thousand square feet in the housing site, our selling price increases by approximately $380 dollars. <sup class="footnote-ref" id="fnref:1"><a href="#fn:1" rel="footnote">1</a></sup></p>


<p>And, since we’re feeling fancy, let’s graph this lil’ guy!  I decided to go with <a href="bokeh.pydata.org">Bokeh</a>, which is very much still a work in progress on binding <code>matplotlib</code>-esque interfaces onto D3 – it doesn’t have much embedding functionality, but it’s easy to get off the ground and looks pretty dang neat.</p>


<pre><code>from bokeh.plotting import *

# We need to generate actual values for the regression line.
r_x, r_y = zip(*((i, i*regression[0] + regression[1]) for i in range(15)))

output_file("regression.html")
line(r_x, r_y, color="red")
# Specify that the two graphs should be on the same plot.
hold(True)
scatter(x, y, marker="square", color="blue")
show()
</code></pre>


<p><link href="/static/bokeh.css" rel="stylesheet" type="text/css"/>
<script src="/static/bokeh.js" type="text/javascript"></script>
<script type="text/javascript">
$(function() {
var all_models = [{&ldquo;attributes&rdquo;: {&ldquo;data_source&rdquo;: {&ldquo;type&rdquo;: &ldquo;ColumnDataSource&rdquo;, &ldquo;id&rdquo;: &ldquo;550be8bf-b9ec-4999-8154-cc5370c6d3af&rdquo;}, &ldquo;doc&rdquo;: null, &ldquo;id&rdquo;: &ldquo;edfc1870-027f-497f-9f6a-215d97b6bc22&rdquo;, &ldquo;xdata_range&rdquo;: null, &ldquo;ydata_range&rdquo;: null, &ldquo;glyphspec&rdquo;: {&ldquo;line_color&rdquo;: {&ldquo;value&rdquo;: &ldquo;blue&rdquo;}, &ldquo;line_alpha&rdquo;: {&ldquo;units&rdquo;: &ldquo;data&rdquo;, &ldquo;value&rdquo;: 1.0}, &ldquo;angle&rdquo;: {&ldquo;units&rdquo;: &ldquo;data&rdquo;, &ldquo;field&rdquo;: &ldquo;angle&rdquo;}, &ldquo;fill_color&rdquo;: {&ldquo;value&rdquo;: &ldquo;blue&rdquo;}, &ldquo;line_width&rdquo;: {&ldquo;units&rdquo;: &ldquo;data&rdquo;, &ldquo;field&rdquo;: &ldquo;line_width&rdquo;}, &ldquo;fill_alpha&rdquo;: {&ldquo;units&rdquo;: &ldquo;data&rdquo;, &ldquo;value&rdquo;: 1.0}, &ldquo;text_alpha&rdquo;: 1.0, &ldquo;text_color&rdquo;: &ldquo;black&rdquo;, &ldquo;marker&rdquo;: &ldquo;square&rdquo;, &ldquo;y&rdquo;: {&ldquo;units&rdquo;: &ldquo;data&rdquo;, &ldquo;field&rdquo;: &ldquo;y&rdquo;}, &ldquo;x&rdquo;: {&ldquo;units&rdquo;: &ldquo;data&rdquo;, &ldquo;field&rdquo;: &ldquo;x&rdquo;}, &ldquo;type&rdquo;: &ldquo;square&rdquo;, &ldquo;size&rdquo;: {&ldquo;units&rdquo;: &ldquo;screen&rdquo;, &ldquo;field&rdquo;: null, &ldquo;default&rdquo;: 4}}, &ldquo;nonselection_glyphspec&rdquo;: {&ldquo;line_color&rdquo;: {&ldquo;value&rdquo;: &ldquo;#1f77b4&rdquo;}, &ldquo;angle_units&rdquo;: &ldquo;deg&rdquo;, &ldquo;fill_color&rdquo;: {&ldquo;value&rdquo;: &ldquo;#1f77b4&rdquo;}, &ldquo;visible&rdquo;: null, &ldquo;end_angle_units&rdquo;: &ldquo;deg&rdquo;, &ldquo;line_dash_offset&rdquo;: 0, &ldquo;line_join&rdquo;: &ldquo;miter&rdquo;, &ldquo;size&rdquo;: {&ldquo;units&rdquo;: &ldquo;screen&rdquo;, &ldquo;default&rdquo;: 4, &ldquo;field&rdquo;: null}, &ldquo;line_alpha&rdquo;: {&ldquo;units&rdquo;: &ldquo;data&rdquo;, &ldquo;value&rdquo;: 0.1}, &ldquo;angle&rdquo;: {&ldquo;units&rdquo;: &ldquo;data&rdquo;, &ldquo;field&rdquo;: &ldquo;angle&rdquo;}, &ldquo;radius_units&rdquo;: &ldquo;screen&rdquo;, &ldquo;valign&rdquo;: null, &ldquo;length_units&rdquo;: &ldquo;screen&rdquo;, &ldquo;start_angle_units&rdquo;: &ldquo;deg&rdquo;, &ldquo;line_cap&rdquo;: &ldquo;butt&rdquo;, &ldquo;line_dash&rdquo;: [], &ldquo;line_width&rdquo;: {&ldquo;units&rdquo;: &ldquo;data&rdquo;, &ldquo;field&rdquo;: &ldquo;line_width&rdquo;}, &ldquo;type&rdquo;: &ldquo;square&rdquo;, &ldquo;fill_alpha&rdquo;: {&ldquo;units&rdquo;: &ldquo;data&rdquo;, &ldquo;value&rdquo;: 0.1}, &ldquo;halign&rdquo;: null, &ldquo;y&rdquo;: {&ldquo;units&rdquo;: &ldquo;data&rdquo;, &ldquo;field&rdquo;: &ldquo;y&rdquo;}, &ldquo;x&rdquo;: {&ldquo;units&rdquo;: &ldquo;data&rdquo;, &ldquo;field&rdquo;: &ldquo;x&rdquo;}, &ldquo;margin&rdquo;: null}}, &ldquo;type&rdquo;: &ldquo;Glyph&rdquo;, &ldquo;id&rdquo;: &ldquo;edfc1870-027f-497f-9f6a-215d97b6bc22&rdquo;}, {&ldquo;attributes&rdquo;: {&ldquo;column_names&rdquo;: [&ldquo;x&rdquo;, &ldquo;y&rdquo;], &ldquo;doc&rdquo;: null, &ldquo;selected&rdquo;: [], &ldquo;discrete_ranges&rdquo;: {}, &ldquo;cont_ranges&rdquo;: {}, &ldquo;data&rdquo;: {&ldquo;y&rdquo;: [13.105872988455742, 16.983264070594554, 20.860655152733369, 24.738046234872179, 28.615437317010993, 32.492828399149808, 36.370219481288622, 40.247610563427429, 44.125001645566243, 48.002392727705057, 51.879783809843872, 55.757174891982686, 59.6345659741215, 63.511957056260314, 67.389348138399114], &ldquo;x&rdquo;: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]}, &ldquo;id&rdquo;: &ldquo;66f913f2-e072-42ae-a9b9-a5f7e233abd9&rdquo;}, &ldquo;type&rdquo;: &ldquo;ColumnDataSource&rdquo;, &ldquo;id&rdquo;: &ldquo;66f913f2-e072-42ae-a9b9-a5f7e233abd9&rdquo;}, {&ldquo;attributes&rdquo;: {&ldquo;x_range&rdquo;: {&ldquo;type&rdquo;: &ldquo;DataRange1d&rdquo;, &ldquo;id&rdquo;: &ldquo;e9862eb9-5881-4d1c-946e-d20c512608a4&rdquo;}, &ldquo;axes&rdquo;: [], &ldquo;title&rdquo;: &ldquo;Plot&rdquo;, &ldquo;y_range&rdquo;: {&ldquo;type&rdquo;: &ldquo;DataRange1d&rdquo;, &ldquo;id&rdquo;: &ldquo;871a0fe0-4515-49e8-93da-eac562bcf2a3&rdquo;}, &ldquo;outer_width&rdquo;: 600, &ldquo;renderers&rdquo;: [{&ldquo;type&rdquo;: &ldquo;LinearAxis&rdquo;, &ldquo;id&rdquo;: &ldquo;cb245aaf-890d-4a2f-8f47-2bdeafc565d0&rdquo;}, {&ldquo;type&rdquo;: &ldquo;LinearAxis&rdquo;, &ldquo;id&rdquo;: &ldquo;94b21860-b7e6-4c21-b76e-36aae9df7769&rdquo;}, {&ldquo;type&rdquo;: &ldquo;Grid&rdquo;, &ldquo;id&rdquo;: &ldquo;bdd8b257-83fb-4b71-aee8-27579c9f3b54&rdquo;}, {&ldquo;type&rdquo;: &ldquo;Grid&rdquo;, &ldquo;id&rdquo;: &ldquo;29b15c6b-d5fc-4fc0-8533-fad8d5f96831&rdquo;}, {&ldquo;type&rdquo;: &ldquo;BoxSelection&rdquo;, &ldquo;id&rdquo;: &ldquo;e795c6b9-4ce0-4684-bff3-9ad99b4887b0&rdquo;}, {&ldquo;type&rdquo;: &ldquo;BoxSelection&rdquo;, &ldquo;id&rdquo;: &ldquo;562db128-0818-4abe-8725-348e4c8f81e8&rdquo;}, {&ldquo;type&rdquo;: &ldquo;Glyph&rdquo;, &ldquo;id&rdquo;: &ldquo;44591e70-15e1-4d3a-a597-90c0d454d5d2&rdquo;}, {&ldquo;type&rdquo;: &ldquo;Glyph&rdquo;, &ldquo;id&rdquo;: &ldquo;edfc1870-027f-497f-9f6a-215d97b6bc22&rdquo;}], &ldquo;outer_height&rdquo;: 600, &ldquo;doc&rdquo;: null, &ldquo;canvas_height&rdquo;: 600, &ldquo;id&rdquo;: &ldquo;c934a86a-f746-48a4-a859-ce278ffa3d43&rdquo;, &ldquo;tools&rdquo;: [{&ldquo;type&rdquo;: &ldquo;PanTool&rdquo;, &ldquo;id&rdquo;: &ldquo;a09fc750-afa4-4c1c-8d25-2fde467d6a2a&rdquo;}, {&ldquo;type&rdquo;: &ldquo;WheelZoomTool&rdquo;, &ldquo;id&rdquo;: &ldquo;b796f625-8d66-4695-aa87-ad66ac6576b6&rdquo;}, {&ldquo;type&rdquo;: &ldquo;BoxZoomTool&rdquo;, &ldquo;id&rdquo;: &ldquo;579a5e2a-ee01-45f3-b5a5-07b8f430b818&rdquo;}, {&ldquo;type&rdquo;: &ldquo;PreviewSaveTool&rdquo;, &ldquo;id&rdquo;: &ldquo;cd3a6805-87bd-456d-9258-a68d9f408ad9&rdquo;}, {&ldquo;type&rdquo;: &ldquo;ResizeTool&rdquo;, &ldquo;id&rdquo;: &ldquo;7112fa2f-ab63-440e-9129-053bddd7e3d3&rdquo;}, {&ldquo;type&rdquo;: &ldquo;BoxSelectTool&rdquo;, &ldquo;id&rdquo;: &ldquo;e0f2724a-5700-46db-8fed-e1814cc03568&rdquo;}, {&ldquo;type&rdquo;: &ldquo;ResetTool&rdquo;, &ldquo;id&rdquo;: &ldquo;da85aeb2-a765-49bf-85ed-a3036d5df8c5&rdquo;}], &ldquo;canvas_width&rdquo;: 600}, &ldquo;type&rdquo;: &ldquo;Plot&rdquo;, &ldquo;id&rdquo;: &ldquo;c934a86a-f746-48a4-a859-ce278ffa3d43&rdquo;}, {&ldquo;attributes&rdquo;: {&ldquo;sources&rdquo;: [{&ldquo;ref&rdquo;: {&ldquo;type&rdquo;: &ldquo;ColumnDataSource&rdquo;, &ldquo;id&rdquo;: &ldquo;66f913f2-e072-42ae-a9b9-a5f7e233abd9&rdquo;}, &ldquo;columns&rdquo;: [&ldquo;x&rdquo;]}, {&ldquo;ref&rdquo;: {&ldquo;type&rdquo;: &ldquo;ColumnDataSource&rdquo;, &ldquo;id&rdquo;: &ldquo;550be8bf-b9ec-4999-8154-cc5370c6d3af&rdquo;}, &ldquo;columns&rdquo;: [&ldquo;x&rdquo;]}], &ldquo;id&rdquo;: &ldquo;e9862eb9-5881-4d1c-946e-d20c512608a4&rdquo;, &ldquo;doc&rdquo;: null}, &ldquo;type&rdquo;: &ldquo;DataRange1d&rdquo;, &ldquo;id&rdquo;: &ldquo;e9862eb9-5881-4d1c-946e-d20c512608a4&rdquo;}, {&ldquo;attributes&rdquo;: {&ldquo;sources&rdquo;: [{&ldquo;ref&rdquo;: {&ldquo;type&rdquo;: &ldquo;ColumnDataSource&rdquo;, &ldquo;id&rdquo;: &ldquo;66f913f2-e072-42ae-a9b9-a5f7e233abd9&rdquo;}, &ldquo;columns&rdquo;: [&ldquo;y&rdquo;]}, {&ldquo;ref&rdquo;: {&ldquo;type&rdquo;: &ldquo;ColumnDataSource&rdquo;, &ldquo;id&rdquo;: &ldquo;550be8bf-b9ec-4999-8154-cc5370c6d3af&rdquo;}, &ldquo;columns&rdquo;: [&ldquo;y&rdquo;]}], &ldquo;id&rdquo;: &ldquo;871a0fe0-4515-49e8-93da-eac562bcf2a3&rdquo;, &ldquo;doc&rdquo;: null}, &ldquo;type&rdquo;: &ldquo;DataRange1d&rdquo;, &ldquo;id&rdquo;: &ldquo;871a0fe0-4515-49e8-93da-eac562bcf2a3&rdquo;}, {&ldquo;attributes&rdquo;: {&ldquo;plot&rdquo;: {&ldquo;type&rdquo;: &ldquo;Plot&rdquo;, &ldquo;id&rdquo;: &ldquo;c934a86a-f746-48a4-a859-ce278ffa3d43&rdquo;}, &ldquo;location&rdquo;: &ldquo;min&rdquo;, &ldquo;bounds&rdquo;: &ldquo;auto&rdquo;, &ldquo;doc&rdquo;: null, &ldquo;id&rdquo;: &ldquo;cb245aaf-890d-4a2f-8f47-2bdeafc565d0&rdquo;, &ldquo;dimension&rdquo;: 0}, &ldquo;type&rdquo;: &ldquo;LinearAxis&rdquo;, &ldquo;id&rdquo;: &ldquo;cb245aaf-890d-4a2f-8f47-2bdeafc565d0&rdquo;}, {&ldquo;attributes&rdquo;: {&ldquo;plot&rdquo;: {&ldquo;type&rdquo;: &ldquo;Plot&rdquo;, &ldquo;id&rdquo;: &ldquo;c934a86a-f746-48a4-a859-ce278ffa3d43&rdquo;}, &ldquo;location&rdquo;: &ldquo;min&rdquo;, &ldquo;bounds&rdquo;: &ldquo;auto&rdquo;, &ldquo;doc&rdquo;: null, &ldquo;id&rdquo;: &ldquo;94b21860-b7e6-4c21-b76e-36aae9df7769&rdquo;, &ldquo;dimension&rdquo;: 1}, &ldquo;type&rdquo;: &ldquo;LinearAxis&rdquo;, &ldquo;id&rdquo;: &ldquo;94b21860-b7e6-4c21-b76e-36aae9df7769&rdquo;}, {&ldquo;attributes&rdquo;: {&ldquo;plot&rdquo;: {&ldquo;type&rdquo;: &ldquo;Plot&rdquo;, &ldquo;id&rdquo;: &ldquo;c934a86a-f746-48a4-a859-ce278ffa3d43&rdquo;}, &ldquo;doc&rdquo;: null, &ldquo;is_datetime&rdquo;: false, &ldquo;dimension&rdquo;: 0, &ldquo;id&rdquo;: &ldquo;bdd8b257-83fb-4b71-aee8-27579c9f3b54&rdquo;}, &ldquo;type&rdquo;: &ldquo;Grid&rdquo;, &ldquo;id&rdquo;: &ldquo;bdd8b257-83fb-4b71-aee8-27579c9f3b54&rdquo;}, {&ldquo;attributes&rdquo;: {&ldquo;plot&rdquo;: {&ldquo;type&rdquo;: &ldquo;Plot&rdquo;, &ldquo;id&rdquo;: &ldquo;c934a86a-f746-48a4-a859-ce278ffa3d43&rdquo;}, &ldquo;doc&rdquo;: null, &ldquo;is_datetime&rdquo;: false, &ldquo;dimension&rdquo;: 1, &ldquo;id&rdquo;: &ldquo;29b15c6b-d5fc-4fc0-8533-fad8d5f96831&rdquo;}, &ldquo;type&rdquo;: &ldquo;Grid&rdquo;, &ldquo;id&rdquo;: &ldquo;29b15c6b-d5fc-4fc0-8533-fad8d5f96831&rdquo;}, {&ldquo;attributes&rdquo;: {&ldquo;plot&rdquo;: {&ldquo;type&rdquo;: &ldquo;Plot&rdquo;, &ldquo;id&rdquo;: &ldquo;c934a86a-f746-48a4-a859-ce278ffa3d43&rdquo;}, &ldquo;doc&rdquo;: null, &ldquo;dimensions&rdquo;: [&ldquo;width&rdquo;, &ldquo;height&rdquo;], &ldquo;id&rdquo;: &ldquo;a09fc750-afa4-4c1c-8d25-2fde467d6a2a&rdquo;}, &ldquo;type&rdquo;: &ldquo;PanTool&rdquo;, &ldquo;id&rdquo;: &ldquo;a09fc750-afa4-4c1c-8d25-2fde467d6a2a&rdquo;}, {&ldquo;attributes&rdquo;: {&ldquo;data_source&rdquo;: {&ldquo;type&rdquo;: &ldquo;ColumnDataSource&rdquo;, &ldquo;id&rdquo;: &ldquo;66f913f2-e072-42ae-a9b9-a5f7e233abd9&rdquo;}, &ldquo;doc&rdquo;: null, &ldquo;id&rdquo;: &ldquo;44591e70-15e1-4d3a-a597-90c0d454d5d2&rdquo;, &ldquo;xdata_range&rdquo;: null, &ldquo;ydata_range&rdquo;: null, &ldquo;glyphspec&rdquo;: {&ldquo;line_color&rdquo;: {&ldquo;value&rdquo;: &ldquo;red&rdquo;}, &ldquo;line_alpha&rdquo;: {&ldquo;units&rdquo;: &ldquo;data&rdquo;, &ldquo;value&rdquo;: 1.0}, &ldquo;fill_color&rdquo;: &ldquo;red&rdquo;, &ldquo;line_width&rdquo;: {&ldquo;units&rdquo;: &ldquo;data&rdquo;, &ldquo;field&rdquo;: &ldquo;line_width&rdquo;}, &ldquo;fill_alpha&rdquo;: 1.0, &ldquo;text_alpha&rdquo;: 1.0, &ldquo;text_color&rdquo;: &ldquo;black&rdquo;, &ldquo;y&rdquo;: {&ldquo;units&rdquo;: &ldquo;data&rdquo;, &ldquo;field&rdquo;: &ldquo;y&rdquo;}, &ldquo;x&rdquo;: {&ldquo;units&rdquo;: &ldquo;data&rdquo;, &ldquo;field&rdquo;: &ldquo;x&rdquo;}, &ldquo;type&rdquo;: &ldquo;line&rdquo;}, &ldquo;nonselection_glyphspec&rdquo;: {&ldquo;line_color&rdquo;: {&ldquo;value&rdquo;: &ldquo;#1f77b4&rdquo;}, &ldquo;line_width&rdquo;: {&ldquo;units&rdquo;: &ldquo;data&rdquo;, &ldquo;field&rdquo;: &ldquo;line_width&rdquo;}, &ldquo;angle_units&rdquo;: &ldquo;deg&rdquo;, &ldquo;type&rdquo;: &ldquo;line&rdquo;, &ldquo;y&rdquo;: {&ldquo;units&rdquo;: &ldquo;data&rdquo;, &ldquo;field&rdquo;: &ldquo;y&rdquo;}, &ldquo;line_alpha&rdquo;: {&ldquo;units&rdquo;: &ldquo;data&rdquo;, &ldquo;value&rdquo;: 0.1}, &ldquo;start_angle_units&rdquo;: &ldquo;deg&rdquo;, &ldquo;valign&rdquo;: null, &ldquo;radius_units&rdquo;: &ldquo;screen&rdquo;, &ldquo;visible&rdquo;: null, &ldquo;length_units&rdquo;: &ldquo;screen&rdquo;, &ldquo;end_angle_units&rdquo;: &ldquo;deg&rdquo;, &ldquo;line_dash_offset&rdquo;: 0, &ldquo;line_cap&rdquo;: &ldquo;butt&rdquo;, &ldquo;line_dash&rdquo;: [], &ldquo;x&rdquo;: {&ldquo;units&rdquo;: &ldquo;data&rdquo;, &ldquo;field&rdquo;: &ldquo;x&rdquo;}, &ldquo;margin&rdquo;: null, &ldquo;line_join&rdquo;: &ldquo;miter&rdquo;, &ldquo;halign&rdquo;: null}}, &ldquo;type&rdquo;: &ldquo;Glyph&rdquo;, &ldquo;id&rdquo;: &ldquo;44591e70-15e1-4d3a-a597-90c0d454d5d2&rdquo;}, {&ldquo;attributes&rdquo;: {&ldquo;plot&rdquo;: {&ldquo;type&rdquo;: &ldquo;Plot&rdquo;, &ldquo;id&rdquo;: &ldquo;c934a86a-f746-48a4-a859-ce278ffa3d43&rdquo;}, &ldquo;id&rdquo;: &ldquo;579a5e2a-ee01-45f3-b5a5-07b8f430b818&rdquo;, &ldquo;doc&rdquo;: null}, &ldquo;type&rdquo;: &ldquo;BoxZoomTool&rdquo;, &ldquo;id&rdquo;: &ldquo;579a5e2a-ee01-45f3-b5a5-07b8f430b818&rdquo;}, {&ldquo;attributes&rdquo;: {&ldquo;doc&rdquo;: null, &ldquo;tool&rdquo;: {&ldquo;type&rdquo;: &ldquo;BoxZoomTool&rdquo;, &ldquo;id&rdquo;: &ldquo;579a5e2a-ee01-45f3-b5a5-07b8f430b818&rdquo;}, &ldquo;id&rdquo;: &ldquo;e795c6b9-4ce0-4684-bff3-9ad99b4887b0&rdquo;}, &ldquo;type&rdquo;: &ldquo;BoxSelection&rdquo;, &ldquo;id&rdquo;: &ldquo;e795c6b9-4ce0-4684-bff3-9ad99b4887b0&rdquo;}, {&ldquo;attributes&rdquo;: {&ldquo;plot&rdquo;: {&ldquo;type&rdquo;: &ldquo;Plot&rdquo;, &ldquo;id&rdquo;: &ldquo;c934a86a-f746-48a4-a859-ce278ffa3d43&rdquo;}, &ldquo;dataranges&rdquo;: [], &ldquo;id&rdquo;: &ldquo;cd3a6805-87bd-456d-9258-a68d9f408ad9&rdquo;, &ldquo;doc&rdquo;: null}, &ldquo;type&rdquo;: &ldquo;PreviewSaveTool&rdquo;, &ldquo;id&rdquo;: &ldquo;cd3a6805-87bd-456d-9258-a68d9f408ad9&rdquo;}, {&ldquo;attributes&rdquo;: {&ldquo;plot&rdquo;: {&ldquo;type&rdquo;: &ldquo;Plot&rdquo;, &ldquo;id&rdquo;: &ldquo;c934a86a-f746-48a4-a859-ce278ffa3d43&rdquo;}, &ldquo;id&rdquo;: &ldquo;7112fa2f-ab63-440e-9129-053bddd7e3d3&rdquo;, &ldquo;doc&rdquo;: null}, &ldquo;type&rdquo;: &ldquo;ResizeTool&rdquo;, &ldquo;id&rdquo;: &ldquo;7112fa2f-ab63-440e-9129-053bddd7e3d3&rdquo;}, {&ldquo;attributes&rdquo;: {&ldquo;doc&rdquo;: null, &ldquo;renderers&rdquo;: [{&ldquo;type&rdquo;: &ldquo;Glyph&rdquo;, &ldquo;id&rdquo;: &ldquo;44591e70-15e1-4d3a-a597-90c0d454d5d2&rdquo;}, {&ldquo;type&rdquo;: &ldquo;Glyph&rdquo;, &ldquo;id&rdquo;: &ldquo;edfc1870-027f-497f-9f6a-215d97b6bc22&rdquo;}], &ldquo;id&rdquo;: &ldquo;e0f2724a-5700-46db-8fed-e1814cc03568&rdquo;}, &ldquo;type&rdquo;: &ldquo;BoxSelectTool&rdquo;, &ldquo;id&rdquo;: &ldquo;e0f2724a-5700-46db-8fed-e1814cc03568&rdquo;}, {&ldquo;attributes&rdquo;: {&ldquo;doc&rdquo;: null, &ldquo;tool&rdquo;: {&ldquo;type&rdquo;: &ldquo;BoxSelectTool&rdquo;, &ldquo;id&rdquo;: &ldquo;e0f2724a-5700-46db-8fed-e1814cc03568&rdquo;}, &ldquo;id&rdquo;: &ldquo;562db128-0818-4abe-8725-348e4c8f81e8&rdquo;}, &ldquo;type&rdquo;: &ldquo;BoxSelection&rdquo;, &ldquo;id&rdquo;: &ldquo;562db128-0818-4abe-8725-348e4c8f81e8&rdquo;}, {&ldquo;attributes&rdquo;: {&ldquo;plot&rdquo;: {&ldquo;type&rdquo;: &ldquo;Plot&rdquo;, &ldquo;id&rdquo;: &ldquo;c934a86a-f746-48a4-a859-ce278ffa3d43&rdquo;}, &ldquo;id&rdquo;: &ldquo;da85aeb2-a765-49bf-85ed-a3036d5df8c5&rdquo;, &ldquo;doc&rdquo;: null}, &ldquo;type&rdquo;: &ldquo;ResetTool&rdquo;, &ldquo;id&rdquo;: &ldquo;da85aeb2-a765-49bf-85ed-a3036d5df8c5&rdquo;}, {&ldquo;attributes&rdquo;: {&ldquo;plot&rdquo;: {&ldquo;type&rdquo;: &ldquo;Plot&rdquo;, &ldquo;id&rdquo;: &ldquo;c934a86a-f746-48a4-a859-ce278ffa3d43&rdquo;}, &ldquo;doc&rdquo;: null, &ldquo;dimensions&rdquo;: [&ldquo;width&rdquo;, &ldquo;height&rdquo;], &ldquo;id&rdquo;: &ldquo;b796f625-8d66-4695-aa87-ad66ac6576b6&rdquo;}, &ldquo;type&rdquo;: &ldquo;WheelZoomTool&rdquo;, &ldquo;id&rdquo;: &ldquo;b796f625-8d66-4695-aa87-ad66ac6576b6&rdquo;}, {&ldquo;attributes&rdquo;: {&ldquo;doc&rdquo;: null, &ldquo;children&rdquo;: [{&ldquo;type&rdquo;: &ldquo;Plot&rdquo;, &ldquo;id&rdquo;: &ldquo;c934a86a-f746-48a4-a859-ce278ffa3d43&rdquo;}], &ldquo;id&rdquo;: &ldquo;52d4784d-e61d-4cb8-8484-9f1d866a9520&rdquo;}, &ldquo;type&rdquo;: &ldquo;PlotContext&rdquo;, &ldquo;id&rdquo;: &ldquo;52d4784d-e61d-4cb8-8484-9f1d866a9520&rdquo;}, {&ldquo;attributes&rdquo;: {&ldquo;column_names&rdquo;: [&ldquo;x&rdquo;, &ldquo;y&rdquo;], &ldquo;doc&rdquo;: null, &ldquo;selected&rdquo;: [], &ldquo;discrete_ranges&rdquo;: {}, &ldquo;cont_ranges&rdquo;: {}, &ldquo;data&rdquo;: {&ldquo;y&rdquo;: [25.9, 29.5, 27.9, 25.9, 29.9, 29.9, 30.9, 28.9, 84.9, 82.9, 35.9, 31.5, 31.0, 30.9, 30.0, 28.9, 36.9, 41.9, 40.5, 43.9, 37.5, 37.9, 44.5, 37.9, 38.9, 36.9, 45.8, 41.0], &ldquo;x&rdquo;: [3.472, 3.531, 2.275, 4.05, 4.455, 4.455, 5.85, 9.52, 9.8, 12.8, 6.435, 4.9883, 5.52, 6.666, 5.0, 9.52, 5.15, 6.902, 7.102, 7.8, 5.52, 4.0, 9.89, 6.7265, 9.15, 8.0, 7.3262, 5.0]}, &ldquo;id&rdquo;: &ldquo;550be8bf-b9ec-4999-8154-cc5370c6d3af&rdquo;}, &ldquo;type&rdquo;: &ldquo;ColumnDataSource&rdquo;, &ldquo;id&rdquo;: &ldquo;550be8bf-b9ec-4999-8154-cc5370c6d3af&rdquo;}];
var modelid = &ldquo;52d4784d-e61d-4cb8-8484-9f1d866a9520&rdquo;;
var modeltype = &ldquo;PlotContext&rdquo;;
var elementid = &ldquo;dd236cf6-808e-4d6c-9a6d-c3737029b713&rdquo;;
console.log(modelid, modeltype, elementid);
Bokeh.load_models(all_models);
var model = Bokeh.Collections(modeltype).get(modelid);
var view = new model.default_view({model: model, el: &lsquo;#dd236cf6-808e-4d6c-9a6d-c3737029b713&rsquo;});
});
</script>
</p>
<div class="plotdiv" id="dd236cf6-808e-4d6c-9a6d-c3737029b713">Plots</div>


<p>And that is fine and dandy.  However, we’re left with the cold hard truth: using NumPy is lame when you can implement the algorithm yourself.  <sup class="footnote-ref" id="fnref:2"><a href="#fn:2" rel="footnote">2</a></sup></p>


<p>In fact, creating a basic one-dimensional regression takes less than a dozen lines of Python!  Specifically, we’re going to be co-opting this <a href="http://en.wikipedia.org/wiki/Simple_linear_regression">simple linear regression equation</a> from Wikipedia:</p>


<p><img alt="" src="http://upload.wikimedia.org/math/d/a/a/daadbe12908cba8971ddc97c2904e582.png"/></p>


<p>(This is a little different in practice than the standard linear regression equation, which involves pre-computing the mean and subtracting it from values as we multiply and sum them.  The trade-off here is a slight performance increase and a slighter readability increase in exchange for theoretic precision issues due to floating point arithmetic.  That being said, this is totally cool for the purposes of didactics!)</p>


<p>Anyhow, this equation becomes:</p>


<pre><code>def basic_linear_regression(x, y):
    # Basic computations to save a little time.
    length = len(x)
    sum_x = sum(x)
    sum_y = sum(y)

    # Σx^2, and Σxy respectively.
    sum_x_squared = sum(map(lambda a: a * a, x))
    sum_of_products = sum([x[i] * y[i] for i in range(length)])

    # Magic formulae!
    a = (sum_of_products - (sum_x * sum_y) / length) / (sum_x_squared - ((sum_x ** 2) / length))
    b = (sum_y - a * sum_x) / length
    return a, b
</code></pre>


<p>And if we call our new method using the same arrays as before, we get:</p>


<pre><code>(3.8773910821388129, 13.105872988455717)
</code></pre>


<p>Which is accurate within eight degrees of freedom.  <sup class="footnote-ref" id="fnref:3"><a href="#fn:3" rel="footnote">3</a></sup>  Yay!</p>


<div class="footnotes">
<hr/>
<ol>
<li id="fn:1">Remember, x is in thousands of square feet and y is in hundreds of dollars.  Yes, those are weird units.
 <a class="footnote-return" href="#fnref:1"><sup>[return]</sup></a></li>
<li id="fn:2">Full disclosure: using NumPy is never lame.  Installing NumPy, on the other hand…
 <a class="footnote-return" href="#fnref:2"><sup>[return]</sup></a></li>
<li id="fn:3">And, if this was more than toy data, would likely take orders of magnitude longer – but this is optimizing for readability, not agility
 <a class="footnote-return" href="#fnref:3"><sup>[return]</sup></a></li>
</ol>
</div>
	