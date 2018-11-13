---
Title: "Globally accessible Vue properties"
Date: 2017-07-05 00:00:00
Tags: ["vue"]
---

<p>So, <a href="http://buttondown.email">Buttondown</a> uses <a href="https://github.com/ierror/django-js-reverse">django-js-reverse</a>, which is a <em>fantastic</em> way to handle naming URLs and consolidate routing logic.  It means that if I’ve got a bunch of views registered in Django like this…</p>


<pre><code>urls = [
    url(r'^export_data/', miscellany.export, name='export-data'),
    url(r'^resend-confirmation-email', miscellany.resend_confirmation_email, name='resend-confirmation-email'),
    url(r'^confirm-registration/(?P&lt;confirmation_id&gt;.+)', miscellany.confirm_registration, name='confirm-registration'),
    # And so on.
 ]
</code></pre>


<p>I can access those in a globally scoped object on the frontend, where keys are the URL names and the values are their corresponding endpoints:</p>


<pre><code>&gt; Urls.export_data()
"/api/emails/export_data/"
</code></pre>


<p>This is great for utility methods and such, but Vue’s single file components don’t have access to global variables (or, rather, variables declared on <code>window</code>.)  This is for good reason — explicit rather than implicit! — but still means if I want to reference this object in the template code itself:I have to expose it as a computed property:</p>


<pre><code>computed: {
    Urls() { return Urls; }
}
</code></pre>


<p>Sure, that’s only three lines, but it’s a pain in the ass feels unnecessarily repetitive.  Thankfully, Vue offers a better way, which they refer to as <a href="https://vuejs.org/v2/cookbook/adding-instance-properties.html">instance properties</a>:</p>


<blockquote>
<p>There may be data/utilities you’d like to use in many components, but you don’t want to pollute the global scope. In these cases, you can make them available to each Vue instance by defining them on the prototype.</p>
</blockquote>


<p>All you have to do is add <code>Urls</code> (or your object of choice) to Vue’s prototype method:</p>


<pre><code>Vue.config.productionTip = false;
Vue.prototype.Urls = Urls;

// Do the rest of your setup.
new Vue({
  el: '#app',
  router,
  store,
});
</code></pre>


<p>And ta-da!  All components now have access to <code>Urls</code>, so you can access it like so:</p>


<pre><code>&lt;a :href="Urls.export_data()"&gt;Export data&lt;/a&gt;
</code></pre>


<p></p>
	