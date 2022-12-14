# Pact (Kadena) utilities library
## Introduction
This library aims to provide some "high level" functions for writing Pact smart contracts.

The library contains currently more than 100 convenience functions split into 5 modules

## Documentation
[Read the docs](https://pact-util-lib.readthedocs.io/)

## Modules

### util-lists.pact
Deployed as ```free.util-lists```

Contains functions to handle Pact lists.

**Functions:**
* ```(defun enforce-not-empty:bool (x:list)``` : Verify and enforce that a list is not empty
* ```(defun enforce-list-bounds:bool (x:list idx:integer)``` : Verify and enforce that *idx* is in list bounds
* ```(defun chain:list (in:list)``` : Chain list of lists
* ```(defun enumerate-list:[object] (in:list)``` : Returns a list of objects {'i:idx, 'v:value} where i is the index, and v the value
* ```(defun first (in:list)``` : Returns the first item of a list
* ```(defun last (in:list)``` : Returns the last item of the list
* ```(defun at* (in:list idx:integer default)```: Returns the element at *idx*, but returns *default* if the list is too short
* ```(defun search:[integer] (in:list item)``` : Search an item into the list and returns a list of index
* ```(defun count:integer (in:list item)``` : Returns the number of occurrences of an item
* ```(defun make-list-like (in:list value)```: "Creates a new list whose size is the same as in, by repeating value
* ```(defun extend (in:list new-length:integer value)```: Extends a list to new-length by repeating value
* ```(defun extend-like (in:list target:list value)```: Extends a list to the same length as target, by repeating value
* ```(defun insert-first:list (in:list item)``` : Insert an item at the left of the list
* ```(defun append-last:list (in:list item)``` : Append an item at the end of the list
* ```(defun insert-at:list (in:list idx:integer item)``` : Insert an item at position *idx*
* ```(defun insert-at*:list (in:list idx:integer item default)```:  Insert an item at position *idx*, extends the list if it is too short using the *default* value
* ```(defun replace-first:list (in:list item)``` : Replace the first item of the list
* ```(defun replace-last:list (in:list item)``` : Replace the last item of the list
* ```(defun replace-at:list (in:list idx:integer item)``` : Replace the item at position *idx*
* ```(defun replace-at*:list (in:list idx:integer item default)```:  Replace an item at position *idx*, extends the list if it is too short using the *default* value
* ```(defun replace-item:list (in:list old-item new-item)``` : Replace each occurrence of *old-item* by *new-item*
* ```(defun replace-item*:list (in:list old-item new-item)``` : *(starred version)* Replace each occurrence of *old-item* by *new-item* but raises an error if *old-item* does not exist
* ```(defun remove-first:list (in:list)``` : Remove first element from the list
* ```(defun remove-last:list (in:list)``` : Remove element at position *idx*
* ```(defun remove-item:list (in:list item)``` : Remove an item from a list
* ```(defun remove-item*:list (in:list item)``` : *(starred version)* Remove and item from the list but raises an error if it does not exist

### util-strings.pact
Deployed as ```free.util-strings```

Contains functions to handle Pact strings. This module depends on util-lists.

**Functions:**
* ```(defun to-string:string (x)```: Convert any pact type (object, list, decimal, ...) to its string representation
* ```(defun decode-ascii:[integer] (in:string)``` : Convert a string to an ASCII codes list: All characters must be printable
* ```(defun str-to-ascii-int:integer (in:string)```: Convert a string to its integer ASCII representation
* ```(defun encode-ascii:string (in-list:[integer])``` : Convert an ASCII code list to a string: All characters must be printable
* ```(defun ascii-int-to-str:string (in:integer)```: Convert an integer ASCII representation to a string
* ```(defun is-digit:bool (in:string)``` : Returns true if all characters are digits [0-9]
* ```(defun is-alpha:bool (in:string)``` : Returns true if all characters are in alphas [A-Z a-z]
* ```(defun is-hex-digit:bool (in:string)``` : Returns true if all characters are hexa [A-F a-F 0-9]
* ```(defun contains-chars:bool (values:string in:string)``` Returns true if in contains one of the characters in values
* ```(defun replace-char:string (in:string old-char:string new-char:string)``` : Replace all occurrences of old-char to new-char
* ```(defun upper:string (in:string)``` : Transform a string to upper case
* ```(defun lower:string (in:string)``` : Transform a string to lower case
* ```(defun char-at:string (idx:integer in:string)``` : Returns the character at position *idx*
* ```(defun slice(low-idx:integer high-idx:integer in:string)``` Returns the substring between the two indexes
* ```(defun join:string (separator:string in:[string])``` : Join a list of string with a separator
* ```(defun split:[string] (separator:string in:string)``` : Split a string using a separator. Returns a list of substrings. *separator* can only be a single char
* ```(defun starts-with:bool (in:string to-match:string)``` : Returns true if the string starts with the string *to-match*
* ```(defun ends-with:bool (in:string to-match:string)``` : Returns true if the string ends with the string *to-match*
* ```(defun left-strip:string (to-remove:string in:string)``` : Remove any leading characters
* ```(defun right-strip:string (to-remove:string in:string)``` : Remove any trailing characters
* ```(defun strip:string (to-remove:string in:string)``` : Remove both leading and trailing characters
* ```(defun decimal-to-str (x:decimal precision:integer)```: Convert a decimal to string with a fixed precision
* ```(defun str-to-decimal:decimal (in:string)```: Convert a string to a decimal


### util-math.pact
Deployed as ```free.util-math```

Contains some math utilities. This module depends on util-lists.

Most functions of this module only handle ```decimal``` type. ```integer```s are not supported.

**Functions:**
* ```(defconst PI:decimal``` : Pi
* ```(defconst E:decimal``` : e = Euler's number
* ```(defconst GOLDEN-RATIO:decimal``` : Phi = Golden ratio
* ```(defun min:decimal (x:decimal y:decimal)``` : Returns the min of 2 values
* ```(defun min3:decimal (x:decimal y:decimal z:decimal)```: Returns the min of 3 values
* ```(defun min4:decimal (x:decimal y:decimal z:decimal zz:decimal)```: Returns the min of 4 values
* ```(defun min-list:decimal (x:[decimal])``` : Returns the min of a list
* ```(defun amin:integer (in:[decimal])``` : Returns the min index of a list
* ```(defun max:decimal (x:decimal y:decimal)``` : Returns the max of 2 values
* ```(defun max3:decimal (x:decimal y:decimal z:decimal)``` : Returns the max of 3 values
* ```(defun max4:decimal (x:decimal y:decimal z:decimal zz:decimal)``` : Returns the max of 4 values
* ```(defun max-list:decimal (x:[decimal])``` : Returns the max of a list
* ```(defun amax:integer (in:[decimal])``` : Returns the max index of a list
* ```(defun sum3:decimal (x:decimal y:decimal z:decimal)``` : Returns the sum of 3 values
* ```(defun sum4:decimal (x:decimal y:decimal z:decimal zz:decimal)``` : Returns the sum of 4 values
* ```(defun sum:decimal (x:[decimal])``` : Returns the sum of a list
* ```(defun prod3:decimal (x:decimal y:decimal z:decimal)``` : Returns the product of 3 values
* ```(defun prod4:decimal (x:decimal y:decimal z:decimal zz:decimal)``` : Returns the product of 4 values
* ```(defun prod:decimal (x:[decimal])``` : Returns the product of a list
* ```(defun square:decimal (x:decimal)``` : Returns the square of x
* ```(defun safe-/ (x:decimal y:decimal default:decimal)``` : Divide *x*/*y* but returns *default* if *y* is 0.0
* ```(defun avg:decimal (x:[decimal])``` : Returns the average of a list
* ```(defun is-even:bool (x:integer)``` : Returns true if *x* is even
* ```(defun is-odd:bool (x:integer)``` : Returns true if *x* is odd
* ```(defun med:decimal (x:[decimal])``` : Returns the median of a list: if the length of the list is even return the (n/2 -1)th element
* ```(defun med*:decimal (x:[decimal])``` : *(starred version)* Returns the median of a list: if the length of the list is even return the average of the (n/2 -1)th and (n/2)th elements
* ```(defun between:bool (a:decimal b:decimal x:decimal)``` : Returns true is a <= x <= b
* ```(defun sign:decimal (x:decimal)``` : Returns 1.0 if *x* is positive, 0.0 if *x* is null, and -1.0 if *x* is negative
* ```(defun gcd:integer (a:integer b:integer)``` : Returns the greatest common divisor of 2 integers
* ```(defun lcm:integer (a:integer b:integer)``` : Returns the least common multiple of 2 integers
* ```(defun pow10:decimal (x:integer)``` : Returns 10^*x*, rounded to 12 decimals
* ```(defun xEy (x:decimal y:integer)``` : Returns x.10^*y*, rounded to 12 decimals
* ```(defun log10:decimal (x)``` : Returns the log of x base 10, rounded to 12 decimals
* ```(defun safe-log (x y default)``` : Log of Y base X, but returns default when y <= 0
* ```(defun safe-ln (x:decimal default:decimal)``` : Natural log of x, but returns default when x <= 0
* ```(defun safe-log10:decimal (x default:decimal)``` : Returns the log of x base 10, rounded to 12 decimals but returns default when y <= 0

### util-time.pact
Deployed as ```free.util-time```

Contains some time utilities

**Functions:**
* ```(defun epoch:time ()``` : Returns Unix EPOCH
* ```(defun genesis:time ()``` : Returns Kadena Genesis time
* ```(defun now:time ()``` : Returns the current time
* ```(defun today:string ()```: Returns the current day
* ```(defun earliest:time (time1:time time2:time)``` : Returns the earliest time between *time1* and *time2*.
* ```(defun latest:time (time1:time time2:time)``` : Returns the latest time between *time1* and *time2*.
* ```(defun time-between:bool (time1:time time2:time in:time)``` : Returns true if *in* is between *time1* and *time2*
* ```(defun is-past (in:time)```: Returns true if *in* is in the past (before now)
* ```(defun is-future (in:time)```: Returns true if *in* is in the future (after now)
* ```(defun is-today (in:time)```: Returns true if the time *in* is in the current day
* ```(defun to-timestamp:decimal (in:time)``` : Computes an Unix timestamp of the input time
* ```(defun from-timestamp:decimal (timestamp:decimal)``` : Computes a time from an Unix timestamp
* ```(defun est-height-at-time:integer (target-time:time)``` : Estimates the block height at a target-time
* ```(defun est-time-at-height:time (target-block:integer)``` : Estimates the time of the target-block height
* ```(defun diff-time-minutes:decimal (time1:time time2:time)```: Computes difference between *time1* and *time2* in minutes
* ```(defun diff-time-hours:decimal (time1:time time2:time)```: Computes difference between *time1* and *time2* in hours
* ```(defun diff-time-days:decimal (time1:time time2:time)```: Computes difference between *time1* and *time2* in days

### util-random.pact
Deployed as ```free.util-random```

This module is a state-full PRNG. It uses the random/unpredictability properties of BLAKE2. The seeds are:
1. Transactions hash
2. Block time

It can generate many values during the same transaction.

The random generation can be controlled by the miner (via block-time)
**DO NOT** use for Cryptographically purposes, or for real money games.
The module is mainly intended to be used for non critical applications or random ID generation.


**Functions:**
* ```(defun random-int:integer ()``` : Returns a 256 bit random integer
* ```(defun random-int-range:integer (min_:integer max_:integer)``` : Returns a random integer in range [min - max]
* ```(defun random-decimal-range:decimal (min_:decimal max_:decimal)```: Returns a random (uniform distribution) decimal in range [min - max]
* ```(defun random-string (len:integer)``` : Returns a random string whose length is given by the argument
* ```(defun random-choice (choices-list:list)```: Returns a random element from the non-empty list
* ```(defun shuffle (in:list)```: Shuffles the list *in*
* ```(defun gen-uuid-rfc-4122-v4:string ()``` : Generate an UUID (Universal Unique ID) according to RFC 4122 v4

## Tests
Unit tests can be found in pact/test_repl.

All functions are tested, but currently the coverage is not 100%. Tested with **Pact 4.4.1**

The ```pact``` executable is needed to run the tests.

Each module can be tested independently.

*eg:* ```pact pact/tests_repl/util-random-test.repl```

or
```(cd pact; make  test-util-random)```

The whole test suite can be launched using:

```make test```

## Deployment
The deploy directory allows to do an automatic deployment on testnet and mainnet.

It is based on a Makefile and on the following commands:
* kda-tool : https://github.com/kadena-io/kda-tool
* jq

The private keys in ``./deploy/keys`` are obviously not present on Github

The deployment is done by the command:

```make testnet```

or

```make mainnet```

## Documentation
The documentation can be generated using sphinx:

```make doc```

## Todo
* Add more units tests
* Benchmarks (gas) the functions
*  Improve documentation
