---
layout: post
title: buttondown’s anti-roadmap
---
i’ve been [thinking](https://jmduke.com/2019/03/25/solvable-problems-in-a-mid-stage-side-project) [about](https://jmduke.com/2019/03/24/i-cant-solve-the-problem-with-coding) buttondown’s future a lot lately, trying to work out how to turn it from “growing and largely unmapped” into “sustainable and legible”. [^1]

i think it would be useful to enumerate some things i never want to build into the product.  this is helpful on two fronts:

1. to have an artifact to point to folks who ask if i will add these things, the number of whom seems to grow steadily. [^2]
2. to consciously limit the surface area of where the tool will grow, and to act as a map for a direction forward

### Social networking

<img src="https://i.ibb.co/pZ1J2vf/B02-CFDE1-C2-D3-4-BE5-995-A-57474-E23-FD98.png" alt="B02-CFDE1-C2-D3-4-BE5-995-A-57474-E23-FD98" border="0">

social networks are great [^3].  there are a whole host of social-network-y things that folks have asked for Buttondown to provide:

- social-graph-esque stuff, like having a dossier of all of your Buttondown newsletters
- leaderboards / unified feed of all newsletters
- “suggested newsletters”
- reactions

none of these will happen! i don’t like anything that perpetuates or strengthens the idea of buttondown as an “ecosystem” or a “platform”. 

### Automation

<img src="https://i.ibb.co/M9gBvcQ/7112821-E-7-F5-F-44-D4-BC4-A-2-D1-E7900104-C.png" alt="7112821-E-7-F5-F-44-D4-BC4-A-2-D1-E7900104-C" border="0">

email automation is really powerful.  it is stuff like:

- send a new subscriber a precise sequence of seven emails over three weeks
- send a subscriber that looked at but did not purchase a specific product a given email
- branching logic to send a given subscriber a given email depending on if they clicked a link in a previous email

there are [really powerful tools]() that do things like this, and whenever someone asks if buttondown will support this I point them to those tools.  

a lot of this is about laziness, frankly: automation is a pandora’s box, and as soon as i start trying to build it out i will inevitably fall into a rabbit hole of arcana.

but also... email automation isn’t for newsletters.  newsletters are a pretty specific thing, and i think as soon as you start getting into optimizing your email sequencing for e-commerce or whatever you’re not a newsletter.  not that that’s a moral judgment — it’s just not the thing i’m trying to build.

### Advertising

<img src="https://i.ibb.co/DCZ1rrt/B83-CCC47-670-C-44-FE-A71-D-9-C0-D32113-A13.png" alt="B83-CCC47-670-C-44-FE-A71-D-9-C0-D32113-A13" border="0">

i have no great moral outrage against advertising; I think there are a lot of completely valid business models that rely on advertising, and i think it works particularly well in industries like email and podcasts where there isn’t the terrifying obelisk of infrastructure and analytics.

rather, i don’t want Buttondown to mess around with advertising stuff too much because it’s a lot of effort and it muddies how i provide (and extract) value.  building out relationships with advertisers and publishers is difficult, onerous, and requires a lot of tooling and knowledge.

...

buttondown is a tool; the goal is to do a very specific thing as best as possible, and it’s helpful for me to remember that whenever i browse my comically large list of (331, at the time of writing) github issues.

[^1]: i’ve been rereading [seeing like a state](), so legible might not be the best choice of words here, but i digress
[^2]: which i don’t mind! the best things i’ve added to buttondown in the past six months have come from user suggestions
[^3]: citation needed
