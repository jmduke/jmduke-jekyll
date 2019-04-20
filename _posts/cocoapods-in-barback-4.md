---
title: "The CocoaPods I Used in Barback 4"
Date: 2017-02-08 00:00:00
Tags: ["swift"]
layout: post
---

<p>I <em>love</em> dependency files.  Whenever I go through a new repository for the first time, I always take a look at it’s dependencies first.  They’re revealing about the code and the author in so many interesting ways:</p>


<ul>
<li>What kind of stuff does the author think is worthy of rolling himself, versus bringing something in?</li>
<li>What difficult problems does the app need help solving?</li>
</ul>


<p>Unfortunately, for most launched/active apps and services, it’s hard to actually see these files (for totally obvious and valid reasons.). I feel like this leads to a tribal knowledge situation with package discovery: how are you supposed to learn about killer dependencies without getting to look under the hood?</p>


<p>I’ve been fairly cavalier with my cocktail app, <a href="http://getbarback.com">Barback</a>, to the extent that previous major versions have been posted on GitHub.  The newest version of Barback isn’t open source (largely because the code is bad), but I wanted to give a dive into the dependencies I pulled in, in hopes that y’all might find it interesting.</p>


<p>So, first, here’s the Podfile for <a href="http://getbarback.com">Barback 4</a>.  It’s pretty small!</p>


<pre><code>target 'Barback' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Barback
  pod 'Alamofire'
  pod 'AlamofireObjectMapper'
  pod 'Armchair', :git =&gt; 'https://github.com/UrbanApps/Armchair.git', :branch =&gt; 'swift3'
  pod 'Crashlytics'
  pod 'DZNEmptyDataSet'
  pod 'Fabric'
  pod 'Onboard'
  pod 'Popover'
  pod 'Reveal-SDK', '~&gt; 5', :configurations =&gt; ['Debug']
  pod 'Stencil', :git =&gt; 'https://github.com/kylef/Stencil.git'
  pod 'SwiftLint'
  pod 'SwiftHEXColors'
  pod 'SwiftyUserDefaults'
  pod 'TSMarkdownParser'
  target 'BarbackTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'BarbackUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
</code></pre>


<p>Now, line by line, each dependency and why I brought it in:</p>


<h3 id="alamofire-https-github-com-alamofire-alamofire"><a href="https://github.com/Alamofire/Alamofire">Alamofire</a></h3>


<p>The definitive networking framework for Swift.</p>


<h3 id="alamofireobjectmapper-https-github-com-tristanhimmelman-alamofireobjectmapper"><a href="https://github.com/tristanhimmelman/AlamofireObjectMapper">AlamofireObjectMapper</a></h3>


<p>A marriage between Alamofire and the lovely serialization framework ObjectMapper.  It lets me do stuff like this (snippet): my only qualm is that I wish it didn’t necessitate that all attributes be optional, but it’s still worth the price.</p>


<h3 id="armchair-https-github-com-urbanapps-armchair"><a href="https://github.com/UrbanApps/Armchair">Armchair</a></h3>


<p>Bog-standard review nagging framework.  It looks like I’ll get to remove this relatively soon in favor of iOS’s <a href="https://www.macstories.net/news/ios-10-3-to-standardize-in-app-review-prompts-developers-to-gain-ability-to-respond-to-customer-reviews/">first-party replacement</a>.</p>


<h3 id="crashlytics-and-fabric-fabric-io"><a href="fabric.io">Crashlytics and Fabric</a></h3>


<p>Handling of error reporting and basic analytics.  The interface isn’t perfect and I wish there was an API, but the price is right and I have found no reason to switch.</p>


<h3 id="dznemptydataset-https-github-com-dzenbot-dznemptydataset"><a href="https://github.com/dzenbot/DZNEmptyDataSet">DZNEmptyDataSet</a></h3>


<p>Super simple empty state displays.  Nothing fancy, but it saved me like an hour of implementation work.</p>


<h3 id="onboard-https-github-com-mamaral-onboard"><a href="https://github.com/mamaral/Onboard">Onboard</a></h3>


<p>Basically a wrapper around UIPageController that allows for onboarding tutorials.  I’ve customized it  for Barback to the point where using it doesn’t even really make that much sense, but it does it’s job capably even if you have to get pretty gross with hacking its’ views. (Gif).</p>


<h3 id="popover-https-github-com-corin8823-popover"><a href="https://github.com/corin8823/Popover">Popover</a></h3>


<p>Facebook-style popover views (gif). Simple concept, strong implementation.</p>


<h3 id="reveal-sdk-https-revealapp-com"><a href="https://revealapp.com/">Reveal-SDK</a></h3>


<p>Used to hook into Reveal, a terrific view debugging tool.</p>


<h3 id="stencil-https-github-com-kylef-stencil"><a href="https://github.com/kylef/Stencil">Stencil</a></h3>


<p>Provides Jinja-esque HTML templating; I use this to create the HTML for printing recipes and ingredients.</p>


<h3 id="swiftlint-https-github-com-realm-swiftlint"><a href="https://github.com/realm/SwiftLint">SwiftLint</a></h3>


<p>It’s a listing tool.  I go back and forth on it, as I’m not a huge fan of a lot of the default rules and would prefer to wait to see a style guide emerge that I really dig, but it’s better than nothing.</p>


<h3 id="swifthexcolors-https-github-com-thii-swifthexcolors"><a href="https://github.com/thii/SwiftHEXColors">SwiftHEXColors</a></h3>


<p>Hexes to UIColors.  I think there are like a dozen variations on this exact same idea but this was the first one in Google, and it does exactly what I want it to do.</p>


<h3 id="swiftyuserdefaults-https-github-com-radex-swiftyuserdefaults"><a href="https://github.com/radex/SwiftyUserDefaults">SwiftyUserDefaults</a></h3>


<p>Syntactical sugar around NSUserDefaults.  Barback doesn’t store any server-side user information and uses NSUserDefaults for pretty much everything (including a lightweight cache layer), so this makes all of that interfacing much cleaner.</p>


<h3 id="tsmarkdownparser-https-github-com-laptobbe-tsmarkdownparser"><a href="https://github.com/laptobbe/TSMarkdownParser">TSMarkdownParser</a></h3>


<p>Information for recipes and ingredients are stored in markdown, and this parses them out to an NSAttributedString so they can be styled (rather than a lot of other approaches which involve UIWebViews.  Ick.). I’m not thrilled with this solution – the parser seems to ignore block quotes, for instance – but it gets the job done for the time being.</p>
	