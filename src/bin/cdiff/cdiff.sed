#!/usr/bin/sed -f

/^[	 ]/ b

/^+++/ s/^/[32m/
/^---/ s/^/[31m/

/^+/ s/^/[1;32m/
/^-/ s/^/[1;31m/
/^@/ s/^/[1;35m/

/^Binary files .* are identical$/ s/^/[1;36m/
/^Files .* are identical$/ s/^/[1;36m/

/^\\/ s/^/[1;35m/

/^diff / s/^/[1;33m/

t end
s/^/[1;34m/
: end

s/ \{1,\}$/[1;30m&/

: loop
s/ \( *\)$/+\1/
t loop

s/$/[m/
