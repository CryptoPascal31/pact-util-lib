Time functions
==================
**Contract / Module:**
  * free.util-time

**Dependencies:**
  * free.util-lists
  * free.util-math
  * free.util-chain-data

General functions
-----------------

epoch
~~~~~
**↦** ``time``

Return Unix EPOCH.

.. code:: lisp

  pact> (epoch)
  "1970-01-01T00:00:00Z"


genesis
~~~~~~~~
**↦** ``time``

Return Kadena Genesis time.

.. code:: lisp

  pact> (genesis)
  "2019-10-30T00:01:00Z"


now
~~~
**↦** ``time``

Return the current time.

.. code:: lisp

  pact> (now)
  "2022-12-04T14:54:24Z"


tomorrow
~~~~~~~~~
**↦** ``time``

Return the current time + 24 hours.

.. code:: lisp

  pact> (tomorrow)
  "2022-12-05T14:54:24Z"


yesterday
~~~~~~~~~
**↦** ``time``

Return the current time - 24 hours.

.. code:: lisp

  pact> (yesterday)
  "2022-12-03T14:54:24Z"


from-now
~~~~~~~~
*delta* ``decimal`` **↦** ``time``

Returns the *delta* time taking *now* as a reference.

.. code:: lisp

  pact> (from-now (hours 1))
  "2022-12-05T15:54:24Z"


today
~~~~~
**↦** ``string``

Return the current day.

.. code:: lisp

  pact> (today)
  "2022-12-04"

to-timestamp
~~~~~~~~~~~~
*in* ``time`` **↦** ``decimal``

Compute an Unix timestamp of the input date.

.. code:: lisp

  pact> (to-timestamp (time "2022-12-05T00:08:53Z"))
  1670198933.0

from-timestamp
~~~~~~~~~~~~~~
*timestamp* ``decimal`` **↦** ``time``

Compute a time from an Unix timestamp.

.. code:: lisp

  pact> (from-timestamp 1670198933.0)
  "2022-12-05T00:08:53Z"


Safe functions
---------------

Pact native time functions are not safe when they accept externally supplied arguments.
They can overflow and give weird results (eg A date in the past, while we expect a date in the future).

See:
  https://github.com/kadena-io/pact-5/issues/84

  https://github.com/kadena-io/pact/issues/1301

That's why these wrappers are necessary to handle corner cases and keep contracts sure.
I recommend to always and only use these functions instead of native when your module API allows users to supply time or
delta values.

time-safe
~~~~~~~~~
*in* ``string`` **↦** ``time``

Equivalent of the ``(time)`` native but ensure that no overflow occurred.

.. code:: lisp

  (time-safe "2025-03-03T17:56:48Z")
  "2025-03-03T17:56:48Z"

parse-time-safe
~~~~~~~~~~~~~~~
*fmt* ``string`` *in* ``string`` **↦** ``time``

Equivalent of the ``(parse-time)`` native but ensure that no overflow occurred.

.. code:: lisp

  (parse-time-safe "%F" "2024-11-06")
  "2024-11-06T00:00:00Z"

add-time-safe
~~~~~~~~~~~~~
*in* ``time`` *delta* ``decimal``  **↦** ``time``

Equivalent of the ``(add-time)`` native but ensure that no overflow occurred.

.. code:: lisp

  (add-time-safe (time "2022-12-04T14:54:24Z") (hours 2.0))
  "2022-12-04T16:54:24Z"

diff-time-safe
~~~~~~~~~~~~~~
*t1* ``time`` *t2* ``time``  **↦** ``decimal``

Equivalent of the ``(diff-time)`` native but ensure that no overflow occurred.

.. code:: lisp

  (diff-time-safe (time "2022-12-04T16:54:24Z") (time "2022-12-04T14:54:24Z"))
  7200.0


Compare function
----------------

earliest
~~~~~~~~
*time1* ``time`` *time2* ``time`` **↦** ``time``

Return the earliest time between *time1* and *time2*.

This function is equivalent to a ``min`` between two times.

.. code:: lisp

  (earliest (time "2022-12-04T14:54:24Z")  (time "2022-12-04T14:44:24Z"))
  "2022-12-04T14:44:24Z"


latest
~~~~~~~
*time1* ``time`` *time2* ``time`` **↦** ``time``

Return the earliest time between *time1* and *time2*.

This function is equivalent to a ``max`` between two times.

.. code:: lisp

  pact> (latest (time "2022-12-04T14:54:24Z")  (time "2022-12-04T14:44:24Z"))
  "2022-12-04T14:54:24Z"

time-between
~~~~~~~~~~~~
*time1* ``time`` *time2* ``time`` *in* ``time`` **↦** ``bool``

Return true if *in* is between *time1* and *time2*.

The order of *time1* and *time2* doesn't matter.

.. code:: lisp

  pact> (time-between (time "2022-12-04T14:44:24Z")
  ....>               (time "2022-12-24T14:44:24Z")
  ....>               (time "2022-12-08T14:44:24Z"))
  true

  pact> (time-between (time "2022-12-24T14:44:24Z")
  ....>               (time "2022-12-04T14:44:24Z")
  ....>               (time "2022-12-08T14:44:24Z"))
  true

  pact> (time-between (time "2022-12-24T14:44:24Z")
  ....>               (time "2022-12-04T14:44:24Z")
  ....>               (time "2022-12-26T14:44:24Z"))
  false

is-past
~~~~~~~
*in* ``time`` **↦** ``bool``

Return true if *in* is in the past (before now).

.. code:: lisp

  pact> (env-chain-data { 'block-time: (time "2022-12-04T14:54:24Z") })
  "Updated public metadata"

  pact> (is-past (time "2022-12-04T13:54:24Z"))
  true
  pact> (is-past (time "2022-12-04T15:54:24Z"))
  false

is-future
~~~~~~~~~
*in* ``time`` **↦** ``bool``

Return true if *in* is in the future (after now).

.. code:: lisp

  pact> (env-chain-data { 'block-time: (time "2022-12-04T14:54:24Z") })
  "Updated public metadata"

  pact> (is-future (time "2022-12-04T13:54:24Z"))
  false
  pact> (is-future (time "2022-12-04T15:54:24Z"))
  true

is-today
~~~~~~~~
*in* ``time`` **↦** ``bool``

Return true if *in* is in the current day.

.. code:: lisp

  pact> (env-chain-data { 'block-time: (time "2022-12-04T14:54:24Z") })
  "Updated public metadata"
  pact> (is-today (time "2022-12-04T13:54:24Z"))
  true
  pact> (is-today (time "2022-12-05T13:54:24Z"))
  false



Block height estimation functions
---------------------------------

est-height-at-time
~~~~~~~~~~~~~~~~~~

*target-time* ``time`` **↦** ``integer``

Estimates the block height at a *target-time*.

This function extrapolates the expected block height using the current
block height, and the current time.

A block time of 30s is assumed.

This function can used for the future or the past.

If the computed result is a negative block height (before Genesis), 0 is returned.

.. code:: lisp

  pact> (est-height-at-time (time "2022-12-04T09:10:30Z"))
  3257212

  pact> (est-height-at-time (time "2018-01-01T09:10:30Z"))
  0


est-time-at-height
~~~~~~~~~~~~~~~~~~

*target-height* ``integer`` **↦** ``time``

Estimates the time at a *target-block*.

This function extrapolates the expected block height using the current
block height, and the current time.

A block time of 30s is assumed.

This function can used for the future or the past.

.. code:: lisp

  pact> (est-time-at-height 3257212)
  "2022-12-04T09:10:43Z"


Time difference functions
-------------------------

diff-time-minutes
~~~~~~~~~~~~~~~~~~

time1 ``time`` time2 ``time`` **↦** ``decimal``

Compute difference between *time1* and *time2* in minutes.

.. code:: lisp

  pact> (diff-time-minutes (time "2022-12-04T14:54:24Z")  (time "2022-12-04T14:44:24Z"))
  10.0



diff-time-hours
~~~~~~~~~~~~~~~~~~

time1 ``time`` time2 ``time`` **↦** ``decimal``

Compute difference between *time1* and *time2* in hours.

.. code:: lisp

  pact> (diff-time-hours (time "2022-12-04T14:54:24Z")  (time "2022-12-04T04:54:24Z"))
  10.0


diff-time-days
~~~~~~~~~~~~~~~~~~

time1 ``time`` time2 ``time`` **↦** ``decimal``

Compute difference between *time1* and *time2* in days.

.. code:: lisp

  pact> (diff-time-days (time "2022-12-04T14:54:24Z")  (time "2022-12-02T14:54:24Z"))
  2.0
