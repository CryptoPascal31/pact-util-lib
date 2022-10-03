;SPDX-License-Identifier: MIT

; This modules provides some utilities to work with string in Pact
; Be aware that this module is only in Beta and has not be audited:
;    --> BE CAREFUL if a security enforcement depends on one of theses functions
;
; Pact is not a word processor. And some functions can be gas expensive.
; Use sparingly, and eventually benchmark
;
; Remember that in Pact, all variables are immutable and no function can
; work in place. New string are always returned

(module util-strings GOV
  (defconst VERSION:string "0.1")
  (defcap GOV()
    (enforce-keyset "free.util-lib"))

  (use util-lists [replace-item first last append-last replace-last])

  (defconst ASCII-TABLE  {" ":32, "!":33, "\"":34, "#":35, "$":36, "%":37, "&":38, "\'":39,
                          "(":40, ")":41, "*":42, "+":43, ",":44, "-":45, ".":46, "/":47,
                          "0":48, "1":49, "2":50, "3":51, "4":52, "5":53, "6":54, "7":55,
                          "8":56, "9":57, ":":58, ";":59, "<":60, "=":61, ">":62, "?":63,
                          "@":64, "A":65, "B":66, "C":67, "D":68, "E":69, "F":70, "G":71,
                          "H":72, "I":73, "J":74, "K":75, "L":76, "M":77, "N":78, "O":79,
                          "P":80, "Q":81, "R":82, "S":83, "T":84, "U":85, "V":86, "W":87,
                          "X":88, "Y":89, "Z":90, "[":91, "\\":92, "]":93, "^":94, "_":95,
                          "`":96, "a":97, "b":98, "c":99, "d":100, "e":101, "f":102, "g":103,
                          "h":104, "i":105, "j":106, "k":107, "l":108, "m":109, "n":110, "o":111,
                          "p":112, "q":113, "r":114, "s":115, "t":116, "u":117, "v":118, "w":119,
                          "x":120, "y":121, "z":122, "{":123, "|":124, "}":125, "~":126})

  (defconst ASCII-TABLE-REVERSE (+ (make-list 32 "")
                                   (+ (str-to-list " !\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~")
                                      (make-list 128 ""))))

;
  (defun decode-ascii:[integer] (in:string)
    "Convert a string to an ASCII codes list: All characters must be printable"
    (map (lambda (x) (at x ASCII-TABLE))
         (str-to-list in))
  )

  (defun encode-ascii:string (in-list:[integer])
    "Convert an ASCII code list to a string: All characters must be printable"
    (concat
      (map (lambda (x) (at x ASCII-TABLE-REVERSE))
           in-list))
  )

  (defun is-digit:bool (in:string)
    "Returns true si all characters are digits 0 to 9"
    (fold (and) true (map (and? (<= 48) (>= 57)) (decode-ascii in)))
  )

  (defun is-alpha:bool (in:string)
    "Returns true si all characters are digits [A-Z a-z]"
    (fold (and) true (map (or? (and? (<= 65) (>= 90))
                               (and? (<= 97) (>= 122)))
                          (decode-ascii in)))
  )

  (defun is-hex-digit:bool (in:string)
    "Returns true si all characters are digits are hexa [A-F a-F 0-9]"
    (fold (and) true (map (or? (and? (<= 48) (>= 57))
                               (or? (and? (<= 65) (>= 70))
                                    (and? (<= 97) (>= 102))))
                          (decode-ascii in)))
  )

  (defun replace-char:string (in:string old-char:string new-char:string)
    "Replace all occurences of old-char to new-char"
    (concat (replace-item (str-to-list in) old-char new-char))
  )

  (defun upper:string (in:string)
    "Transform a string to upper case"
    (let ((do-upper (lambda (x)
                            (if (and? (<= 97) (>= 122) x)
                                (- x 32)
                                x))))
      (encode-ascii (map (do-upper) (decode-ascii in))))
  )

  (defun lower:string (in:string)
    "Transform a string to lower case"
    (let ((do-lower (lambda (x)
                            (if (and? (<= 65) (>= 90) x)
                                (+ x 32)
                                x))))
      (encode-ascii (map (do-lower) (decode-ascii in))))
  )

  (defun string-at:string (idx:integer in:string)
    "Returns the character at position idx"
    (at idx (str-to-list in))
  )

  (defun join:string (separator:string in:[string])
    "Join a list of string with a separator"
    (if (= 0 (length in))
        ""
        (if (= 1 (length in))
            (at 0 in)
            (+ (first in) (concat (map (+ separator) (drop 1 in))))))
  )

  (defun split:[string] (separator:string in:string)
    "Split a string using a sepator. Retun a list of substrings. Separator can only be a single char"
    (if (= 0 (length in))
        [] ;If the string is empty return a zero length list
        (let ((process-char (lambda (current-list char)
                                    (if (= char separator)
                                        (append-last current-list "")
                                        (replace-last current-list (+ (last current-list) char))))))
          (fold (process-char) [""] (str-to-list in))))
  )

  (defun starts-with:bool (in:string to-match:string)
    "Returns true if the string starts with the string to-match"
    (let ((len (length to-match)))
      (if (>= (length in) len)
          (= (take len in) to-match)
          false))
  )

  (defun ends-with:bool (in:string to-match:string)
    "Returns true if the string ends with the string to-match"
    (let ((len (length to-match)))
      (if (>= (length in) len)
          (= (take (- len) in) to-match)
          false))
  )

  ;; Stripping functions
  (defun --count-to-strip:integer (to-remove:string in:[string])
    (let* ((do-count (lambda (state x)
                             (bind state {"s":=s, "cnt":=cnt}
                              (if (not s)
                                  state
                                  (if (= x to-remove)
                                      (+ {'cnt: (+ cnt 1)} state)
                                      (+ {'s:false} state)))))))

      (at 'cnt (fold (do-count) {'s:true, 'cnt:0} in)))
  )

  (defun left-strip:string (to-remove:string in:string)
    "Remove any leading characters"
    (let ((cnt (--count-to-strip to-remove (str-to-list in))))
      (drop cnt in))
  )

  (defun right-strip:string (to-remove:string in:string)
    "Remove any leading characters"
    (let ((cnt (--count-to-strip to-remove (reverse (str-to-list in)))))
      (drop (- cnt) in))
  )

  (defun strip:string (to-remove:string in:string)
    "Remove leadind and trailing characters"
    (right-strip to-remove (left-strip to-remove in))
  )




)
