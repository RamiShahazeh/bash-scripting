#!/bin/bash
# fileinfo.sh

FILES="/usr/sbin/privatepw
/usr/sbin/pwck
/usr/sbin/go500gw
/usr/bin/fakefile
/sbin/mkreiserfs
/sbin/ypbind" # List of files you are curious about.
# Threw in a dummy file, /usr/bin/fakefile.

echo
for file in $FILES
do
 if [ ! -e "$file" ] # Check if file exists.
 then
   echo "$file does not exist."; echo
   continue # On to next.
 fi
 ls -l $file 
 whatis `basename $file` # File info.
echo
done

###############################################
# Two ways to count up to 10.
echo
# Standard syntax.
for a in 1 2 3 4 5 6 7 8 9 10
do
echo -n "$a "
done
echo; echo
# +==========================================+
# Now, let's do the same, using C−like syntax.
LIMIT=10
for ((a=1; a <= LIMIT ; a++)) # Double parentheses, and "LIMIT" with no "$".
do
echo -n "$a "
done # A construct borrowed from 'ksh93'.
echo; echo
# +=========================================================================+
# Let's use the C "comma operator" to increment two variables simultaneously.
for ((a=1, b=1; a <= LIMIT ; a++, b++)) # The comma chains together operations.
do
echo -n "$a−$b "
done
echo; echo

# +=========================================================================+
# Simple while loop

LIMIT=10
a=1
while [ "$a" -le $LIMIT ]
do
echo -n "$a "
let "a+=1"
done # No surprises, so far.
echo; echo
# +=================================================================+
# Now, repeat with C−like syntax.
((a = 1)) # a=1
# Double parentheses permit space when setting a variable, as in C.
while (( a <= LIMIT )) # Double parentheses, and no "$" preceding variables.
do
echo -n "$a "
((a += 1)) # let "a+=1"
# Yes, indeed.
# Double parentheses permit incrementing a variable with C−like syntax.
done
echo
exit 0
