;SPDX-License-Identifier: MIT

; This modules provides some convenient time management function for Pact.
;
; Be aware that this module is only in Beta and hasn't been audited:
;    --> BE CAREFUL if a security enforcement depends on one of theses functions
;
;
; Feel free to reuse, comment, review, fork, propose PRs, submit bugs:
; https://github.com/CryptoPascal31/pact-util-lib

(module util-zk GOV
  "Module containing time utilities \
   \ Documentation: https://pact-util-lib.readthedocs.io \
   \ Github: https://github.com/CryptoPascal31/pact-util-lib "

  (defconst VERSION:string "0.4")

  (defcap GOV()
    (enforce-keyset "free.util-lib"))

  (defconst BN128-FIELD-MODULUS:integer 21888242871839275222246405745257275088696311157297823662689037894645226208583)

  ; Point in G1 (on the curve)
  (defschema point-G1
    x:integer
    y:integer
  )

  ; Point in G2 (extended field)
  (defschema point-G2
      x:[integer]
      y:[integer]
  )

  ; Groph16 Proof (2 point in G1, and 1 point in G2)
  (defschema groph16-proof
    A:object{point-G1}
    B:object{point-G2}
    C:object{point-G1}
  )



)
