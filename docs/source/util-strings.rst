Strings functions
==================
**Contract:**
  * free.util-strings

**Dependencies:**
  * free.util-lists

General functions
-----------------

to-string
~~~~~~~~~
*x* ``<a>`` *→* ``integer``

Convert any pact type (object, list, decimal, ...) to its string representation

.. code:: lisp

  pact> (to-string 1.05)
  "1.05"

  pact> (to-string 45)
  "45"

  pact> (to-string ["a", "b", "c"])
  "["a" "b" "c"]"

  pact> (to-string {"a":1, "b":2, "c":3})
  "{"a": 1,"b": 2,"c": 3}"

char-at
~~~~~~~~~
*idx* ``integer``  *in* ``string`` *→* ``string``

Return the character at position *idx*

.. code:: lisp

  pact> (char-at 2 "Pact is Great !")
  "c"

slice
~~~~~
*low-idx* ``integer`` *high-idx* ``integer`` *in* ``string`` *→* ``string``

Return the substring between the two indexes:
  * *low-idx* is the start index
  * *high-idx* is the end index but the corresponding char is not included

.. code:: lisp

  pact> (slice 0 6 "Kadena")
  "Kadena"

  pact> (slice 1 5 "Kadena")
  "aden"

  pact> (slice 3 4 "Kadena")
  "e"


Conversion functions
--------------------

decimal-to-str
~~~~~~~~~~~~~~
*x* ``decimal`` *precision* ``integer`` *→* ``string``

Convert a decimal to string with a fixed precision.

.. code:: lisp

  pact> (decimal-to-str 3.14 2)
  "3.14"
  pact> (decimal-to-str 3.14 12)
  "3.140000000000"

str-to-decimal
~~~~~~~~~~~~~~
*x* ``string`` *→* ``decimal``

Convert a string to a decimal.

.. code:: lisp

  pact> (str-to-decimal "3.1415")
  3.1415


ASCII functions
-----------------

decode-ascii
~~~~~~~~~~~~
*in* ``string`` *→* ``[integer]``

Convert a string to an ASCII codes list: All characters must be printable

.. code:: lisp

  pact> (decode-ascii "Pact is Great !")
  [80 97 99 116 32 105 115 32 71 114 101 97 116 32 33]



str-to-ascii-int
~~~~~~~~~~~~~~~~
*in* ``string`` *→* ``integer``

Convert a string to its integer ASCII representation.
Each character represents 8 bit of the resulting integer
As pact does not impose a limit on integer size, ant arbitrary string can be converted to an integer.


.. code:: lisp

  pact> (str-to-ascii-int "Pact is Great !")
  417359021941874072168903757886922785

encode-ascii
~~~~~~~~~~~~
*in* ``[integer]`` *→* ``string``

Convert an ASCII code list to a string: All characters must be printable

.. code:: lisp

  pact> (encode-ascii [80 97 99 116 32 105 115 32 71 114 101 97 116 32 33])
  "Pact is Great !"

ascii-int-to-str
~~~~~~~~~~~~~~~~
*in* ``integer`` *→* ``string``

Convert an integer ASCII representation to a string. This is the exacte opposite of ``(str-to-ascii-int )``.

.. code:: lisp

  pact> (ascii-int-to-str 417359021941874072168903757886922785)
  "Pact is Great !"



Validation Functions
--------------------

is-digit
~~~~~~~~
*in* ``string`` *→* ``bool``

Return true if all characters are digits [0-9]

.. code:: lisp

  pact> (is-digit "1234")
  true

  pact> (is-digit "12A34")
  false

is-hex-digit
~~~~~~~~~~~~
*in* ``string`` *→* ``bool``

Return true if all characters are hexa [A-F a-F 0-9]

.. code:: lisp

  pact> (is-hex-digit "1234")
  true

  pact> (is-hex-digit "12A34")
  true

  pact> (is-hex-digit "12G34")
  false

is-alpha
~~~~~~~~
*in* ``string`` *→* ``bool``

Return true if all characters are in alphas [A-Z a-z]

.. code:: lisp

  pact> (is-alpha "Hello")
  true

  pact> (is-alpha "Hello!")
  false

starts-with
~~~~~~~~~~~
*in* ``string`` *to-match* ``string`` *→* ``bool``

Return true if the string starts with the string to-match

.. code:: lisp

  pact> (starts-with "k:0471bef109d43896f55f7b768733c2ba219364a9a7f2d470ed321f456a6b2fb9" "k:")
  true
  pact> (starts-with "k:0471bef109d43896f55f7b768733c2ba219364a9a7f2d470ed321f456a6b2fb9" "c:")
  false

ends-with
~~~~~~~~~
*in* ``string`` *to-match* ``string`` *→* ``bool``

Return true if the string ends with the string to-match

.. code:: lisp

  pact> (ends-with "k:0471bef109d43896f55f7b768733c2ba219364a9a7f2d470ed321f456a6b2fb9" "2fb9")
  true
  pact> (ends-with "k:0471bef109d43896f55f7b768733c2ba219364a9a7f2d470ed321f456a6b2fb9" "0471")
  false

contains-chars
~~~~~~~~~~~~~~
*values* ``string`` *in* ``string`` *→* ``bool``

Return true if in contains one of the characters in values. Can be useful to check that an account name, or a string
does not contain forbidden values.

This function can be seen as an ORed extension of the native ``(contains)``.

.. code:: lisp

  pact> (contains-chars "lp" "Hello World")
  true

  pact> (contains-chars "xp" "Hello World")
  false

  pact> (let ((FORBIDDEN_CHARS "$![]"))
  ....>   (enforce (not (contains-chars FORBIDDEN_CHARS "Hello")) "Forbidden chars"))
  true

  pact> (let ((FORBIDDEN_CHARS "$![]"))
  ....>   (enforce (not (contains-chars FORBIDDEN_CHARS "Hello!")) "Forbidden chars"))
  <interactive>:2:2: Forbidden chars



Characters replacement functions
--------------------------------

replace-char
~~~~~~~~~~~~
*in* ``string`` *old-char* ``string`` *new-char* ``string`` *→* ``string``

Replace all occurrences of old-char to new-char

.. code:: lisp

  pact> (replace-char "Hello World" "l" "p")
  "Heppo Worpd"

upper
~~~~~
*in* ``string``*→* ``string``

Transform a string to upper case

.. code:: lisp

  pact> (upper "Hello World !")
  "HELLO WORLD !"

lower
~~~~~
*in* ``string``*→* ``string``

Transform a string to lower case

.. code:: lisp

  pact> (lower "Hello World !")
  "hello world !"


Separators functions
---------------------

join
~~~~
*separator* ``string`` *in* ``[string]`` *→* ``string``

Join a list of string with a separator

.. code:: lisp

  pact> (join "/" ["one" "two" "three"])
  "one/two/three"

split
~~~~~
*separator* ``string`` *in* ``string`` *→*  ``[string]``

Split a string using a separator. Return a list of substrings. Separator must be a single char

.. code:: lisp

  pact> (split ";" "one;two;three")
  ["one" "two" "three"]



Strip functions
----------------

left-strip
~~~~~~~~~~~
*to-remove* ``string`` *in* ``string`` *→* ``string``

Remove any leading characters. *to-remove* must be in a single-char.

.. code:: lisp

  pact> (left-strip " " "     Hello World   ")
  "Hello World   "


right-strip
~~~~~~~~~~~
*to-remove* ``string`` *in* ``string`` *→* ``string``

Remove any trailing characters. *to-remove* must be in a single-char.

.. code:: lisp

  pact> (right-strip " " "     Hello World   ")
  "     Hello World"

strip
~~~~~
*to-remove* ``string`` *in* ``string`` *→* ``string``

Remove both leading and trailing characters. *to-remove* must be in a single-char.

.. code:: lisp

  (strip " " "     Hello World   ")
  "Hello World"
