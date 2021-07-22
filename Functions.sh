#!/bin/bash
# gcd.sh: greatest common divisor
# Uses Euclid's algorithm
# The "greatest common divisor" (gcd) of two integers
#+ is the largest integer that will divide both, leaving no remainder.
# Euclid's algorithm uses successive division.
# In each pass,
#+ dividend <−−− divisor
#+ divisor <−−− remainder
#+ until remainder = 0.
#+ The gcd = dividend, on the final pass.
#
# For an excellent discussion of Euclid's algorithm, see
# Jim Loy's site, http://www.jimloy.com/number/euclids.htm.
# −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
# Argument check
ARGS=2
E_BADARGS=65
if [ $# -ne "$ARGS" ]
then
echo "Usage: `basename $0` first−number second−number"
exit $E_BADARGS
fi
# −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
gcd ()
{
# Arbitrary assignment.
dividend=$1
divisor=$2 
remainder=1 # If uninitialized variable used in loop,
#+ it results in an error message
#+ on first pass through loop.
until [ "$remainder" -eq 0 ]
do
let "remainder = $dividend % $divisor"
dividend=$divisor # Now repeat with 2 smallest numbers.
divisor=$remainder
done # Euclid's algorithm
} # Last $dividend is the gcd.
gcd $1 $2
echo; echo "GCD of $1 and $2 = $dividend"; echo
