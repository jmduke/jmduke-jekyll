---
title: "Making caves with cellular automata"
Date: 2014-03-17 00:00:00
Tags: ["development"]
layout: post
---

<p>So, I play a lot of <a href="http://crawl.develz.org">Dungeon Crawl</a>, and one thing I’m consistently impressed with is the quality of the randomly generated levels: far more advanced than the standard “lots of rectangles connected by elbow corridors” made popular by <em>Rogue</em> and CS201 classes everywhere, they tend to incorporate a wide variety of techniques and approaches to preserve a sense of novelty. <sup class="footnote-ref" id="fnref:2"><a href="#fn:2" rel="footnote">1</a></sup></p>


<p>One of the main ‘themes’ of a specific floor is that of a semi-open cavern, which I thought would be interesting to try and reproduce on my own in JavaScript – in the process I got to learn a few new things, and it’s always fun to see how a relatively obscure concepts can apply fantastically to the most random things. <sup class="footnote-ref" id="fnref:1"><a href="#fn:1" rel="footnote">2</a></sup></p>


<h3 id="the-basic-algorithm">The basic algorithm</h3>


<p>As you might have guessed from the title of this post, the core of the algorithm comes from an application of <a href="http://en.wikipedia.org/wiki/Cellular_automata">cellular automata</a> (also known as <em>The Game of Life</em>).  Specifically, the algorithm is the following (imagine, like below, that you have a sixty by forty grid of cells/tiles):</p>


<pre><code>1. set the borders to become walls
2. randomly set a percentage (let's say 40%) of the tiles to be walls
3. for a certain number of evolutions (let's say 5):
  a. iterate over each cell.
  b. if a 3x3 grid centered over the cell contains at least five walls, it stays a wall.
  c. otherwise, it becomes/stays empty.
4. admire your badass cave
</code></pre>


<p>The logic here is relatively simple, and you can see the results below (be sure to evolve and reset it yourself!): <sup class="footnote-ref" id="fnref:3"><a href="#fn:3" rel="footnote">3</a></sup></p>


<p></p>
<div class="map" id="basic"></div>


<a href="javascript:;" id="reset">Reset</a>


<a href="javascript:;" id="evolve">Evolve</a>


<p>Now this is actually a pretty neat result considering it’s such a simple algorithm, but there are a few things missing.  In particular, I have two complaints:</p>


<ol>
<li>Inconsistency: every once and a while we end up with relatively spacious caves, which aren’t objectively terrible or anything but not particularly ideal.</li>
<li>Some poor little caves get cutoff from the rest of the system.</li>
</ol>


<h3 id="getting-vaguely-fancy">Getting vaguely fancy</h3>


<p>Let’s address the first issue with the most naive possible solution, shall we?  If we’re worried about open spaces, it’d behoove us to try and systemically remove open space.  So let’s modify the algorithm a little:</p>


<pre><code>1. set the borders to become walls
2. randomly set a percentage (let's say 40%) of the tiles to be walls
3. for a certain number of evolutions (let's say 5):
  a. iterate over each cell.
  b. if a 3x3 grid centered over the cell contains at least five walls, it stays a wall.
  c. if a 3x3 grid center overed the cell contains no walls, it becomes a wall.
  d. otherwise, it becomes/stays empty.
4. admire your badass cave
</code></pre>


<p>And the result, again, is below:</p>


<p></p>
<div class="map" id="basic2"></div>


<a href="javascript:;" id="reset2">Reset</a>


<a href="javascript:;" id="evolve2">Evolve</a>


<p>So this tiny tweak gives us a much different result, right?  We end up with thinner passages for sure – as any open space with a width of three or more gets swallowed by the next evolution – and the result is something that looks like the handiwork of, say, crazed goblins as opposed to a dragon with too much time on its hands.  Unfortunately, the islanded caves is still an issue (if anything, it’s more prominent) and we get a lot of one-tile columns that spot up the place, which looks a little strange.</p>


<p>Let’s opt for a compromise: first we make sure we’ve got something chock-full with corridors, then carve it up and clean it a little.  In algorithmic form:</p>


<pre><code>1. set the borders to become walls
2. randomly set a percentage (let's say 40%) of the tiles to be walls
3. for a certain number of evolutions (let's say 3):
  a. iterate over each cell.
  b. if a 3x3 grid centered over the cell contains at least five walls, it stays a wall.
  c. if a 3x3 grid centered over the cell contains exactly two walls, it becomes a wall.
  d. otherwise, it becomes/stays empty.
4. for a certain number of evolutions (let's say 3):
  a. iterate over each cell.
  b. if a 3x3 grid centered over the cell contains at least five walls, it stays a wall.
  c. otherwise, it becomes/stays empty.
5. admire your badass cave
</code></pre>


<p>And the results are below:</p>


<p></p>
<div class="map" id="basic3"></div>


<a href="javascript:;" id="reset3">Reset</a>


<a href="javascript:;" id="evolve3">Evolve</a>


<p>Perfect!</p>


<h3 id="flooding-our-caves">Flooding our caves</h3>


<p>Well, not perfect.  We still have that whole island problem.  There are a few obvious solutions to be made here:</p>


<ul>
<li>Ignore the damn thing, since caverns collapse all the time</li>
<li>Fill in the disconnects</li>
<li>Connect the disconnected caverns</li>
</ul>


<p>I’m going to opt for the third one for its uncanny ability to provide a local maxima of cavern/evolution, which is a very important metric that I just made up.  Our logic here hinges on a couple assumptions:</p>


<ul>
<li>if two caverns are connected, then you can move between any space between them freely</li>
<li>if a given point can be reached by every cavern, then all caverns are connected</li>
</ul>


<p>So we’re going to use the following basic algorithm:</p>


<pre><code>1. for each distinct cave in the grid:
  a.  set (x,y) to a random point in the cave
  b.  while (x,y) is not equal to the exact center of the grid and (x,y) is not in a separate cave from the original point:
    i. increment/decrement either x or y such that (x, y) is now closer to the center
    ii. if (x, y) is a wall, remove it
2. admire your badass cave
</code></pre>


<p>Here’s the problem: how do we figure out where our caves are?  From a visual standpoint it’s obvious, but since we’re theoretically storing this as a mere two-dimensional array of booleans, we have no way of creating the caves themselves.</p>


<p>Enter the <a href="http://en.wikipedia.org/wiki/Flood_fill">flood fill algorithm</a>, which you’ve likely used dozens of times before. <sup class="footnote-ref" id="fnref:4"><a href="#fn:4" rel="footnote">4</a></sup></p>


<pre><code>1.  for each cell in the grid:
  a.  if the cell is a wall, skip
  b.  if the cell has already been assigned to a cavern, skip
  c.  add all the cell's direct neighbors to a queue
  d.  while that queue is not empty, dequeue the first cell and goto 1a.
2.  alas, your cave has not changed in badassery
</code></pre>


<p>It’s worth noting two things about this approach:</p>


<ul>
<li>In this theoretical example, you can travel diagonally, so ‘direct neighbors’ means all eight cardinal directions</li>
<li>This is crazy inefficient but our use case is a relatively small grid so eh who cares</li>
</ul>


<p>So we implement the two algorithms above and get the following (hit ‘connect’ to run the floodfill and the random walk):</p>


<p></p>
<div class="map" id="basic5"></div>


<a href="javascript:;" id="reset5">Reset</a>


<a href="javascript:;" id="evolve5">Evolve</a>


<a href="javascript:;" id="connect5">Connect</a>


<h3 id="closing-thoughts">Closing thoughts</h3>


<p>And that’s it!  It’s a handful of pretty basic algorithms that you can combine to do really cool things.  There are definitely some weaknesses that can be addressed with special cases (I think the connecting corridors could look way better, and if there isn’t a cavern in the center it might look a little wonky), but it was a lot of fun for me to tinker around with this.</p>


<p>Also, feel free to view-source this page and check out the implementation in JavaScript – but be warned, I optimized for laziness and not for readability.  Hope you enjoyed reading, and since you made it to the end here are some <a href="oryxdesignlab.com/sprites/lofi-fantasy-sprite-set">neat sprites</a> overlaid on a 15x30 grid, using our second approach:</p>


<p></p>
<div class="map" id="final"></div>


<a href="javascript:;" id="reset4">Reset</a>


<a href="javascript:;" id="evolve4">Evolve</a>


<a href="javascript:;" id="connect4">Connect</a>


<a href="javascript:;" id="populate">Populate</a>


<p>(Thanks to Jake and Sonny for reading a draft of this, and <a href="http://www.pixelenvy.ca/wa/ca_cave.html">this article</a> for inspiration.)</p>


<script type="text/javascript">

  // Default width and height of the grids we'll be using.
  var width = 60;
  var height = 40;

  // Internal counter of how many times the evolution button has been clicked,
  // since we change logic after a certain number of iterations.  Very bad, much hacky.
  var e3 = 0;

  // "Reset" button.
  function initializeMap(selector, width, height, fill_probability) {
    // Empty the container div.
    $(selector).empty();

    // Iterate over each row and column.
    for (var i = 0; i < height; i++) {
      var row = jQuery("<div></div>");
      for (var j = 0; j < width; j++) {

        // If it meets the chance OR is a border, make it a wall.
        var isWall = Math.random() < fill_probability || i == 0 || i == height - 1 || j == 0 || j == width - 1;

        // We track the wall/empty status via a spurious attribute.  Actual approaches would involve
        // real variables.  Again: very bad, much hacky.
        var cell = "<div fill=" + isWall + "></div>";
        row.append(cell);

      }
      $(selector).append(row);
    }
    e3 = 0;
   }

   // Main logic for the "Evolve" button.
   function evolveWrapper(selector, width, height, func) {
    for (var i = 0; i < height; i++) {
      for (var j = 0; j < width; j++) {
        var adjacentWalls = 0;
        $(selector).children().slice(i - 1, i + 2).each(function() {
          $(this).children().slice(j - 1, j + 2).each(function() {
            if ( $(this).attr('fill')  == 'true' )
              adjacentWalls += 1;
          });
        });
        var isWall = func(adjacentWalls) || i == 0 || i == height - 1 || j == 0 || j == width - 1;
        $(selector).children().eq(i).children().eq(j).attr('fillTemp', isWall);
      }
    }

      $(selector).children().each(function() {
        $(this).children().each(function() {
          $(this).attr('fill', $(this).attr('fillTemp'));
        });
      });
   }


   function evolveMap(selector, width, height) {
    evolveWrapper(selector, width, height, function(adj) {
      return adj > 4;
    });
   }

   function evolveMap2(selector, width, height) {
    evolveWrapper(selector, width, height, function(adj) {
      return adj > 4 || adj == 0;
    });
   }

  function evolveMap3(selector, width, height) {
    evolveWrapper(selector, width, height, function(adj) {
      return adj > 4 || (e3 < 3 && adj == 2);
    });
    e3++;
   }

   function floodFill(selector, width, height) {
    var floodGates = [];
    var currentCavern = 0;

    function processCell(tup) {
        var i = tup[0];
        var j = tup[1];
        var cell = $(selector).children().eq(i).children().eq(j);

        // If the cell is a wall, we skip it.
        if (cell.attr('fill') == 'true') {
          return;
        }

        // If the cell has already been designated, we skip it.
        if (cell.attr('cavern') !== false && typeof cell.attr('cavern') !== 'undefined') {
          return;
        }

        cell.attr('cavern', currentCavern);

        // We add diagonal neighbors as well, since diagonal movement is a thing.
        floodGates.push([i - 1, j]);
        floodGates.push([i + 1, j]);
        floodGates.push([i, j - 1]);
        floodGates.push([i, j + 1]);
        floodGates.push([i - 1, j - 1]);
        floodGates.push([i + 1, j + 1]);
        floodGates.push([i + 1, j - 1]);
        floodGates.push([i - 1, j + 1]);
    }

    for (var i = 0; i < height; i++) {
      for (var j = 0; j < width; j++) {
        processCell([i, j]);
        while (floodGates.length > 0) {
          processCell(floodGates.pop());
          // If we just finished up the cavern, increment the number.
          if (floodGates.length == 0) {
            currentCavern++;
          }
        }
      }
    }
   }

   function connectCaverns(selector, width, height) {
    var currentCavern = 0;
    var centerX = Math.floor(width / 2);
    var centerY = Math.floor(height / 2)
    var centerIndex = [centerX, centerY];
    var centerTile = $(selector).children().eq(centerY).children().eq(centerX);

    while ($("[cavern='"+currentCavern+"']").length > 0) {
      var cavernTiles = $("[cavern='"+currentCavern+"']");
      var initialTile = cavernTiles.eq(Math.floor(Math.random() * cavernTiles.length));
      var currentTile = initialTile;

      var x = initialTile.index();
      var y = initialTile.parent().index();

      while (
        centerIndex.toString() != [x, y].toString() &&
        initialTile.attr('cavern') != centerTile.attr('cavern') &&
        (
          (currentTile.attr('cavern') === false || typeof currentTile.attr('cavern') == 'undefined') ||
          initialTile.attr('cavern') == currentTile.attr('cavern')
        )
      ) {
        var xDiff = centerIndex[0] - x;
        var yDiff = centerIndex[1] - y;
        if (Math.random() < 0.5 && xDiff != 0) {
          x += (xDiff > 0) ? 1 : -1
        } else {
          y += (yDiff > 0) ? 1 : -1
        }
        currentTile = $(selector).children().eq(y).children().eq(x);
        currentTile.attr('fill', 'false');
      }
      currentCavern++;
    }
   }



  initializeMap("#basic", width, height, .45);

   $("#reset").click(function(){
      initializeMap("#basic", width, height, .45);
   });

   $("#evolve").click(function() {
      evolveMap("#basic", width, height);
   });

     initializeMap("#basic2", width, height, .45);

   $("#reset2").click(function(){
      initializeMap("#basic2", width, height, .45);
   });

   $("#evolve2").click(function() {
      evolveMap2("#basic2", width, height);
   });

    initializeMap("#basic3", width, height, .35);

   $("#reset3").click(function(){
      initializeMap("#basic3", width, height, .35);
   });

   $("#evolve3").click(function() {
      evolveMap3("#basic3", width, height);
   });

  initializeMap("#basic5", width, height, .35);

   $("#reset5").click(function(){
      initializeMap("#basic5", width, height, .35);
   });

   $("#evolve5").click(function() {
      evolveMap3("#basic5", width, height);
   });

      $("#connect5").click(function() {
      floodFill("#basic5", 60, 40);
      connectCaverns("#basic5", 60, 40);
   });


    initializeMap("#final", 30, 15, .35);

   $("#reset4").click(function(){
      initializeMap("#final", 30, 15, .35);
   });

   $("#evolve4").click(function() {
      evolveMap2("#final", 30, 15);
   });


   $("#connect3").click(function() {
      floodFill("#basic3", 60, 40);
      connectCaverns("#basic3", 60, 40);
   });

    $("#connect4").click(function() {
      floodFill("#final", 30, 15);
      connectCaverns("#final", 30, 15);
   });

    $("#populate").click(function() {
      var cavernTiles = $("#final div div[fill='false']");
      var initialTile = cavernTiles.eq(Math.floor(Math.random() * cavernTiles.length));
      initialTile.append("<img src='/static/c4.png'>");

      for (var i = 0; i < 3; i++) {
        var cavernTiles = $("#final div div[fill='false']");
        var initialTile = cavernTiles.eq(Math.floor(Math.random() * cavernTiles.length));
        initialTile.append("<img src='/static/c3.png'>");
      }

      for (var i = 0; i < 2; i++) {
        var cavernTiles = $("#final div div[fill='false']");
        var initialTile = cavernTiles.eq(Math.floor(Math.random() * cavernTiles.length));
        initialTile.append("<img src='/static/c5.png'>");
      }
   });



</script>


<style type="text/css">
  .map div div {
    width: 8px;
    height: 9px;
    float: left;
    background: url('/static/c2.png');
    background-size: 100%;
  }

  #final div div {
    width: 16px;
    height: 16px;
  }

  .map div, .map div {
    float: left;
    width: 100%;
  }



  .map div[fill="true"], .map div[fill="true"] {
    background: url('/static/c1.png');
    background-size: 100%;
  }

  /* Oh god please don't judge me for this */
  a[href="javascript:;"] {
    background-color: #aaa;
    padding: 0.5em;
    margin: 0.5em;
    margin-top: 1em;
    color: #fff;
  }

  a[href="javascript:;"]:hover {
    background-color: #f15b29;
    border: none;
  }

  .code {
    display: none;
  }


</style>


<div class="footnotes">
<hr/>
<ol>
<li id="fn:2">Obviously worth noting is that I’m sure this technique has been around for long before Crawl.
 <a class="footnote-return" href="#fnref:2"><sup>[return]</sup></a></li>
<li id="fn:1">It’s used in Orc and Jelly, if that means anything to you.
 <a class="footnote-return" href="#fnref:1"><sup>[return]</sup></a></li>
<li id="fn:3">If you’re confused, try fixating on one cell and watching how it changes as you click the ‘evolve’ button.
 <a class="footnote-return" href="#fnref:3"><sup>[return]</sup></a></li>
<li id="fn:4">You ever notice how the excitement of an algorithm is often in inverse proportion to the excitement of it’s name?  Flood fill: sounds awesome, pretty boring logic.  <a href="http://en.wikipedia.org/wiki/Timsort">Timsort</a>: sounds like an off-brand sleep aid, ends up being awesome.
 <a class="footnote-return" href="#fnref:4"><sup>[return]</sup></a></li>
</ol>
</div>
	