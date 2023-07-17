Lists functions
==================
**Contract / Module:**
  * free.util-lists


General functions
-----------------

enforce-not-empty
~~~~~~~~~~~~~~~~~
*in* ``list`` *→* ``bool``

Verify and enforces that a list is not empty.

.. code:: lisp

  pact> (enforce-not-empty [1, 2, 3])
  true

  pact> (enforce-not-empty [])
  util-lists.pact:22:4: List cannot be empty
    at <interactive>:0:0: (enforce-not-empty [])

enforce-list-bounds
~~~~~~~~~~~~~~~~~~~~~
*in* ``list`` *idx* ``integer`` *→* ``bool``

Verify and ENFORCES that *idx* is in list bounds.
 | *idx* must be >= 0 and <= length *in*

.. code:: lisp

  pact> (enforce-list-bounds  [1,2,3] 0)
  true

  pact> (enforce-list-bounds  [1,2,3] 1)
  true

  pact> (enforce-list-bounds  [1,2,3] 2)
  true

  pact> (enforce-list-bounds  [1,2,3] 3)
  util-lists.pact:26:4: Index out of bounds
    at <interactive>:0:0: (enforce-list-bounds [1 2 3] 3)

  pact> (enforce-list-bounds  [1,2,3] -1)
  util-lists.pact:26:4: Index out of bounds
    at <interactive>:0:0: (enforce-list-bounds [1 2 3] -1)


chain
~~~~~~
*in* ``list`` *→* ``list``

Chain list of lists:
 | All lists are chained to build a new unique list.

.. code:: lisp

 pact> (chain [ [1,2], [3,4,5], [6,7,8] ])
 [1 2 3 4 5 6 7 8]

enumerate-list
~~~~~~~~~~~~~~~
*in* ``list`` *→* ``[object]``

Return a list of objects ``{'i:idx, 'v:value}`` where *'i* is the index, and *'v* the value.

.. code:: lisp

  pact> (enumerate-list ["a", "b", "c"])
  [{"i": 0,"v": "a"} {"i": 1,"v": "b"} {"i": 2,"v": "c"}]

first
~~~~~
*in* ``[<a>]`` *→* ``<a>``

Return the first item of a list.

.. code:: lisp

  pact> (first ["a", "b", "c"])
  "a"

last
~~~~~
*in* ``[<a>]`` *→* ``<a>``

Return the last item of a list.

.. code:: lisp

  pact> (last ["a", "b", "c"])
  "c"

at*
~~~
*in* ``[<a>]`` *idx* ``integer`` *default* ``<a>`` *→* ``<a>``

*Starred version of the standard Pact function* ``(at )``

Return the element at *idx*, but returns *default* if the list is too short.

.. code:: lisp

  pact> (at* ["a" "b" "c"] 1 "def")
  "b"

  pact> (at* ["a" "b" "c"] 4 "def")
  "def"


Search Functions
-----------------

search
~~~~~~~
*in* ``[<a>]`` *item* ``<a>`` *→* ``[integer]``

Search an *item* into the list and returns a list of indexes.

.. code:: lisp

  pact> (search ["a", "b", "a", "c"] "a")
  [0 2]

  pact> (search ["a", "b", "a", "c"] "b")
  [1]

  pact> (search ["a", "b", "a", "c"] "d")
  []

count
~~~~~
*in* ``[<a>]`` *item* ``<a>`` *→* ``integer``

Returns the number of occurrences of an *item*.

.. code:: lisp

  pact> (count ["a", "b", "a", "c"] "a")
  2

  pact> (count ["a", "b", "a", "c"] "b")
  1

  pact> (count ["a", "b", "a", "c"] "d")
  0

Creation and extension functions
---------------------------------

make-list-like
~~~~~~~~~~~~~~~
*in* ``[]``  *value* ``<a>`` *→* ``[<a>]``

Creates a new list whose size is the same as *in*, by repeating *value*.

This is just a simple improvement of the native ``(make-list)``.

.. code:: lisp

  pact> (make-list-like [1 2 3 4 5] 1.0)
  [1.0 1.0 1.0 1.0 1.0]


extend
~~~~~~
*in* ``[<a>]`` *new-length* ``integer`` *value* ``<a>`` *→* ``[<a>]``

Extend a list to *new-length* by repeating *value*.

.. code:: lisp

  pact> (extend [1.0 1.0] 5 2.0)
  [1.0 1.0 2.0 2.0 2.0]

extend-like
~~~~~~~~~~~~
*in* ``[<a>]`` *target* ``[]`` *value* ``<a>`` *→* ``[<a>]``

Extends a list to the same length as *target*, by repeating *value*.

.. code:: lisp

  pact> (extend-like [1.0 1.0] [1 2 3 4 5] 2.0)
  [1.0 1.0 2.0 2.0 2.0]


Insertion functions
--------------------

insert-first
~~~~~~~~~~~~
*in* ``[<a>]`` *item* ``<a>`` *→* ``[<a>]``

Insert an item at the left of the list.

.. code:: lisp

  pact> (insert-first ["a", "b", "c"] "d")
  ["d" "a" "b" "c"]


append-last
~~~~~~~~~~~~
*in* ``[<a>]`` *item* ``<a>`` *→* ``[<a>]``

Append an item at the end of the list.

.. code:: lisp

  pact> (append-last ["a", "b", "c"] "d")
  ["a" "b" "c" "d"]

insert-at
~~~~~~~~~~~~
*in* ``[<a>]`` *idx* ``integer`` *item* ``<a>`` *→* ``[<a>]``

Insert an item at position *idx*.

.. code:: lisp

  pact> (insert-at ["a", "b", "c"] 0 "d")
  ["d" "a" "b" "c"]

  pact> (insert-at ["a", "b", "c"] 1 "d")
  ["a" "d" "b" "c"]

  pact> (insert-at ["a", "b", "c"] 3 "d")
  ["a" "b" "c" "d"]

insert-at*
~~~~~~~~~~~~
*in* ``[<a>]`` *idx* ``integer`` *item* ``<a>``  *default* ``<a>`` *→* ``[<a>]``

Starred version of ``(insert-at   )``. When the list is too short, don't fail (like ``(insert-at   )``).
But add as many *default* elements to match the needed size.

.. code:: lisp

  pact> (insert-at* ["a", "b", "c"] 0 "d" "unknown")
  ["d" "a" "b" "c"]

  pact> (insert-at* ["a", "b", "c"] 5 "d" "unknown")
  ["a" "b" "c" "unknown" "unknown" "d"]

Replacement functions
----------------------

replace-first
~~~~~~~~~~~~~~~
*in* ``[<a>]`` *item* ``<a>`` *→* ``[<a>]``

Replace the first item of the list.

.. code:: lisp

  pact> (replace-first ["a", "b", "c"] "d")
  ["d" "b" "c"]


replace-last
~~~~~~~~~~~~~~~
*in* ``[<a>]`` *item* ``<a>`` *→* ``[<a>]``

Replace the last item of the list.

.. code:: lisp

  pact> (replace-last ["a", "b", "c"] "d")
  ["a" "b" "d"]


replace-at
~~~~~~~~~~~~~~~
*in* ``[<a>]`` *idx* ``integer`` *item* ``<a>`` *→* ``[<a>]``

Replace the item at position *idx*.

.. code:: lisp

  pact> (replace-at ["a", "b", "c"]  0 "d")
  ["d" "b" "c"]

  pact> (replace-at ["a", "b", "c"]  1 "d")
  ["a" "d" "c"]


replace-at*
~~~~~~~~~~~~
*in* ``[<a>]`` *idx* ``integer`` *item* ``<a>``  *default* ``<a>`` *→* ``[<a>]``

Starred version of ``(replace-at   )``. When the list is too short, don't fail (like ``(replace-at   )``).
But add as many *default* elements to match the needed size.

.. code:: lisp

  pact> (replace-at* ["a", "b", "c"] 0 "d" "unknown")
  ["d" "b" "c"]

  pact> (replace-at* ["a", "b", "c"] 5 "d" "unknown")
  ["a" "b" "c" "unknown" "unknown" "d"]

replace-item
~~~~~~~~~~~~~~~
*in* ``[<a>]`` *old-item* ``<a>`` *new-item* ``<a>`` *→* ``[<a>]``

Replace each occurrence of *old-item* by *new-item*.

.. code:: lisp

  pact> (replace-item ["a", "b", "c", "a"]  "c" "rep")
  ["a" "b" "rep" "a"]

  pact> (replace-item ["a", "b", "c", "a"]  "a" "rep")
  ["rep" "b" "c" "rep"]

  pact> (replace-item ["a", "b", "c", "a"]  "not" "rep")
  ["a" "b" "c" "a"]


replace-item*
~~~~~~~~~~~~~~~
*in* ``[<a>]`` *old-item* ``<a>`` *new-item* ``<a>`` *→* ``[<a>]``

Replace each occurrence of *old-item* by *new-item* but raises an error if *old-item* does not exist.

.. code:: lisp

  pact> (replace-item* ["a", "b", "c", "a"]  "c" "rep")
  ["a" "b" "rep" "a"]

  pact> (replace-item* ["a", "b", "c", "a"]  "a" "rep")
  ["rep" "b" "c" "rep"]

  pact> (replace-item* ["a", "b", "c", "a"]  "not" "rep")
  util-lists.pact:110:4: The item is not present in the list
    at <interactive>:0:0: (replace-item* ["a" "b" "c" "a"] "not" "rep")


Removal functions
----------------------

remove-first
~~~~~~~~~~~~~~~
*in* ``[<a>]`` *→* ``[<a>]``

Remove first element from the list.

.. code:: lisp

  pact> (remove-first ["a", "b", "c"] )
  ["b" "c"]

remove-last
~~~~~~~~~~~~~~~
*in* ``[<a>]`` *→* ``[<a>]``

Remove last element from the list.

.. code:: lisp

  pact> (remove-last ["a", "b", "c"] )
  ["a" "b"]

remove-at
~~~~~~~~~~~~~~~
*in* ``[<a>]`` *idx* ``integer`` *→* ``[<a>]``

Remove element at position *idx*.

.. code:: lisp

  pact> (remove-at ["a", "b", "c"] 0)
  ["b" "c"]

  pact> (remove-at ["a", "b", "c"] 1)
  ["a" "c"]

  pact> (remove-at ["a", "b", "c"] 2)
  ["a" "b"]

remove-item
~~~~~~~~~~~~~~~
*in* ``[<a>]`` *item* ``<a>`` *→* ``[<a>]``

Remove an item from a list.

.. code:: lisp

  pact> (remove-item ["a", "b", "c", "a", "d"] "a")
  ["b" "c" "d"]

  pact> (remove-item ["a", "b", "c", "a", "d"] "b")
  ["a" "c" "a" "d"]

  pact> (remove-item ["a", "b", "c", "a", "d"] "e")
  ["a" "b" "c" "a" "d"]

remove-item*
~~~~~~~~~~~~~~~
*in* ``[<a>]`` *item* ``<a>`` *→* ``[<a>]``

Remove and item from the list but raises an error if it does not exist.

.. code:: lisp

  pact> (remove-item* ["a", "b", "c", "a", "d"] "a")
  ["b" "c" "d"]

  pact> (remove-item* ["a", "b", "c", "a", "d"] "b")
  ["a" "c" "a" "d"]

  pact> (remove-item* ["a", "b", "c", "a", "d"] "e")
  util-lists.pact:140:4: The item is not present in the list
   at <interactive>:0:0: (remove-item* ["a" "b" "c" "a" "d"] "e")


FIFO functions
--------------

Pact lists can be used as FIFO.


fifo-push
~~~~~~~~~
*in* ``[<a>]`` *item* ``<a>`` *→* ``[<a>]``

This function push an element into a fixed size FIFO.

The FIFO keep a constant size before and after the call.

In fact the fucntion simply remove the first element and append a new element.

.. code:: lisp

  pact> (fifo-push ["a", "b", "c", "d"] "x")
  ["b" "c" "d" "x"]

  pact> (fifo-push (fifo-push ["a", "b", "c", "d"] "x") "y")
  ["c" "d" "x", "y"]


fifo-push*
~~~~~~~~~~
*in* ``[<a>]`` *fifo-size* ``integer`` *item* ``<a>`` *→* ``[<a>]``

This function push an element into a defined size (by *fifo-size*) FIFO.

*fifo-size* is target size

If the current size is less then *fifo-size*, the element is only append.

If the current size is equal to *fifo-size*, it means that the FIFO is full, and
the element is append, and the FIFO is rotated (ie: first element removed and new element append)


.. code:: lisp

    pact> (fifo-push* ["a", "b", "c", "d"] 5  "x")
    ["a" "b" "c" "d" "x"]

    pact> (fifo-push* ["a", "b", "c", "d", "x"] 5  "y")
    ["b," "c" "d" "x", "y"]
