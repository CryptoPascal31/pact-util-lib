Deployed contracts
==================

**Note on global hash:**

The global hash is a convenient way to verify that all modules are well deployed on a given chain.

It can be verified on-chain using the following pact command:

.. code:: lisp

  (hash (concat
  (map (compose (+ "free.util-") (compose (describe-module) (at 'hash))) ["chain-data", "lists", "strings", "math", "random", "time", "fungible", "zk"])))

Version 0.10
~~~~~~~~~~~
Validated with Pact 5.1

New safe time functions:
  * ``util-time.time-safe``
  * ``util-time.parse-time-safe``
  * ``util-time.add-time-safe``
  * ``util-time.diff-time-safe``

New rounding math helpers functions:
  * ``util-math.round*``
  * ``util-math.floor*``
  * ``util-math.ceiling*``
  * ``util-math./-r``
  * ``util-math./-f``
  * ``util-math./-c``

Deployed on:
  Testnet Chains 0-19
  Mainnet Chains 0-19

Modules hashes:
  * **free.util-chain-data:** l4q8aCtXuBWeIQvMlvNd9fAIPGAcFQ21XHt7_zgPajs
  * **free.util-lists:**      L7F53v1WsLnFtYGmRV1iJkThwOQzZDWIbRPugiOy2K0
  * **free.util-strings:**    FSVALSDcwdasGbvZGstAl3DdjtEtqj-EMK7ayx4ISdg
  * **free.util-math:**       AMRbbckFyYSxYt2NdalAVmWWq0w5XOCxoTNN_LgUxwA
  * **free.util-random:**     ZDYrboWZoGy1yX4rCNOW8H5ZyzK69zIiyD1qoOgvF5M
  * **free.util-time:**       1TcFHt65q6kUqww34sx-LQptg4XOMp3tVOaTLSKbj6k
  * **free.util-fungible:**   kYQoyccy3hdq8e4Nr_YHNOmNO7QjaKVjyDvYaaNMiK
  * **free.util-zk:**         U5-z-kSVdcvxYw3XsWLwENAkeQsctxoLfG9hIPdmMvI
  * **Global:**               QkAO7w4UHlICg18CQubjdMzrj22M4ekuuCZlLJFdtpE



Version 0.9
~~~~~~~~~~~
  * Revert 0.8.1 Bugfix
  * Make it fully Pact 5.0 compliant

Deployed on:
  * Testnet Chains 0-19
  * Mainnet Chains 0-19

Modules hashes:

* **free.util-chain-data:** y0Vu5XXeZxUErG-X_XlCWmdvrss55Hk09FpuFvGRW1g
* **free.util-lists:**      hpAwM7nLWHlUpYo8hQeJINjQzpcibpUTlZwCY8Y-ZnM
* **free.util-strings:**    cXYkON1-qQoFzKhWSahoAebecciWERMP7n47_mztU5Y
* **free.util-math:**       WWM-hGxsPWJFVcfNcPJJsWJjdiuW61IcETqcq4Jcsh4
* **free.util-random:**     wKB0nWJ-ti1LLUGR07zlZIs7_0g6PkCalRwK3pmaRmc
* **free.util-time:**       UmBuxYqUrPyaj2OILuJbOd6QOBLdpRjbfEp1PmvG9N0
* **free.util-fungible:**   -g9U4ErHpSRJVNDx3yCU9kbjpnTZkoQh_BRaewyNVQY
* **free.util-zk:**         QgbKlHyArNlm9m0noTuUx7VhuycGtVkwlsZcn_bR6VY
* **Global:**               PrSm3NllTy7yjijgQHvLrEvEPtO33osTcth8ncTEobg


Version 0.8.1
~~~~~~~~~~~~~~
Bugfix:
  * util-strings.join: Workaround for https://github.com/kadena-io/pact/issues/1316

Deployed on:
  * Testnet Chains 0-19
  * Mainnet Chains 0-19

Modules hashes:

* **util-chain-data:** eiouBpR7CQMMCH2ORVdH_MhEljlFAh1lV3BNbSyl7TM
* **util-lists:** a-tRQsbhF2DR3UGcQr_8HEmtU17_EAc1NT0Yhw1qZa0
* **util-strings:** A_xZc2n2EIqUhALJGkEIrGcrVTSkgwycS6qdvsRpR6o
* **util-math:** Nd7y9268aT_DQA9aMK2cWlpxaULQS08EZourjp0wNq4
* **util-random:** 0C6T81mWS7QBA7nPBvaJLeO0ExPMwbVg20eKTNQ2DhU
* **util-time:** 4_wiwacn0SMB9zBvDSNt2bZuKHAcqWw-dygUHyWw6dA
* **util-fungible:** Eqks82QsVEZvwNXm_VD7U_FomdD4D41JFoqgsBEj2vM
* **util-zk:** 9huAxHg84MAZHs-T0h_WR1NpM38op_G8CXy2xRsdnAc



Version 0.8
~~~~~~~~~~~

Added functions:
  * ``util-lists.is-empty``
  * ``util-lists.is-not-empty``
  * ``util-lists.is-singleton``
  * ``util-lists.is-pair``
  * ``util-lists.contains*``
  * ``util-time.tomorrow``
  * ``util-time.yesterday``
  * ``util-time.from-now``

Bugs fixes:
  * ``util-time.from-timestamp`` (Prevent  possible overflow)

Improved functions: (behavior is not expected to change)
  * ``util-lists.search`` (Gas improvement)
  * ``util-strings.join`` (Readability)
  * ``util-strings.split`` (Gas improvement)
  * ``util-strings.strip`` (Gas improvement)
  * ``util-strings.strip-left`` (Gas improvement)
  * ``util-strings.strip-right`` (Gas improvement)
  * ``util-strings.str-to-decimal`` (Gas improvement)

Deployed on:
  * Testnet Chains 0-19
  * Mainnet Chains 0-19

Modules hashes:

  * **free.util-chain-data:** eiouBpR7CQMMCH2ORVdH_MhEljlFAh1lV3BNbSyl7TM
  * **free.util-lists:** a-tRQsbhF2DR3UGcQr_8HEmtU17_EAc1NT0Yhw1qZa0
  * **free.util-strings:** O05mysmD0vzJt9D5pp6wB21KMRedbic5mkAPptqE_s8
  * **free.util-math:** Nd7y9268aT_DQA9aMK2cWlpxaULQS08EZourjp0wNq4
  * **free.util-random:** 0C6T81mWS7QBA7nPBvaJLeO0ExPMwbVg20eKTNQ2DhU
  * **free.util-time:** 4_wiwacn0SMB9zBvDSNt2bZuKHAcqWw-dygUHyWw6dA
  * **free.util-fungible:** Eqks82QsVEZvwNXm_VD7U_FomdD4D41JFoqgsBEj2vM
  * **free.util-zk:** 9huAxHg84MAZHs-T0h_WR1NpM38op_G8CXy2xRsdnAc


Version 0.7
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

* **free.util-chain-data:** zXd78WCHboVyQMIBrWComoBrK6nt7_o9St3kmTZXso0
* **free.util-lists:** phg3FBQPsJEMlaPL4Aga1oGbWW5JVtXkK6WgCoAVpaA
* **free.util-strings:** exAFfvjPTlkJHR975MhFYFA-bccJDMTLxNhBw2lyfb4
* **free.util-math:** oNRgcUENFDx7qMytXsEDz90bDv-RTGI0R43C2Bx0VN8
* **free.util-random:** SVQVrKpSIj-1qBY3SxceeG_3GkODAIYdzszYa44yPe4
* **free.util-time:** GRwr0jH7MfHA0E6DbRqHpdWSATbjlY861u5ZtmkFfow
* **free.util-fungible:** Lao-67tr7tq2-BUWuClfD47aj9lEfCzwFhODqn9IiEc
* **free.util-zk:** m6CrlW1K99NOfLVD15U1k6wZfse4uFKnTgvT2GKoG_8


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
