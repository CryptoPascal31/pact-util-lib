How to use theses libraries
===========================

On-chain
--------

* Call any functions by it's fully qualified name. For example ``(free.util-strings.string-to-decimal "300.13")``

* Or import the module into your code: ``(use free.util-strings)``, and then call directly the function: ``(string-to-decimal "300.13")``

* Alternatively, you can use the following syntax to import code selectively: ``(use free.util-strings [string-to-decimal to-string])``


Off-chain
---------
**For development, using the local Pact interpreter**


Modules must be loaded in a specific order to satisfy their dependencies:

.. code:: lisp

  (load "util-chain-data.pact")
  (load "util-lists.pact")
  (load "util-strings.pact")
  (load "util-fungible.pact")
  (load "util-math.pact")
  (load "util-time.pact")
  (load "util-random.pact")
  (load "util-zk.pact")


If you want to use the random module, it must be initialized just after loading:

.. code:: lisp

  (create-table state-table)

  (env-hash (hash "This is my seed"))
  (reset-state)

The command ``(env-hash ...)`` is not mandatory. But it let you choose a specific seed
(here: "This is my seed") to init the random generator.
*Internally the random module use the Hash of the initialization transaction as a seed*
