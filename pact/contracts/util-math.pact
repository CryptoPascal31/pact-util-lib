;SPDX-License-Identifier: MIT

; This modules provides some convenient math function for Pact.
;
; Be aware that this module is only in Beta and hasn't been audited:
;    --> BE CAREFUL if a security enforcement depends on one of theses functions
;
;
; Feel free to reuse, comment, review, fork, propose PRs, submit bugs:
; https://github.com/CryptoPascal31/pact-util-lib

(module util-math GOV
  "Module containing math utilities \
   \ Documentation: https://pact-util-lib.readthedocs.io \
   \ Github: https://github.com/CryptoPascal31/pact-util-lib "

  (defconst VERSION:string "0.10")

  (defcap GOV()
    (enforce-keyset "free.util-lib"))

  (use util-lists [enforce-not-empty first enumerate-list remove-first])

  (defconst PI:decimal 3.141592653589793)

  (defconst E:decimal 2.718281828459045)

  (defconst GOLDEN-RATIO:decimal (/ (+ 1.0 (sqrt 5.0)) 2.0))

  (defun min:decimal (x:decimal y:decimal)
    "Returns the min of 2 values"
    (if (< x y) x y))

  (defun min3:decimal (x:decimal y:decimal z:decimal)
    "Returns the min of 3 values"
    (min x (min y z)))

  (defun min4:decimal (x:decimal y:decimal z:decimal zz:decimal)
    "Returns the min of 4 values"
    (min (min x y) (min z zz)))

  (defun min-list:decimal (x:[decimal])
    "Returns the min of a list"
    (enforce-not-empty x)
    (fold min (first x) (remove-first x))
  )

  (defun amin:integer (in:[decimal])
    "Returns the min index of a list"
    (enforce-not-empty in)
    (let ((in-enum (enumerate-list in))
          (cmp (lambda (x y) (if (< (at 'v x) (at 'v y)) x y))))
      (at 'i (fold cmp (first in-enum) (remove-first in-enum))))
  )

  (defun max:decimal (x:decimal y:decimal)
    "Returns the max of 2 values"
    (if (> x y) x y))

  (defun max3:decimal (x:decimal y:decimal z:decimal)
    "Returns the max of 3 values"
    (max x (max y z)))

  (defun max4:decimal (x:decimal y:decimal z:decimal zz:decimal)
    "Returns the max of 4 values"
    (max (max x y) (max z zz)))

  (defun max-list:decimal (x:[decimal])
    "Returns the max of a list"
    (enforce-not-empty x)
    (fold max (first x) (remove-first x))
  )

  (defun amax:integer (in:[decimal])
    "Returns the max index of a list"
    (enforce-not-empty in)
    (let ((in-enum (enumerate-list in))
          (cmp (lambda (x y) (if (> (at 'v x) (at 'v y)) x y))))
      (at 'i (fold cmp (first in-enum) (remove-first in-enum))))
  )

  (defun clamp:decimal (low-limit:decimal up-limit:decimal x:decimal)
    "Clamp x between low-limit and up-limit"
    (cond
      ((< x low-limit) low-limit)
      ((> x up-limit) up-limit)
      x)
  )

  (defun sum3:decimal (x:decimal y:decimal z:decimal)
    "Returns the sum of 3 values"
    (+ x (+ y z)))

  (defun sum4:decimal (x:decimal y:decimal z:decimal zz:decimal)
    "Returns the sum of 4 values"
    (+ (+ x y) (+ z zz)))

  (defun sum:decimal (x:[decimal])
    "Returns the sum of a list"
    (fold + 0.0 x))

  (defun prod3:decimal (x:decimal y:decimal z:decimal)
    "Returns the product of 3 values"
    (* x (* y z)))

  (defun prod4:decimal (x:decimal y:decimal z:decimal zz:decimal)
    "Returns the product of 4 values"
    (* (* x y) (* z zz)))

  (defun prod:decimal (x:[decimal])
    "Returns the product of a list"
    (fold * 1.0 x))

  (defun square:decimal (x:decimal)
    "Returns the square of x"
    (* x x))

  (defun safe-/ (x:decimal y:decimal default:decimal)
    "Divide x/y but returns default if y is 0.0"
    (if (= y 0.0) default (/ x y)))

  (defun geom-mean(x:[decimal])
    "Return the geometric mean of a list"
    (enforce-not-empty x)
    (^ (prod x) (/ 1.0 (dec (length x)))))

  (defun avg:decimal (x:[decimal])
    "Returns the average of a list"
    (enforce-not-empty x)
    (/ (sum x) (dec (length x))))

  (defun sizeof:integer (x:integer)
    "Returns the storage size of a positive integer in bytes"
    (enforce (>= x 0) "Sizeof does not allow negative numbers")
    (if (= x 0) 1
                (ceiling (log 256.0 (dec (++ x)))))
  )

  (defun ++:integer (x:integer)
    "Increment integer"
    (+ x 1)
  )

  (defun --:integer (x:integer)
    "Decrement integer"
    (- x 1)
  )

  (defun is-even:bool (x:integer)
    "Returns true if x is even"
    (= 0 (mod x 2)))

  (defun is-odd:bool (x:integer)
    "Returns true if x is odd"
    (= 1 (mod x 2)))

  (defun med:decimal (x:[decimal])
    "Returns the median of a list: if the length of the list is even return the (n/2 -1)th element"
    (enforce-not-empty x)
    (let ((cnt (length x))
          (mid (/ cnt 2))
          (index (if (is-even cnt) (- mid 1) mid)))
      (at index (sort x)))
  )

  (defun med*:decimal (x:[decimal])
    "Returns the median of a list: if the length of the list is even return the average of the\
    \(n/2 -1)th and (n/2)th elements"
    (enforce-not-empty x)
    (let ((cnt (length x))
          (mid (/ cnt 2))
          (mid-1 (- mid 1))
          (sorted-x (sort x)))
      (if (is-even cnt)
          (/ (+ (at mid sorted-x) (at mid-1 sorted-x)) 2.0)
          (at mid sorted-x)))
  )

  (defun between:bool (a:decimal b:decimal x:decimal)
    "Returns true is a <= x <= b"
    (and? (<= a) (>= b) x))

  (defun between*:bool (a:decimal b:decimal x:decimal)
    "Returns true is a < x < b"
    (and? (< a) (> b) x))

  (defun sign:decimal (x:decimal)
    "Returns 1.0 if x is positive, 0.0 if x is null, and -1.0 if x is negative"
    (cond
      ((> x 0.0) 1.0)
      ((< x 0.0) -1.0)
      0.0))

(defun ramp:decimal (x:decimal)
    "Returns x if is x is positive, 0.0 otherwise"
    (if (>= x 0.0) x 0.0))


  (defun gcd:integer (a:integer b:integer)
    "Returns the greatest common divisor of 2 integers"
    ; We use the Euclidean iterative algorithm (optimized by modulo)
    ; According to several sources and my own tests, the maximum complexity of the Euclidean algorithm is
    ; log/Phy ( min(a,b)). For safety, at the end, we check (enforce) that the algorithm has ended (ie b=0)/
    ; But that enforcement should never fail.

    ; First let remove the sign of a and b and order them
    ; a* is the big, *b is the small
    (let ((a (abs a)) (b (abs b))
          (a* (if (< a b) b a))
          (b* (if (< a b) a b)))
      (if (= b* 0) a* ; If one (or both) of the arguments is 0: return |a|
          (let ((max-iterations (ceiling (log GOLDEN-RATIO (dec b*))))
                (gcd-inner (lambda (x i) (if (= (at 'b x) 0)
                                             x
                                             {'a: (at 'b x), 'b: (mod (at 'a x) (at 'b x))})))
                (gcd-result (fold gcd-inner {'a:a*, 'b:b*} (enumerate 1 max-iterations))))
            (enforce (= (at 'b gcd-result) 0) "Euclidean algorithm not finished")
            (at 'a gcd-result))))
  )

  (defun lcm:integer (a:integer b:integer)
    "Returns the least common multiple of 2 integers"
    (enforce (and (!= a 0) (!= b 0)) "Arguments can't be 0")
    (/ (abs (* a b)) (gcd a b))
  )

  (defun pow10:decimal (x:integer)
    "Returns 10^x, rounded to 12 decimals (rounding is important when x is negative)"
    (round (^ 10.0 (dec x)) 12))

  (defun xEy (x:decimal y:integer)
    "Returns x.10^y, rounded to 12 decimals"
    (round (* x (pow10 y)) 12))

  (defun dec*:decimal(x)
    "Convert an integer or decimal to decimal"
    (if (= (typeof x) "decimal") x (dec x)))

  ;;; Rounding helpers
  (defun round* (decimals:integer x:decimal)
    "Reversed round function"
    (round x decimals))

  (defun floor* (decimals:integer x:decimal)
    "Reversed floor function"
    (floor x decimals))

  (defun ceiling* (decimals:integer x:decimal)
    "Reversed ceiling function"
    (ceiling x decimals))

  (defun /-r (decimals:integer x:decimal y:decimal)
    "Rounded division"
    (round (/ x y) decimals))

  (defun /-f (decimals:integer x:decimal y:decimal)
    "Floored division"
    (floor (/ x y) decimals))

  (defun /-c (decimals:integer x:decimal y:decimal)
    "Ceiled division"
    (ceiling (/ x y) decimals))

  ;;; Log functions
  (defun log10:decimal (x)
    "Returns the log of x base 10, rounded to 12 decimals"
    ; x can be decimal or an integer but the returned result is always a decimal
    (round (log 10.0 (dec* x)) 12))

  (defun safe-log (x y default)
    "Log of Y base X, but returns default when y <= 0"
    (if (> (dec* y) 0.0 ) (log x y) default))

  (defun safe-ln (x:decimal default:decimal)
    "Natural log of x, but returns default when x <= 0"
    (if (> x 0.0 ) (ln x) default))

  (defun safe-log10:decimal (x default:decimal)
    "Returns the log of x base 10, rounded to 12 decimals but returns default when x <= 0"
    ; x can be decimal or an integer but the returned result is always a decimal
    ; btw default has to be a decimal
    (if (> (dec* x) 0.0 ) (log10 x) default))

)
