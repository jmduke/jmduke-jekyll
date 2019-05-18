---
layout: post
title: Cleverness is bad but it’s also good
---
*(Or: how to write an unreasonable and ergonomic test suite for meta tags for Django.)*

[Buttondown](https://buttondown.email)’s codebase is littered with things that are *clever* and *bonkers*.  I am proud of these things, even as I recognize that they are probably unsafe and terrible ideas.  Take `expected_meta_tags.yaml`, which is a file that looks like this (truncated version):

```
"/{user.username}/archive":
    "title": "{newsletter.name}"
    "meta[name='description']": "{newsletter.description}"
"/{user.username}/archive/{email.slug}/":
    "title": "{email.subject}"
```

You can probably suss out what’s going on here.  It’s a mapping of routes to CSS selectors and expected values for those selectors.  Here’s how it gets parsed and used:

```
    def test_expected_meta_tags(self):
        # Used in f-strings.
        user = FakeData.user()
        email = FakeData.email(user=user)
        newsletter = user.newsletters.first()

        cases = yaml.load(open("emails/tests/cases/expected_meta_tags.yaml"))
        for (route, selector_to_value) in cases.items():
            for (selector, expected_value) in selector_to_value.items():
                with self.subTest(route=route, selector=selector):
                    response = self.client.get(eval(f'f"""{route}"""'))
                    html = fromstring(response.content)
                    matching_elements = CSSSelector(selector)(html)
                    self.assertTrue(len(matching_elements) > 0)
                    [matching_element] = matching_elements
                    value = (
                        matching_element.get("content")
                        if matching_element.tag == "meta"
                        else matching_element.text
                    )
                    self.assertEqual(value, eval(f'f"""{expected_value}"""'))
```

This isn’t the cleanest code in the world, but you can kind of see what’s going on, right?  

- I generate some fake data.
- I parse the YAML file, and interpolate the URL and expected values based on that fake data. [^1]
- I create a request at that URL, parse the resultant URL, and verify that everything looks sane.

This is something that, if I ran into in a random codebase, I would probably be terrified.  Using `eval` is an extremely bad idea.  But I stumbled upon a really nice DSL for testing meta tags, which is an onerous and annoying source of regressions for me due to Buttondown’s weird mix of server-side and client-side rendering; future regressions can now be tested just by adding an entry to a YAML file rather than mucking around with the `cssselect` package.

And it’s overly clever, for sure.  But writing clever code can be *fun*, and there are afternoons where the only way you’re going to get a task done is if you make it as fun for yourself as possible.

[^1]: The pattern of `eval(f’f”””{string}”””’)` is probably the funniest and most terrifying thing I’ve ever stumbled upon.
