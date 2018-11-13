---
Title: "Generators are dope"
Date: 2018-03-07
Tags: ["python"]
---


(This is also readable as a [gist](https://gist.github.com/jmduke/45a6fc4e70d31d901dca5ac768b85781), if you prefer.)

I love generators.  They're one of my favorite features in Python, and criminally underrated.  (Or underused?  Either way.)

<!--more-->

<style>
.highlight {
	margin-bottom: 4em;
}
</style>

Let's explore how they enable great abstractions through a topic near and dear to my heart: paginating through a very important list of sandwiches from Airtable. [^1]

<iframe class="airtable-embed" src="https://airtable.com/embed/shrOtbE9QRMJE4GSf?backgroundColor=green&viewControls=on" frameborder="0" onmousewheel="" width="100%" height="533" style="background: transparent; border: 1px solid #ccc;"></iframe>

First, let's grab that table:

{{< highlight python >}}

from airtable import airtable
table = airtable.Airtable('API_KEY', 'OTHER_KEY')

{{< / highlight >}}

Okay, so we want to fetch all results in a table.  Problem is, you know, pagination:
this table has hundreds of records but we can only get like fifty per call.
Here's how we abstract that out!

{{< highlight python >}}

def fetch_all_records(table_name):
    # Grab the first page.  The page has two fields we care about:
    # 1. records — aka the good stuff
    # 2. offset — a cursor to the next page.
    response = table.get(table_name)

    # If there's a cursor to the next page...
    while 'offset' in response:
        # Yield all the records on this page.
        # Records look like this:
        # {'fields': {'name': 'Salumi', 'city': 'Seattle', 'rating': 5}, 'id': 'as890ops'}
        for record in response['records']:
            yield record

        # Grab the next page and repeat the process.
        response = table.get('Finished', offset=response['offset'])

    # Otherwise, yield all the records and then we're done!
    for record in response['records']:
        yield record

{{< / highlight >}}

Now, to access all the records, we don't have to care about:

1. How many records are in a page
2. How to get to the next page
3. How to traverse the page.

All of that is abstracted away by the generator!
So we can just iterate through all of them like this:

{{< highlight python >}}

for record in fetch_all_records('Sandwiches'):
    print(record['fields']['Name'])

{{< / highlight >}}

And generators are lazy, too, so if we just want the first twenty items
we can do so without worrying about premature pagination:

{{< highlight python >}}

for i, record in enumerate(fetch_all_records('Sandwiches')):
    if i > 20:
        break
    print(record['fields']['Name'])

{{< / highlight >}}

Generators aren't great for everything.

For instance, operating on an entire corpus of an iterable is rough:
this code will force you to refetch the entire list over and over again.

{{< highlight python >}}

best_rating = max([record['fields']['Rating'] for record in fetch_all_records('Sandwiches')])
worst_rating = min([record['fields']['Rating'] for record in fetch_all_records('Sandwiches')])

{{< / highlight >}}

In such a case, you're better off casting the generator to a list.

(But you might be *best* off with a different approach entirely.)

{{< highlight python >}}

all_records = list(fetch_all_records('Sandwiches'))
best_rating = max([record['fields']['Rating'] for record in all_records])
worst_rating = min([record['fields']['Rating'] for record in all_records])

{{< / highlight >}}

Ultimately, generators are the best kind of Python feature:

1. They make it easier to understand code.
2. They make it easier to write code.
3. They're just *neat*.

{{< highlight python >}}

for record in fetch_all_records('Sandwiches'):
    # Gotta find a great sandwich in Seattle!
    if record['fields']['Rating'] > 4 and record['field']['City'] == 'Seattle':
        print(record['fields']['Name'])
        break
{{< / highlight >}}

Time for lunch!	

<br />

[^1]: Don't know what Airtable is?  It's basically Excel for developers. It's super cool. [Check it out.](http://airtable.com)
