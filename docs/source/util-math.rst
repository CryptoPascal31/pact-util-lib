Math functions
==================
**Contract / Module:**
  * free.util-math

**Dependencies:**
  * free.util-lists


Constants
----------

PI
~~
``decimal``

.. code:: lisp

  pact> PI
  3.141592653589793

E
~~
``decimal``

Euler's number

  .. code:: lisp

    pact> E
    2.718281828459045


GOLDEN-RATIO
~~~~~~~~~~~~
``decimal``

Golden Ratio (Phi)

.. code:: lisp

  pact> GOLDEN-RATIO
  1.6180339887498949025257388711906969547271728515625

General functions
-----------------

dec*
~~~~
*x* ``<a[integer,decimal]>``  *→* ``decimal``

Starred version of ``(*dec)``. Convert an integer to a decimal, but does not fail
if *x* is already a decimal.

.. code:: lisp

  pact> (dec* 3)
  3.0

  pact> (dec* 3.0)
  3.0



between
~~~~~~~
*a* ``decimal`` *b* ``decimal`` *x* ``decimal`` *→* ``bool``

Return true is a <= x <= b".

.. code:: lisp

  pact> (between -1.0 1.0 0.2)
  true

  pact> (between -1.0 1.0 1.2)
  false

sign
~~~~
 *x* ``decimal`` *→* ``decimal``

.. code:: lisp

  pact> (sign 2.0)
  1.0

  pact> (sign -2.0)
  -1.0

  pact> (sign 0.0)
  0.0

Integers functions
------------------
is-even
~~~~~~~
*y* ``integer`` *→* ``bool``

Return true if x is even.

.. code:: lisp

  pact> (is-even 4)
  true

  pact> (is-even 5)
  false

is-odd
~~~~~~~
*y* ``integer`` *→* ``bool``

Return true if x is odd.

.. code:: lisp

  pact> (is-odd 4)
  false

  pact> (is-odd 5)
  true

sizeof
~~~~~~
*y* ``integer`` *→* ``integer``

Returns the storage size of a positive integer in bytes

.. code:: lisp

  pact> (sizeof 1)
  1

  pact> (sizeof 255)
  1

  pact> (sizeof 256)
  2

  pact> (sizeof 65536)
  3

++
~~
*x* ``integer`` *→* ``integer``

Increment an integer

.. code:: lisp

  pact> (++ 1)
  2

\- \-
~~~~~
*x* ``integer`` *→* ``integer``

Decrement an integer

.. code:: lisp

  pact> (-- 1)
  0


gcd
~~~
*a* ``integer`` *b* ``integer`` *→* ``integer``

Return the greatest common divisor of *a* and *b*.

Zeros are allowed for *a* or *b* or both.

``(gcd 0 0)`` returns 0.

Negative numbers are allowed.

.. code:: lisp

  pact> (gcd 8 0)
  8

  pact> (gcd 0 0)
  0

  pact> (gcd 21 9)
  3

  pact> (gcd -9 21)
  3

lcm
~~~
*a* ``integer`` *b* ``integer`` *→* ``integer``

Return the least common multiple of *a* and *b*.

Zeros are not allowed for any of the arguments.

Negative numbers are allowed.


.. code:: lisp

  pact> (lcm 6 16)
  48

  pact> (lcm 16 -6)
  48

  pact> (lcm 3 5)
  15

  pact> (lcm 3 0)
  util-math.pact:185:4: Arguments can't be 0


Min/Max functions
-----------------

min
~~~
*x* ``decimal`` *y* ``decimal`` *→* ``decimal``

Return the min of 2 values.

.. code:: lisp

  pact> (min 1.1 5.1)
  1.1

max
~~~
*x* ``decimal`` *y* ``decimal`` *→* ``decimal``

Return the max of 2 values.

.. code:: lisp

  pact> (max 1.1 5.1)
  5.1


min3
~~~~
*x* ``decimal`` *y* ``decimal`` *z* ``decimal`` *→* ``decimal``

Return the min of 3 values.

.. code:: lisp

  pact> (min3 1.1 8.2 5.1)
  1.1

max3
~~~~
*x* ``decimal`` *y* ``decimal`` *z* ``decimal`` *→* ``decimal``

Return the max of 3 values.

.. code:: lisp

  pact> (max3 1.1 8.2 5.1)
  8.2

min4
~~~~
*x* ``decimal`` *y* ``decimal`` *z* ``decimal`` *zz* ``decimal`` *→* ``decimal``

Return the min of 4 values.

.. code:: lisp

  pact> (min4 1.1 8.2 -1.0 5.1)
  1.1

max4
~~~~
*x* ``decimal`` *y* ``decimal`` *z* ``decimal`` *zz* ``decimal`` *→* ``decimal``

Return the max of 4 values.

.. code:: lisp

  pact> (max4 1.1 8.2 -1.0 5.1)
  8.2


min-list
~~~~~~~~
*x* ``[decimal]`` *→* ``decimal``

Return the min of a list.

.. code:: lisp

  pact> (min-list [1.1 8.2 -1.0 5.1])
  1.1

max-list
~~~~~~~~
*x* ``[decimal]`` *→* ``decimal``

Return the max of a list.

.. code:: lisp

  pact> (max-list [1.1 8.2 -1.0 5.1])
  8.2

amin
~~~~
*x* ``[decimal]`` *→* ``integer``

Return the min index of a list.

.. code:: lisp

  pact> (amin [1.1 8.2 -1.0 5.1])
  2

amax
~~~~
*x* ``[decimal]`` *→* ``integer``

Return the max index of a list.

.. code:: lisp

  pact> (amax [1.1 8.2 -1.0 5.1])
  1

Sum functions
-------------
**Remarks:**
  There is no function to add 2 decimals here. Indeed the native (+ x y) can be used.

sum3
~~~~
*x* ``decimal`` *y* ``decimal`` *z* ``decimal`` *→* ``decimal``

Return the sum of 3 values.

.. code:: lisp

  pact> (sum3 1.0 2.0 3.0)
  6.0


sum4
~~~~
*x* ``decimal`` *y* ``decimal`` *z* ``decimal`` *zz* ``decimal`` *→* ``decimal``

Return the sum of 4 values.

.. code:: lisp

  pact> (sum4 1.0 2.0 3.0 4.0)
  10.0

sum
~~~
*x* ``[decimal]`` *→* ``decimal``

Return the sum of a list.

.. code:: lisp

  pact> (sum [1.0 2.0 3.0 4.0])
  10.0


Product functions
------------------

prod3
~~~~~
*x* ``decimal`` *y* ``decimal`` *z* ``decimal`` *→* ``decimal``

Return the product of 3 values.

.. code:: lisp

  pact> (prod3 2.0 3.0 4.0)
  24.0

prod4
~~~~~
*x* ``decimal`` *y* ``decimal`` *z* ``decimal`` *zz* ``decimal`` *→* ``decimal``

Return the product of 4 values.

.. code:: lisp

  pact> (prod4 2.0 3.0 4.0 1.5)
  36.0

prod
~~~~
*x* ``[decimal]`` *→* ``decimal``

Return the product of a list.

.. code:: lisp

  pact> (prod [2.0 3.0 4.0 1.5])
  36.0

square
~~~~~~~
*x* ``decimal`` *→* ``decimal``

Return the square of *x*.

.. code:: lisp

  pact> (square 6.0)
  36.0


Divide functions
------------------

safe-/
~~~~~~
*x* ``decimal`` *y* ``decimal`` *default* ``decimal`` *→* ``decimal``

Divide **x** by **y** but returns default if **y** is *0.0*.
As a result ``safe-/`` never fails (Division by *0.0* is not possible anymore).

.. code:: lisp

  pact> (safe-/ 3.0 2.0 0.0)
  1.5

  pact> (safe-/ 3.0 0.0 0.0)
  0.0



Average and Median
-------------------

avg
~~~
*x* ``[decimal]`` *→* ``decimal``
Returns the average of a list.

.. code:: lisp

  pact> (avg [3.0 0.0 1.0 2.0])
  1.5

med
~~~
*x* ``[decimal]`` *→* ``decimal``

Returns the median of a list: if the length of the list is even return the (n/2 -1)th element.

.. code:: lisp

  pact> (med [3.0 0.0 1.0 2.0 4.0])
  2.0

  pact> (med [3.0 0.0 1.0 2.0])
  1.0

med*
~~~~
*x* ``[decimal]`` *→* ``decimal``

Returns the median of a list: if the length of the list is even return the average of the (n/2 -1)th and (n/2)th elements.

.. code:: lisp

  pact> (med* [3.0 0.0 1.0 2.0 4.0])
  2.0

  pact> (med* [3.0 0.0 1.0 2.0])
  1.5


Power/Log functions
--------------------

pow10
~~~~~
*x* ``integer`` *→* ``decimal``

Return 10^x, rounded to 12 decimals (rounding is important when *x* is negative).

.. code:: lisp

  pact> (pow10 2)
  100.000000000000

  pact> (pow10 -2)
  0.010000000000

xEy
~~~
*x* ``decimal`` *y* ``integer`` *→* ``decimal``

Return x.10^y, rounded to 12 decimals.

.. code:: lisp

  pact> (xEy 4.0 2)
  400.000000000000
  pact> (xEy 4.0 -2)
  0.040000000000

log10
~~~~~
*x* ``<a[integer,decimal]>`` *→* ``decimal``

Return the log of x base 10, rounded to 12 decimals.

.. code:: lisp

  pact> (log10 100)
  2.000000000000

  pact> (log10 0.001)
  -3.000000000000

safe-log
~~~~~~~~
*x* ``<a[integer,decimal]>`` *y* ``<a[integer,decimal]>``  *default* ``<a[integer,decimal]>``  *→* ``<a[integer,decimal]>``

Log of *y* base *x*, but returns default when *y* is negative.
As a result ``safe-log`` never fails (Log of negative numbers not possible anymore).

.. code:: lisp

  pact> (safe-log 2 1024.0 0.0)
  10.0

  pact> (safe-log 2 -1.0 0.0)
  0.0

safe-ln
~~~~~~~~
*x* ``decimal`` *default* ``decimal``  *→* ``decimal``

Natural log of *x*, but returns default when *x* <= *0.0*.
As a result ``safe-ln`` never fails (Log of negative numbers is not possible anymore).

.. code:: lisp

  pact> (safe-ln 2.0 0.0)
  0.69314718055994528622676398299518041312694549560546875

  pact> (safe-ln -2.0 0.0)
  0.0

safe-log10
~~~~~~~~~~
*x* ``<a[integer,decimal]>`` *default* ``decimal``  *→* ``decimal``

Returns the log of *x* base 10, rounded to 12 decimals but returns default when *x* is negative.
As a result ``safe-log10`` never fails (Log of negative numbers is not possible anymore)

.. code:: lisp

  pact> (safe-log10 20.0 0.0)
  1.301029995664

  pact> (safe-log10 -20.0 0.0)
  0.0
