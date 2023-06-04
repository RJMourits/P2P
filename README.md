This script matches records based on first names. The algorithm doesn't filter matches. For filtering we suggest a stepwise approach containing
- Rule-based filters
- Probabilistic filter
For an implementation of see: https://github.com/HDSC-Nijmegen/Slavenregisters

The matching algorithm requires:
- "R", tested under version 4
- The "stringdist" library by Van der Loo

After installing match_property requires:
- Two data frames
- containing a primary key titled "IDNR"
- and a variable with first names titled "Name"

The user can adjust:
- The maximum Levenshtein distance
- Whether to use an adaptive Levenshtein distance

The algorithm doesn't filter matches. For filtering we suggest a stepwise approach containing
- Rule-based filters
- Probabilistic filter

#Mourits, R.J. & Rosenbaum-Feldbrügge, M. (2022). Property to Person. https://github.com/RJMourits/P2P
