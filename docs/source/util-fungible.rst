Fungible helper functions
=========================
**Contract / Module:**
  * free.util-fungible

**Dependencies:**
  * free.util-chain-data

This modules contains many helpers to create *standard* fungible modules (aka Tokens).

All theses functions are inspired by the ``coin`` contract and the venerable ``util.fungible-util``
module which no longer seems to be maintained. Many functions have been sanitized and modernized to use the
last released features of Pact:

  * Return type checking
  * *Principals* handling functions
  * Lazy evaluation of enforcements.



Most of theses function below are enforcements:

  * Return *true* in case everything is OK
  * Throw an error and revert the transaction is case something is wrong.

Accounts / Amounts verification
-------------------------------

enforce-precision
~~~~~~~~~~~~~~~~~
*precision* ``integer`` *amount* ``decimal``  *→* ``bool``

Enforce that an *amount* satisfies a given *precision*.

**ie**: that the *amount* has not more decimals than *precision*.

.. code:: lisp

  pact> (enforce-precision 4 3.1415)
  true

  pact> (enforce-precision 4 3.14159)
  util-fungible.pact:36:4:Error: Amount 3.14159 violates the required precision 4


Can be used to conveniently implement the ``(enforce-unit)`` function of ``fungible-v2``:

Example:

.. code:: lisp

  (defun enforce-unit:bool (amount:decimal)
    (enforce-precision (precision) amount))




enforce-valid-amount
~~~~~~~~~~~~~~~~~~~~~
*precision* ``integer`` *amount* ``decimal``  *→* ``bool``

Enforce that an *amount* is valid for a transfer:

  * Satisfies precision
  * Is strictly positive

.. code:: lisp

  pact> (enforce-valid-amount 4 3.1415)
  true

  pact> (enforce-valid-amount 4 3.14159)
  util-fungible.pact:36:4:Error: Amount 3.14159 violates the required precision 4

  pact> (enforce-valid-amount 4 -3.1415)
  util-fungible.pact:44:4:Error: Amount must be positive


enforce-valid-account
~~~~~~~~~~~~~~~~~~~~~
*account* ``string`` *→* ``bool``

Enforce that an *account* meets the requirements to be used for a fungible.

* Only ASCII and Latin1 characters
* Length between 3 and 256

.. code:: lisp

  pact> (enforce-valid-account "alice")
  true

  pact> (enforce-valid-account "ST")
  util-fungible.pact:55:4:Error: Account name does not conform to the length rquirements [3-256]

  pact> (enforce-valid-account "你好世界")
  util-fungible.pact:52:4:Error: Account does not conform to the charset LATIN1




enforce-valid-transfer
~~~~~~~~~~~~~~~~~~~~~~
*sender* ``string`` *receiver* ``string`` *precision* ``integer`` *amount* ``decimal`` *→* ``bool``

Enforce that everything is OK for a transfer:

* Both *sender* and *receiver* meets the accounts requirements
* *sender* is not the same as *receiver*
* *amount* meets the amount requirements (precision and sign)

.. code:: lisp

  pact> (enforce-valid-transfer "alice" "bob" 4 3.1415)
  true

  pact> (enforce-valid-transfer "alice" "alice" 4 3.1415)
  util-fungible.pact:64:6:Error: Sender and Receiver must be different: alice

  pact> (enforce-valid-transfer "alice" "bob" 4 3.14159)
  util-fungible.pact:36:4:Error: Amount 3.14159 violates the required precision 4

  pact> (enforce-valid-transfer "alice" "ST" 4 3.1415)
  util-fungible.pact:55:4:Error: Account name does not conform to the length rquirements [3-256]


Can be used to conveniently implement the ``(transfer)``, ``(transfer-create)``  functions of ``fungible-v2``, and
checks everything *all at once*

Example:

.. code:: lisp

  (defun transfer:string (sender:string receiver:string amount:decimal)
    (enforce-valid-transfer sender receiver (precision) amount)
    (with-capability (TRANSFER sender receiver amount)
      ...
      ...
  )


enforce-valid-transfer-xchain
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*sender* ``string`` *receiver* ``string`` *precision* ``integer`` *amount* ``decimal`` *→* ``bool``

Enforce that everything is OK for a X-chain transfer.

The only difference with the previous one ``enforce-valid-transfer``, is the condition **sender != receiver**
which is a non-sense in context of an X-chain transfer. Indeed transfer between same account name is allowed X-chain.

.. code:: lisp

  pact> (enforce-valid-transfer-xchain "alice" "bob" 4 3.1415)
  true

  pact> (enforce-valid-transfer-xchain "alice" "alice" 4 3.1415)
  true

  pact> (enforce-valid-transfer-xchain "alice" "ST" 4 3.1415)
  util-fungible.pact:55:4:Error: Account name does not conform to the length rquirements [3-256]

Can be used to conveniently implement the ``(transfer-crosschain)`` pact of ``fungible-v2``, and
checks everything *all at once*

Example:

.. code:: lisp

  (defpact transfer-crosschain:string (sender:string receiver:string receiver-guard:guard target-chain:string amount:decimal)
    (step
      (with-capability (TRANSFER_XCHAIN sender receiver amount target-chain)
        (enforce-valid-transfer-xchain sender receiver (precision) amount)
        ...
        ...
  )


Principals verification
-----------------------

enforce-reserved
~~~~~~~~~~~~~~~~
*account* ``string`` *guard* ``guard`` *→* ``bool``

Improved version of the ``enforce-reserved`` function from the ``coin`` contract.

If *account* is a principal (starts with ``x:``), the guard must match to the principal
account name.

.. code:: lisp

  pact> (env-data {'ks:["7f04bc04a9cf96701a806110242aee08a1692437413bead299fffb4a5b2e4bb6"]})
  "Setting transaction data"

  ; Keyset matches
  pact> (enforce-reserved "k:7f04bc04a9cf96701a806110242aee08a1692437413bead299fffb4a5b2e4bb6" (read-keyset 'ks))
  true

  ; Keyset doesn't match
  pact> (enforce-reserved "k:2e04bc04a9cf96701a806110242aee08a1692437413bead299fffb4a5b2e4bb6" (read-keyset 'ks))
  util-fungible.pact:82:8:Error: Reserved protocol guard violation: k:

  ; Ref guard matches
  pact> (enforce-reserved "r:user.alice" (keyset-ref-guard "user.alice"))
  true

  ; Ref guard doesn't match
  pact> (enforce-reserved "r:user.alice" (read-keyset 'ks))
  kda-env/pact-util-lib/util-fungible.pact:82:8:Error: Reserved protocol guard violation: r

  ; Non principal account accepted
  pact> (enforce-reserved "alice" (read-keyset 'ks))
  true

Can be used to conveniently implement the ``(create-account)``,``(transfer-create) `` functions of ``fungible-v2``, to manage
accounts creation.


enforce-reserved*
~~~~~~~~~~~~~~~~~
*account* ``string`` *guard* ``guard`` *→* ``bool``

Slightly different version of the above function.

Only principals account are accepted. Vanilla account (without any prefix) are disallowed

This can be used to replace ``(enforce-reserved)``
in any fungible contract, to make the token *principal only*.

.. code:: lisp

  pact> (env-data {'ks:["7f04bc04a9cf96701a806110242aee08a1692437413bead299fffb4a5b2e4bb6"]})
  "Setting transaction data"

  ; Keyset matches
  pact> (enforce-reserved "k:7f04bc04a9cf96701a806110242aee08a1692437413bead299fffb4a5b2e4bb6" (read-keyset 'ks))
  true

  ; Keyset doesn't match
  pact> (enforce-reserved "k:2e04bc04a9cf96701a806110242aee08a1692437413bead299fffb4a5b2e4bb6" (read-keyset 'ks))
  util-fungible.pact:91:4:Error: Reserved protocol guard violation: k:

  ; Non principal account not allowed
  pact> (enforce-reserved* "alice" (read-keyset 'ks))
  kda-env/pact-util-lib/util-fungible.pact:90:4:Error: Only principal accounts can be used



Cross-chain helpers
-------------------

enforce-valid-chain-id
~~~~~~~~~~~~~~~~~~~~~~
*chain-id* ``string`` *→* ``bool``

Enforce that *chain-id* is valid chain denomination.

.. code:: lisp

  pact> (enforce-valid-chain-id "1")
  true

  pact> (enforce-valid-chain-id "45")
  kda-env/pact-util-lib/util-fungible.pact:97:4:Error: Target chain is not a valid Chainweb chainID

  pact> (enforce-valid-chain-id "foo")
  kda-env/pact-util-lib/util-fungible.pact:97:4:Error: Target chain is not a valid Chainweb chainID


enforce-not-same-chain
~~~~~~~~~~~~~~~~~~~~~~
*chain-id* ``string`` *→* ``bool``

Enforce that the code is not executing on the same chain, as *chain-id*.

This is useful in a cross-chain transfer context to verify that we really send tokens
to a different chain.

.. code:: lisp

  ; Simulate execution on chain 0
  pact> (env-chain-data {'chain-id:"0"})
  "Updated public metadata"

  pact> (enforce-not-same-chain "1")
  true

  pact> (enforce-not-same-chain "0")
  kda-env/pact-util-lib/util-fungible.pact:102:4:Error: Target chain 0 cannot be the current chain
