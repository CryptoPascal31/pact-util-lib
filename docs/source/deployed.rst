Deployed contracts
==================

Version 0.7 (Pre-version)
~~~~~~~~~~~

Added functions:
  * ``util-chain-data.*``
  * ``util-list.shift-left``
  * ``util-list.shift-right``
  * ``util-list.roll-left``
  * ``util-list.roll-right``
  * ``util-list.fifo-push``
  * ``util-strings.starts-with*``
  * ``util-strings.ends-with*``
  * ``util-math.clamp``
  * ``util-random.random-bool``
  * ``util-fungible.enforce-precision``
  * ``util-fungible.enforce-valid-amount``
  * ``util-fungible.enforce-valid-transfer``
  * ``util-fungible.enforce-valid-transfer-xchain``
  * ``util-fungible.enforce-reserved``
  * ``util-fungible.enforce-reserved*``
  * ``util-fungible.enforce-valid-chain-id``
  * ``util-fungible.enforce-not-same-chain``

Deployed on:
  * Testnet Chains 0-19
  * Mainnet Chains 0-19

Modules hashes:

* **free.util-chain-data:**
* **free.util-lists:**
* **free.util-strings:**
* **free.util-math:**
* **free.util-random:**
* **free.util-time:**
* **free.util-fungible:**
* **free.util-zk:**


Version 0.6
~~~~~~~~~~~

Added functions:
  * ``util-math.++``
  * ``util-math.--``
  * ``util-math.dec*``

Deployed on:
  * Testnet Chains 0-19
  * Mainnet Chains 0-19

Modules hashes:
  * **free.util-lists:** 5dyAhqMGH4IM_q2S7RQ_N2ZKvko8HPXFQZlprsATcBc
  * **free.util-strings:** dQ-CDwgBjgtVmmAWZWVVHNGMNPFZuDy2drGb-Bk3MxE
  * **free.util-math:** ub6UFAqyTQ8dVpy6zK4-rNG-W6hqHwS-NX_bfCFGLVc
  * **free.util-random:** od06XLD2aQzeFoasShObwYCWVTqgx-09IEL0fbksoFM
  * **free.util-time:** iY4_6feELzTLXe7H5qzRuXi8tiWhpXgtKGB74JjW2Fk
  * **free.util-zk:** idjgCDWYgW08IzxGxhsZv-8jX15TMw9bQX7PrpeU0TU


Version 0.5
~~~~~~~~~~~

Added functions:
  * ``util-math.sizeof``
  * ``util-string.split-chunks``
  * ``util-time.is-today``
  * ``util-time.today``
  * ``util-time.is-past``
  * ``util-time.is-future``
  * ``util-zk.serialize-proof``
  * ``util-zk.deserialize-proof``
  * ``util-zk.neg-G1``
  * ``util-zk.verify-groth16-proof``

Deployed on:
  * Testnet Chains 0-19
  * Mainnet Chains 0-19

Modules hashes:
  * **free.util-lists:** mYH9B513yhSq2EBuEEXy3Sn-wddNLFdnooSw6WMEjd4
  * **free.util-strings:** afQtGqwCyl7l8oIFA-FB3AmShMn3BHjI9D_NKDxlRjE
  * **free.util-math:** mCgwRLIyTi6JhaF18huxjWvlNNXxA3mav-sDxyflMmc
  * **free.util-random:** NEG7aa1Edx6oU97d5wRh2Tl6Sw9Hiv4GOGBcZK2UWtU
  * **free.util-time:** QFg60Pul9sJSVqpcFA3SbP7QEPmIdTeSMI6T50OQvhQ
  * **free.util-zk:** hY1iF-6KUvzp2O-hRPnTPFeqOxEF7utyVhrMVlgzTMk

Version 0.4
~~~~~~~~~~~

**Added more documentation.**

Added functions:
  * ``util-list.at*``
  * ``util-list.insert-at*``
  * ``util-list.replace-at*``
  * ``util-time.epoch``
  * ``util-time.genesis``
  * ``util-time.now``
  * ``util-time.to-timestamp``
  * ``util-time.from-timestamp``
  * ``util-time.earliest``
  * ``util-time.latest``
  * ``util-time.time-between``
  * ``util-time.est-height-at-time``
  * ``util-time.est-time-at-height``
  * ``util-time.diff-time-minutes``
  * ``util-time.diff-time-hours``
  * ``util-time.diff-time-days``

Deployed on:
  * Testnet Chains 0-19
  * Mainnet Chains 0-19

Modules hashes:
  * **free.util-lists:** _QVpeU5pHnrZ_Rfxel80mT0Eq81g7ICHEoOaEa9PbYQ
  * **free.util-strings:** -YK2rOMWgx_cTnX-ehcx3j9UL8ZKYLbw7tgtdr2g_dU
  * **free.util-math:** VDb9rrF11M18Em5V6C1alpOS2xEKp5lPEU3fsEr_PjU
  * **free.util-random:** gq7DxC0_CPW3_zU4FbHXS6TFDd_cz45VYDjLCEzWsOs
  * **free.util-time:** Livfi3LIV8EhUZW8Ju8Cy8zdkcABE7cuZ2az0iQF7fU


Version 0.3
~~~~~~~~~~~

**Added more documentation.**

Added functions:
  * ``util-math.lcm``
  * ``util-math.gcd``
  * ``util-strings.slice``
  * ``util-random.shuffle``
  * ``util-random.random-choice``
  * ``util-strings.contains-chars``

Deployed on:
  * Testnet Chains 0-19
  * Mainnet Chains 0-19

Modules hashes:
  * **free.util-lists:** wm7RwXGdL1urmwU7is9wjbrw_bkW39wV_BuIng_ri14
  * **free.util-strings:** w3lESU0hy0tTA-68-eqnSgOf2CNw5nPlgvFtOd6d24w
  * **free.util-math:** KTVZOavXdQImWgjO0m1g0Knng94-u3V9mwYe3eNSQZM
  * **free.util-random:** qSwrZYiS0ZR7fVcbIVrtC-f_ZB6n-Q-6JsTkn6zg2IQ

Version 0.2
~~~~~~~~~~~

Bug corrections:
  * ``util-lists.count`` : Return type
  * ``util-math.log10`` and ``util-math.safe-log10``: Bug in case of integer argument

Added functions:
  * ``util-random.random-decimal-range``
  * ``util-strings.to-string``
  * ``util-strings.str-to-ascii-int``
  * ``util-strings.ascii-int-to-str``
  * ``util-strings.decimal-to-str``
  * ``util-strings.str-to-decimal``

Renamed functions:
  * ``util-strings.string-at`` to ``util-strings.char-at``



Deployed on:
  * Testnet Chains 0-19
  * Mainnet Chains 0-19

Modules hashes:
  * **free.util-lists:** 8nAzIk5zp5BpaKzU_s7s9PHShJ_Py8WBA3ZQ9-waEr4
  * **free.util-strings:** uzdfpvaEJDRfZc2SIYkjF331SaKE81CCK701q1RzkAQ
  * **free.util-math:** 2LREGZ9Yj_rOMlphLVa0OSK_m7NBqpuoUjIbfj2z7_U
  * **free.util-random:** I-yq-JDWu9Lpag6SJgkWbDtsaZ21k4YqOyA09uzSnuY

Version 0.1
~~~~~~~~~~~

Initial version

Deployed on:
 * Testnet Chains 0-19
 * Mainnet Chains 0-19

Modules hashes:
  * **free.util-lists:** 5TByiF6OZmPLlDpiF_6h6qPf5Nr9p4dI15mKdWbpAEA
  * **free.util-strings:** aOi0JgN3s59XJHYF3uofVF269nbVxVtesYZIJT-TJa4
  * **free.util-math:** 8lc-vIcIuEaquiirHGc8gqg8q_u3OhhJ0HyhW_3QYTE
  * **free.util-random:** RBfxKPExaz5q6i64FLA_k7UVM9MaOO0UDJulfPFZBRA
