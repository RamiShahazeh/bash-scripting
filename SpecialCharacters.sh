#!/bin/bash
# Special Characters

# the comment characters # :

echo "The # here does not begin a comment."
echo 'The # here does not begin a comment.'
echo The \# here does not begin a comment.
echo The # here begins a comment.
echo $(( 2#101011 )) # Base conversion, not a comment.

################################

# Quoting
echo "My shell is $SHELL"
echo 'My shell is $SHELL'


#################################

# the command separator ; :
# Permits putting two or more commands on the same line.

echo hello; echo there

################################

# the terminator in a 'case' option :

variable=abc
case "$variable" in
abc) echo "variable = abc" ;;
xyz) echo "variable = xyz" ;;
esac

################################

# the comma character , :
# The comma operator links together a series of arithmetic operations. All are evaluated, but only the last one is returned.

let "t2 = ((a = 3, 15 / a))" # Set "a" and calculate "t2".
echo $t2

################################

# command group () :
# A listing of commands within parentheses starts a subshell.

a=123
( a=321; )
echo "a = $a" # a = 123
# "a" within parentheses acts like a local variable.

################################

# block of code {} :
# Block of code. [curly brackets] Also referred to as an "inline group", this construct, in effect, creates an anonymous function. However, unlike a function, the variables in a code block remain visible to the remainder of the script.

a=123
{ a=321; }
echo "a = $a" # a = 321 (value inside code block)

################################
File=$0
{
read line1
read line2
} < $File
echo "First line in $File is:"
echo "$line1"
echo
echo "Second line in $File is:"
echo "$line2"
echo
