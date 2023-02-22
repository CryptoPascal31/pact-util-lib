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

  (use util-strings [split-chunks])

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
  (defschema groth16-proof
    A:object{point-G1}
    B:object{point-G2}
    C:object{point-G1}
  )

  (defun int256-to-b64  (x:integer)
    "Convert a 256 bits integer to base 64"
    (drop 4 (int-to-str 64 (| x (shift 1 272))))
  )


  (defun serialize-proof:string (proof:object{groth16-proof})
    "Serialiaze an object proof to its base64 representation (344 octets)"
    (bind proof {'A:=A, 'B:=B, 'C:=C}
      (concat (map (int256-to-b64) [ (at 'x A), (at 'y A),
                                     (at 0 (at 'x B)), (at 1 (at 'x B)),
                                     (at 0 (at 'y B)), (at 1 (at 'y B)),
                                     (at 'x C), (at 'y C)
                                    ])))
  )

  (defun deserialize-proof:object{groth16-proof} (proof-str:string)
    "Deserialize a base64 proof string to its object representation"
    (enforce (= 344 (length proof-str)) "The base64 proof must have 344 characters")
    (let ((proof-lst (map (str-to-int 64) (split-chunks 43 proof-str))))
      {'A: {'x:  (at 0 proof-lst),
            'y:  (at 1 proof-lst)},
       'B: {'x: [(at 2 proof-lst) (at 3 proof-lst)],
            'y: [(at 4 proof-lst) (at 5 proof-lst)]},
       'C: {'x:  (at 6 proof-lst),
            'y:  (at 7 proof-lst)}
      })
  )


  (defun neg-G1:object{point-G1} (in:object{point-G1})
    "Returns the negative of a point in G1"
    (bind in {"x" := x, "y" := y}
      {'x:x, 'y: (- y)})
  )
)
