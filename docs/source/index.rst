Pact Utilities library documentation
======================================

This library aims to provide some "high level" functions for writing Pact smart contracts.

The library contains currently more than 150 convenience functions split into 8 modules.

After using and experimenting Pact since several months, I found out that:
 * Some functions were missing: (eg ``(str-to-decimal)``, ...)
 * Some high level functions were needed to make development easier (eg ``(insert-at)``, instead of using ``(take)``, ``(drop)`` )
 * Some processing often used in smart-contracts were a little though to do in Pact, and some new users were disappointed. (eg ``(amin)``)
 * There was no simple way to generate Pseudo-Random strings and numbers in Pact.
 * Many simple and basic functions were duplicated between modules without factorization.

That's why I started to write this library. Feel free to use it, fork, submits bug reports and PR.

https://github.com/CryptoPascal31/pact-util-lib/

.. toctree::
   :maxdepth: 2
   :caption: Contents:

   how-to-use.rst
   util-lists.rst
   util-strings.rst
   util-math.rst
   util-chain-data.rst
   util-random.rst
   util-time.rst
   util-zk.rst
   util-fungible.rst
   deployed.rst
