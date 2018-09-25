# Modern C++ API Design

## Micro-API Design
The "atom" of C++ API design: a good *overload set*. An *overload set* is a collection of functions in the same scope (namespace, class, etc) of the same name...

Use overloaded functions only if it's immediately obvious to the reader which overload is being called - they shouldn't
have to figure it out in their head.
This overload set is well-designed: it doesn't matter which overload is being called because they all do the same thing.
```c++
StrCat( "hello", name );
StrCat( "Hello", name, " ", n );

// Still need to be wary of use-after-move
push_back( const T& );
push_back( T&& );
```

Properties of good overload set:
- Correctness can be judged at the call site without knowing which overlaod is picked
- A single good comment can describe the full set
- Each element of the set is doing "the same thing"

Most important overload set: *copy vs move*. Both must be implemented in the most optimal way by the designer; the user
must choose the best method to fit their needs.

Don't use `= delete` in an overload set to describe lifetime. Deleting a move or a copy constructor may result in a bad
overload set - you don't know exactly how your API is going to be used by the user.

Method qualifier overloads: a const overload function will return a const value if invoked, and a non-const reference
otherwise.

Summary
- Think in overload sets
- Move and copy are an overload set
- Make explicit any constructors that aren't a "good" overload
- Be skeptical about `=delete` (and equivalent) in overloads
- `string_view` etc may replace some overload sets
- Overloading on method qualifiers is powerful
- Mutable members are a thread-safety smell
- Const methods have thread-safety meaning

---

- Sink parameter: when some function that accepts an input to copy (usually for storage), that input is a sink parameter.
- User-after-move
- Sharp edges in design
- Type erasure

---
## Type Properties

--
## Type Families
