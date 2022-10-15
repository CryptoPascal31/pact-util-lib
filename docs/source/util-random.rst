Random functions
==================
**Contract:**
  * free.util-random

**Dependencies:**
  * free.util-lists
  * free.util-strings
  * free.util-math

This module provides random generation functions.

The random integers Xn are generated according to the following formula:
  - Xn = HASH(Xn-1 + TxHash + HASH(block-time))
  - Xn is stored in database for the next iteration

The random strings is derived from Xn with the following formula:
  S = HASH( [Xn + 1] ) + HASH ( [Xn + 2] ) + HASH ( [Xn + 3] ) + ..........

The result is hard (maybe impossible) to predict before mining since block-time includes microseconds.
Several numbers can be generated in the same block or transaction. They will be all different, unpredictable and uncorrelated

Be careful, the miner can control the generated numbers => **Don't use for high stakes lottery or cryptography**

Integers
---------

random-int
~~~~~~~~~~
*→* ``integer``
Returns a 256 bit random integer

.. code:: lisp

  pact> (random-int)
  42217767265191416845873285650063916717654783831511640486359396574333357048814

  pact> (random-int)
  111356071076120320443192908521083690658058559363319245130075594187850043340684

random-int-range
~~~~~~~~~~~~~~~~
*_min* ``integer`` *_max* ``integer`` *→* ``integer``

Returns a random integer in range [min - max]

.. code:: lisp

  pact> (random-int-range 0 10)
  6

  pact> (random-int-range 0 10)
  7

  pact> (random-int-range 0 10)
  0


Decimals
---------

random-decimal-range
~~~~~~~~~~~~~~~~~~~~
*_min* ``decimal`` *_max* ``decimal`` *→* ``decimal``

Returns a random decimal in range [min - max]

.. code:: lisp

  pact> (random-decimal-range  -1.0 1.0)
  0.636958912683

  pact> (random-decimal-range -1.0 1.0)
  0.857566630911

  pact> (random-decimal-range -1.0 1.0)
  0.376521587006



Strings
---------

random-string
~~~~~~~~~~~~~
*len* ``integer`` *→* ``string``

Returns a random string of length *len*

.. code:: lisp

  pact> (random-string 5)
  "5KkYZ"

  pact> (random-string 129)
  "uNeV0pWbdBtGA6eIOZ34iLlE62QtkPrpwXurESXfjjEbls5ViT6Hs3wISs4WMMlEUS2hGl9tAd1vjy3HREdgdwed8pgJkBbPxj5Q7eiTkvoEgnE4cwFNWqM1qvjOFmNb0"

gen-uuid-rfc-4122-v4
~~~~~~~~~~~~~~~~~~~~
*→* ``string``

Generate an UUID (Universal Unique ID) according to RFC 4122 v4

.. code:: lisp

  pact> (gen-uuid-rfc-4122-v4)
  "c69c765d-46bd-4673-973b-09f1498921b3"

  pact> (gen-uuid-rfc-4122-v4)
  "11cebf69-41ce-485d-85f0-644630f7b5c6"
