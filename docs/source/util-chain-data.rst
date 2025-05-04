Chain-data functions
======================
**Contract / Module:**
  * free.util-chain-data

This modules contains some helpers to retrieve Chainweb
environment variables. (ie: chain-data)

It helps to make the code more readable without the need
to redefine theses function in each user module.


General functions
-----------------

chain-id
~~~~~~~~
**↦** ``string``

Retrieve the chain-id.

.. code:: lisp

  pact> (chain-id)
  "2"


block-height
~~~~~~~~~~~~
**↦** ``integer``

Retrieve the block-height.

.. code:: lisp

  pact> (block-height)
  6548432


block-time
~~~~~~~~~~~
**↦** ``time``

Retrieve the block-time.

.. code:: lisp

  pact> (block-time)
  "2022-12-04T14:54:24Z"

prev-block-hash
~~~~~~~~~~~~~~~
**↦** ``string``

Retrieve the prev-block-hash.

.. code:: lisp

  pact> (prev-block-hash)
  "2EoTAXJuUK1EKYwZbF3Q2cuYzbdCZRm_JdRERuMnuAk"


sender
~~~~~~
**↦** ``string``

Retrieve the transaction sender.

.. code:: lisp

  pact> (sender)
  "bob"


gas-limit
~~~~~~~~~
**↦** ``integer``

Return the gas-limit from transactions Meta.

.. code:: lisp

  pact> (gas-limit)
  1200

gas-price
~~~~~~~~~
**↦** ``decimal``

Return the gas-price from transactions Meta.

.. code:: lisp

  pact> (gas-price)
  0.001

total-gas-limit
~~~~~~~~~~~~~~~
**↦** ``decimal``

Return the total gas spendable for the transaction.

ie: the product of the gas-price by gas-limit

.. code:: lisp

  pact> (total-gas-limit)
  1.2
