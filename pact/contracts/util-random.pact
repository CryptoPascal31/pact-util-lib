;SPDX-License-Identifier: MIT

; This module provides random generation functions.
;
; The random integers Xn are generated according to the following formula:
; Xn = HASH(Xn-1 + TxHash + HASH(block-time))
; Xn is stored in database for the next iteration
;
; The random string is derived from Xn with the following formula
; S = HASH( [Xn + 1] ) + HASH ( [Xn + 2] ) + HASH ( [Xn + 3] ) + ..........
;
; The result is easy to predict. Even if block-time includes microseconds, block-time
; is an exact copy of the creation-time of the previous block.
; That's why a contract whose security would rely on that module would be highly exploitable.
; An attacker just need to watch the current block, to predict what will be the generated numbers
; in the next block.
;
; => DO NOT NOT NOT USE this PRBS generator for cryptographic or lottery purposes.
;
; Several numbers can be generated in the same block or transaction. They will be all different, and uncorrelated
;
;
; Feel free to reuse, comment, review, fork, propose PRs, submit bugs:
; https://github.com/CryptoPascal31/pact-util-lib

(module util-random GOV
  "This module provides pseudo-random numbers/string generation \
   \ Documentation: https://pact-util-lib.readthedocs.io \
   \ Github: https://github.com/CryptoPascal31/pact-util-lib "

  (defconst VERSION:string "0.9")

  (bless "RBfxKPExaz5q6i64FLA_k7UVM9MaOO0UDJulfPFZBRA")
  (bless "I-yq-JDWu9Lpag6SJgkWbDtsaZ21k4YqOyA09uzSnuY")
  (bless "qSwrZYiS0ZR7fVcbIVrtC-f_ZB6n-Q-6JsTkn6zg2IQ")
  (bless "gq7DxC0_CPW3_zU4FbHXS6TFDd_cz45VYDjLCEzWsOs")
  (bless "NEG7aa1Edx6oU97d5wRh2Tl6Sw9Hiv4GOGBcZK2UWtU")
  (bless "od06XLD2aQzeFoasShObwYCWVTqgx-09IEL0fbksoFM")
  (bless "SVQVrKpSIj-1qBY3SxceeG_3GkODAIYdzszYa44yPe4")
  (bless "0C6T81mWS7QBA7nPBvaJLeO0ExPMwbVg20eKTNQ2DhU")
  (bless "wKB0nWJ-ti1LLUGR07zlZIs7_0g6PkCalRwK3pmaRmc")

  (defcap GOV()
    (enforce-keyset "free.util-lib"))

  (use util-lists [enforce-not-empty])
  (use util-strings [join])
  (use util-math [pow10 -- ++ is-even])
  (use util-chain-data [block-time])

  (defschema state-schema
    state:string)

  (deftable state-table:{state-schema})

  (defun reset-state:string()
    "Reset the state of the generator. Should only be called when the contract is generated"
    (with-default-read state-table "" {'state:""} {"state":=s}
      (enforce (= s "") "Random generator already initialized" ))

    (write state-table ""{'state:(tx-hash)})
    (+ "Random Generator state resetted to " (tx-hash))
  )

  (defun --random-hash:string ()
    "Core private function which returns the 256 bits random number in base 64"
    (with-read state-table "" {"state":= old-state}
      (let ((seed1 (tx-hash))
            (seed2 (hash (block-time)))
            (new-state (hash (concat [old-state seed1 seed2]))))
        (update state-table "" {'state:new-state})
        new-state))
  )

  (defun random-int:integer ()
    "Returns a 256 bit random integer"
    (str-to-int 64 (--random-hash)))

  (defun random-int-range:integer (min_:integer max_:integer)
    "Returns a random integer in range [min - max]"
    (enforce (and (>= min_ 0) (>= max_ 0)) "Min and Max must be positive")
    (enforce (> max_ min_) "Max must be > to min")
    (let ((modulus (++ (- max_ min_))))
      (+ (mod (random-int) modulus) min_))
  )

  (defun random-decimal-range:decimal (min_:decimal max_:decimal)
    "Returns a random decimal in range [min - max] with a precision of 12"
    (enforce (> max_ min_) "Max must be > to min")
    (let ((to-int (lambda (x) (floor (* x (pow10 12)))))
          (to-decimal (lambda (x) (floor (* (dec x) (pow10 -12)) 12))))
      (+ min_ (to-decimal (random-int-range 0 (to-int (- max_ min_))))))
  )

  (defun random-string:string (len:integer)
    "Returns a random string whose length is given by the argument"
    (let ((cnt (++ (/ len 43)))
          (rnd (random-int))
          (substrings (map (lambda (x) (hash (+ rnd x))) (enumerate 1 cnt))))
      (take len (concat substrings)))
  )

  (defun random-bool:bool ()
    "Returns a random boolean: a coin flip"
    (is-even (random-int)))

  (defun random-choice (choices-list:list)
    "Returns a random element from the non-empty list"
    (enforce-not-empty choices-list)
    (let ((max-idx (-- (length choices-list)))
          (idx (random-int-range 0 max-idx)))
      (at idx choices-list))
  )

  (defun shuffle:list (in:list)
    "Shuffle a list"
    (let ((seed (random-int))
          (indexes (enumerate seed (+ (length in) seed)))
          (assign-order (lambda (x i) {'order:i, 'val:x })))
      (map (at 'val)
           (sort ['order]
                 (zip assign-order in (map (hash) indexes)))))
  )

  (defun gen-uuid-rfc-4122-v4:string ()
    "Generate an UUID (Universal Unique ID) according to RFC 4122 v4"
    (let ((set-bits (lambda (x bits mask) (int-to-str 16 (| bits (& mask (str-to-int 16 x))))))
          (uid-hex (int-to-str 16 (random-int)))
          (field-4 (take -12 uid-hex))
          (field-3 (take -4 (drop -12 uid-hex)))
          (field-3 (set-bits field-3 32768 16383))
          (field-2 (take -4 (drop -16 uid-hex)))
          (field-2 (set-bits field-2 16384 4095))
          (field-1 (take -4 (drop -20 uid-hex)))
          (field-0 (take -8 (drop -24 uid-hex))))
      (join "-" [field-0, field-1, field-2, field-3, field-4]))
  )
)
