---
Title: "What Vue needs next"
Date: 2017-07-01 00:00:00
Tags: ["development","vue"]
---

<p>I’ve been using Vue a lot recently on a few test projects, and most notably on <a href="http://buttondown.email">Buttondown</a>.</p>


<p>Buttondown’s frontend is 100% Vue: around twenty screens (which are themselves components) and around thirty miscellaneous components, tied together with Vuex and Vue-Router.</p>


<p>Overall, Vue is a really great tool, and the first word I’d use to describe it is <em>pragmatic</em>.  Almost everything feels and acts sensible; there are tremendously few times that I am confused or surprised by how it works, which is legitimately novel (and wonderous) after the hours and days and weeks I’ve spent pulling my hair out dealing with random React and Webpack arcana.</p>


<p>Still, there are some bugaboos that I think arise from Vue’s current niche as a “lightweight” approach to creating a functional SPA, in much the same way that Flask carved out a niche as being a lightweight alternative to Django.</p>


<p></p>


<h2 id="testing-vuex-coupled-components"><strong>Testing Vuex-coupled components</strong></h2>


<div class="note">
<strong>Note</strong>
<a href="vuex.vuejs.org/en/">Vuex</a> is the most popular (and arguably most Vue-blessed) state library for Vue; it's an implementation of the Flux architecture, so it has the same philosophy as Redux.
</div>


<p>Testing Vue components sucks.</p>


<p>It’s doable — I’ve done it — but it sucks.</p>


<p>Testing Vue components that rely on Vuex, through things like <code>mapState</code>, is a hellscape.</p>


<p>There’s very little documentation and very few StackOverflow questions to mine.  I legitimately cannot figure out how to do this in a non-insane manner.</p>


<p>The sad truth about my approach to testing is that if the ROI isn’t there then I punt on it until it is, which means I have lot of tiny tests for utility methods but no comprehensive front-end testing.  And, unfortunately, Vue’s desire lines point you towards encapsulating as much state logic in components as you can, which mean testing suffers.</p>


<p>(One thing I <em>could</em> probably do, but don’t want to because it feels like an anti-pattern, is migrating my usage of Vuex into <code>Wrapper</code> style components, where, say, <code>ScheduledEmailWrapper.vue</code> is a component that takes in Vuex state as computed properties and passes them into <code>ScheduledEmail.vue</code> as props, making <code>ScheduledEmail</code> much more stateless and testable.  But, again, that’s effort.)</p>


<h2 id="ide-tooling"><strong>IDE Tooling</strong></h2>


<p>The good news: there is IDE support for Vue.</p>


<p>The bad news: it’s not very robust.</p>


<p>The same Vue component, in VSCode and PyCharm:</p>


<p><img alt="VSCode" src="http://i.imgur.com/Cy1UAUj.png"/>
<img alt="PyCharm" src="http://i.imgur.com/HwEGVVh.png"/></p>


<p>As you can see, the basics are there: syntax highlighting goes a long way, to be honest.  But both IDEs have issues with formatting (PyCharm’s autoformat command will mangle the template code beyond recognition, for instance) and neither can parse the in-component CSS.  Moreover, general navigational commands – symbolic recognition for components, autocompletion, and basic type-checking.  It makes for a tough transition coming from React. (where the IDE tooling is just <em>incredible</em>)</p>


<h2 id="components-are-heavy"><strong>Components are heavy</strong></h2>


<p>One of the things I really like about React is how easy it is to pluck out a component: components are just functions (or classes now, I guess!) so it’s just taking a chunk of code out, wrapping it in a <code>render</code> function, and basically calling it a day.  Refactoring front-end code is relatively easy and light-weight, incentivizing developers to tease out lightweight and re-usable components.</p>


<p>Vue, though, is a different story.</p>


<p>Vue’s <a href="https://vuejs.org/v2/guide/single-file-components.html">single file component</a> paradigm is great for a lot of things, but it adds the friction of having to create a new file for each component.</p>


<p>That friction is compounded, too, by the requirement of registering components either in the global Vue namespace or in the components in which they’re invoked.</p>


<p>Obviously this is kind of trivial in the short term, but it creates a subtle disincentive to modularize and refactor your code.</p>


<p>I’d love a method of throwing multiple components into a single <code>.vue</code> file: that way, if I want to abstract out a <code>EmailInput</code> from a <code>NewSubscriberModal</code>, I can separate the actual code without needing to throw it in a new file and register that new file.</p>


<h2 id="conclusion">Conclusion</h2>


<p>I feel like the most important question to ask after trying out a new piece of technology is: <strong>If you had to do it over again, would you still use it?</strong></p>


<p>The answer for Vue is a resounding yes, even though there are a number of pain points that linger under the surface.</p>


<p>It feels obvious in use that Vue’s ecosystem is still growing, and hasn’t quite built out all the niceties that React has — which is tough in the short term but <em>completely reasonable</em>.</p>


<p>I have utmost faith that the Vue community is only going to keep growing and keep improving, and I’m excited for the next steps that the project takes.</p>
	