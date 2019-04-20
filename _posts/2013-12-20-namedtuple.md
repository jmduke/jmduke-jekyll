---
title: "Namedtuple"
Date: 2013-12-20 00:00:00
Tags: ["python","development"]
layout: post
---

<p>We’ve all been there - working on a one-off script or personal project where you deal with lots of tuples: maybe points on a coordinate grid or time-series data, or anything imported from a <code>csv</code>.  You do the lazy thing and keep track of everything in a list of tuples, shrugging off that object-oriented nagging in the back of your head.</p>


<p>Python, as always, has a solution for your troubles, hidden in a rarely-accessed <code>collections</code> submodule.</p>


<p>Behold, ye mighty, and despair – I present to you <code>namedtuple</code>, a perfect middleground for developers like myself who are too precocious to live with poorly-documented tuple monstrosities and too lazy to do anything about it.</p>


<pre><code>&gt;&gt;&gt; from collections import namedtuple
&gt;&gt;&gt; Point = namedtuple("Point", ("x", "y"))
&gt;&gt;&gt; foo = Point(0, 4)
&gt;&gt;&gt; foo
Point(x=0, y=4)
&gt;&gt;&gt; foo.x
0
&gt;&gt;&gt; foo[1]
4
</code></pre>


<p>Behind the scenes, <code>namedtuple</code> actually creates an entire subclass of <code>tuple</code>, which you can verify by adding <code>verbose=True</code>:</p>


<pre><code>class Point(tuple):
    'Point(x, y)'

    __slots__ = ()

    _fields = ('x', 'y')

    def __new__(_cls, x, y):
        'Create new instance of Point(x, y)'
        return _tuple.__new__(_cls, (x, y))

    @classmethod
    def _make(cls, iterable, new=tuple.__new__, len=len):
        'Make a new Point object from a sequence or iterable'
        result = new(cls, iterable)
        if len(result) != 2:
            raise TypeError('Expected 2 arguments, got %d' % len(result))
        return result

    def __repr__(self):
        'Return a nicely formatted representation string'
        return 'Point(x=%r, y=%r)' % self

    def _asdict(self):
        'Return a new OrderedDict which maps field names to their values'
        return OrderedDict(zip(self._fields, self))

    def _replace(_self, **kwds):
        'Return a new Point object replacing specified fields with new values'
        result = _self._make(map(kwds.pop, ('x', 'y'), _self))
        if kwds:
            raise ValueError('Got unexpected field names: %r' % kwds.keys())
        return result

    def __getnewargs__(self):
        'Return self as a plain tuple.  Used by copy and pickle.'
        return tuple(self)

    x = _property(_itemgetter(0), doc='Alias for field number 0')

    y = _property(_itemgetter(1), doc='Alias for field number 1')
</code></pre>


<p>And, since they’re subclasses of tuples, you get all of the wonderful interactions baked right in:</p>


<pre><code>&gt;&gt;&gt; [foo, Point(-2, 2)]
[Point(x=0, y=4), Point(x=-2, y=2)]

&gt;&gt;&gt; map(abs, Point(-2, 2))
[2, 2]
</code></pre>


<p>Simple, elegant, and way more self-documenting than referencing <code>line[8]</code> and hoping you remember that 8 is the invoice amount and not the revenue figure (especially thirty days after you write the damn thing).</p>
	