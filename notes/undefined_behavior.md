# Undefined Behavior is Not an Error

Defined behavior: `int sum = 2 + 3` will always result in a variable that equals 5.

Implementation defined behavior: code may have different meaning depending on the compiler/platform, i.e. using
`sizeof(int)`.

Unspecified behavior: code which has multiple possible meanings so the compiler is allowed to chose one at random.
Ex. `if( "abc" == "abc" )`o

Undefined behavior: code which has no meaning. Ex. dereferencing a null pointer.