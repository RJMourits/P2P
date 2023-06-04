**Mourits, R.J. & Rosenbaum-Feldbrügge, M. (2022). _Property to Person_. https://github.com/RJMourits/P2P**

This script matches records based on first names. 

The matching algorithm requires:
- _"R", tested under version 4_
- _The "stringdist" library by Van der Loo_

After installing match_property requires:
- _Two data frames_
- _containing a primary key titled "IDNR"_
- _and a variable with first names titled "Name"_

The user can adjust:
- _The maximum Levenshtein distance_
- _Whether to use an adaptive Levenshtein distance_

The algorithm doesn't filter matches. For filtering we suggest a stepwise approach containing
- _Rule-based filters_
- _Probabilistic filter_

For an implementation, see: https://github.com/HDSC-Nijmegen/Slavenregisters
