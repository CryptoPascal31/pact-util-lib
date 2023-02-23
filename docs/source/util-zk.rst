Zero knowledge functions (Roth16)
=================================
**Contract:**
  * free.util-zk

Obejcts definitions
-------------------

point-G1
~~~~~~~~
Represents the cordinates of a point on the curve (G1 group)

.. code:: lisp

  (defschema point-G1
    x:integer
    y:integer
  )

point-G2
~~~~~~~~
Represents the cordinates of a polynomial in the extended field(G2 group)

.. code:: lisp

  (defschema point-G2
      x:[integer]
      y:[integer]
  )


groth16-proof
~~~~~~~~~~~~~
Represents a GROTH 16 Proof

.. code:: lisp

  (defschema groph16-proof
    A:object{point-G1}
    B:object{point-G2}
    C:object{point-G1}
  )


groth16-verify-key
~~~~~~~~~~~~~~~~~~

.. code:: lisp

  (defschema groth16-verify-key
    alpha:object{point-G1}
    beta:object{point-G2}
    gamma:object{point-G2}
    delta:object{point-G2}
    ic:[object{point-G1}]
  )

ECC Arithmetic
--------------

neg-G1
~~~~~~
*in* ``object{point-G1}`` *→* ``object{point-G1}``

Return the negative of a point in G1

.. code:: lisp

  pact> (neg-G1 { "x":17899149025429256540670503450603840524526341770363252849540840688855727610005,
                  "y":6794888886586012478899094699714874747255503821264355877996121220781692052981})
  {"x": 17899149025429256540670503450603840524526341770363252849540840688855727610005
  ,"y": -6794888886586012478899094699714874747255503821264355877996121220781692052981}



Proof Management functions
--------------------------

Serialization scheme
~~~~~~~~~~~~~~~~~~~~
To limit transaction size and handle more easily proofs, it is proposed to
serialize proofs in a Pact friendly maneer.

- Convert **A.x** and **A.y** to Base64 (URL) strings (2* 43 bytes)
- Convert **B.x[0..1]**, and **B.y[0..1]** to Base64 (URL) strings (4 * 43 bytes)
- Convert **C.x** and **C.y** to Base64 (URL) strings (2* 43 bytes)
- Concatenate the 8 strings to form a 344 bytes length Base64 string.

serialize-proof
~~~~~~~~~~~~~~~
*proof* ``object{groth16-proof}`` *→* ``string``

Serialiaze an object proof to its base64 representation (344 bytes).

.. code:: lisp

  pact> (serialize-proof {"A":{ "x":17899149025429256540670503450603840524526341770363252849540840688855727610005,
                                "y":6794888886586012478899094699714874747255503821264355877996121220781692052981},
                          "B":{ "x":[4555160965165375385578562333880156835913586562443164694386914449127412126755, 16845220796436439159658389520454136502557317448502144055381480626643346396453],
                                "y":[15740922883530394503972296892303076718862447518810507376564218784428077030254, 9794083499477745551885635852864140214811154513402172713835626845455029169909]},
                          "C":{ "x":2188339130061078784977610313576641337709587353412678866175084864819379744795,
                                "y":7363399164077520072321162032202323356331016580445157674442815097597932017402}})
  "J5KPMJJp-t5MX_VDihVPa1pnaJaiPQb40em6Sb_WGJUDwXFVIN849MbSIvMV3oYdzpuz9yAvuWniXmZJk5WZfUChIhNrGRg36cfcPZL98cHMTCRrSd_6HhhTyWQ_MY1CMJT4OneDYEwY-Z4r9t84PwVrAntjY9k264yYtgS50FSUIs0L78VX8jCJpPcgBNysJpi0fghfIRwgIhFCWmQ7G24FadBO5DrTJZqCVbFb0MU-dYt7j4X_mOdy7BlHYbg7vUBNaOWZwxKVTlnrOdVC3L3M75fMC9u5TS_Lx1YxGqsBsEEeJRrGRtLcCzka6Tg2muE13-egR_CfGnqnyuYbrFvo"

deserialize-proof
~~~~~~~~~~~~~~~~~
*proof-str* ``string``  *→* ``object{groth16-proof}``

Deserialize a base64 proof string to its object representation

.. code:: lisp

  pact> (deserialize-proof "J5KPMJJp-t5MX_VDihVPa1pnaJaiPQb40em6Sb_WGJUDwXFVIN849MbSIvMV3oYdzpuz9yAvuWniXmZJk5WZfUChIhNrGRg36cfcPZL98cHMTCRrSd_6HhhTyWQ_MY1CMJT4OneDYEwY-Z4r9t84PwVrAntjY9k264yYtgS50FSUIs0L78VX8jCJpPcgBNysJpi0fghfIRwgIhFCWmQ7G24FadBO5DrTJZqCVbFb0MU-dYt7j4X_mOdy7BlHYbg7vUBNaOWZwxKVTlnrOdVC3L3M75fMC9u5TS_Lx1YxGqsBsEEeJRrGRtLcCzka6Tg2muE13-egR_CfGnqnyuYbrFvo")
  {"A": {"x": 17899149025429256540670503450603840524526341770363252849540840688855727610005
  ,"y": 6794888886586012478899094699714874747255503821264355877996121220781692052981}
  ,"B": {"x": [4555160965165375385578562333880156835913586562443164694386914449127412126755
  16845220796436439159658389520454136502557317448502144055381480626643346396453]
  ,"y": [15740922883530394503972296892303076718862447518810507376564218784428077030254
  9794083499477745551885635852864140214811154513402172713835626845455029169909]}
  ,"C": {"x": 2188339130061078784977610313576641337709587353412678866175084864819379744795
  ,"y": 7363399164077520072321162032202323356331016580445157674442815097597932017402}}


Proof Verification
------------------

verify-groth16-proof
~~~~~~~~~~~~~~~~~~~~
*key* ``object{groth16-verify-key}``  *pub-inputs* ``[integer]``  *proof* ``object{groth16-proof}`` *→* ``bool``

Verify a Groth16 proof against a list of public inputs and proof object

The verification can have 3 outcomes:

  - Return *true*, if the proof is vertified
  - Throw a transaction failure in case one of the argument is invalid.- Since this function is pure, this case ban be handled with a ``(try )``

  - Return *false*, if the proof is not ok.

.. code:: lisp

  pact> (verify-groth16-proof VERIFY-KEY-A INPUT-DATA-A PROOF-A-GOOD)
  true

  pact> (verify-groth16-proof VERIFY-KEY-A INPUT-DATA-A PROOF-A-BAD)
  true

  pact> (verify-groth16-proof VERIFY-KEY-A INPUT-DATA-A PROOF-A-CORRUPTED)
    util-zk.pact:118:10: Point not on curve
      at <interactive>:0:0: (verify-groth16-proof VERIFY-KEY-A INPUT-DATA-A PROOF-A-CORRUPTED)
