---
layout: post
title: aren't they all just vanity metrics?
---
My coworker Jonnie wrote about his hitherto use of analytics for his side project and it resonated very closely with my experience:

<blockquote class="quoteback" darkmode="" data-title="Intentional analytics" data-author="Jonnie Hallman" cite="https://destroytoday.com/blog/intentional-analytics">
<p>Like many others, we inserted the snippet, started collecting the firehose of data, and didn’t do much with it. Despite being really into stats and numbers, I’m actually not really into analytics. I’d much rather spend my time designing and building, but that’s naive because at the end of the day you need to know what to build and how it should be designed.</p>
<footer>Jonnie Hallman<cite> <a href="https://destroytoday.com/blog/intentional-analytics">https://destroytoday.com/blog/intentional-analytics</a></cite></footer>
</blockquote><script note="" src="https://cdn.jsdelivr.net/gh/Blogger-Peer-Review/quotebacks@1/quoteback.js"></script>

With Buttondown, I've played the "maybe this time I'll actually use metrics" game a huge number of times.  The two that immediately come to mind are I think notable in how separate they are:

- pre-launch, I was very into the Amplitude/Segment stack and tried to tie every in-app user action to some event which I then went on to use _never, not a single time, not even once_
- last year, I thought to myself "ah, the issue here is that I am not thinking backwards from the metrics dashboard that I would like to consume", so spent a few weeks meticulously building out a nice dashboard in [Redash](https://redash.io), which I then went on to use _never, not a single time, not even once_

I'd like to say that this was motivated by a sort of individualist aesthetic — I don't need the numbers, I know what's right! — but the truth was more mundane: the prioritization was too manic and too reactive to warrant metrics.  I have pretty much the entire time operated on a push-based model of work — the things that are _truly_ important are the things about which some system is already yelling me: rising costs, important bugs, obvious feature gaps.

"Looking at the metrics" always seemed like a first-world problem in some respects: it signals that you have an empty roadmap or a surfeit of time to spend.  When you're dealing with a relatively small budget of engineering (and, well, all other) resources, you have to get a little craftier.

One tactic that I've settled on recently, though, is database-as-metrics-backend, which is exactly what it sounds like: if I want to track something I need to create an object in the Django ORM for it.  This isn't exactly exciting stuff:

```
class UserFacingEmailReceipt(models.Model):
    """
    Represents us successfully sending a lifecycle or transactional email.
    Mostly used for auditing.
    """

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    user = models.ForeignKey(
        User, on_delete=models.CASCADE, related_name="user_facing_email_receipts"
    )
    email_type = models.CharField(max_length=200)
    creation_date = models.DateTimeField(auto_now_add=True)
```

But it offers a couple advantages:

- It's slightly more annoying than just logging! I have to go through a non-trivial amount of effort.
- The data is inherently relational and multi-faceted.  With this meager model I can see what lifecycle emails result in logins by joining against the LoginAttempt table; I can see what lifecycle emails result in unsubscriptions from the lifecycle system by joining against the Newsletter.
- Most importantly, this means that elevating this from "metric" to "business-facing model" is a no-op.  I've found that most _truly_ interesting things that I track end up getting used somewhere else in the app at some point. 

Obviously, this doesn't scale. Metrics backends exist for a reason, and if Buttondown were to hit, say, three orders of magnitude larger than it currently sits then all of this would probably collapse.  But Buttondown is small, and time is short, and I like this solution.
