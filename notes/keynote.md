# Keynote Presentation

## Contents
- [The Future of Generic Programming](#the-future-of-gneric-programming)

## The Future of Generic Programming
Generic programming centers around the idea of abstration from concrete, efficient algorithms to obtain generic algorithms that can be
combined with different data representations to produce a wide variety of useful software.

Good generic code is
- cleaner
- Less clever
- More usable and re-usable
- Type-safe
- Etc

Concepts will be be available in C++20.

---

## Generic Programming
The goal of GP is to make gneric code as simple as non-generic code, and make more advanced generic code as easy to use an not that much
more difficult ot write.

## Types and Concepts

Types: specifies the set of operations that can be applied to an object. Relies on function declarations and language rules.

Concepts: specifies the set of operations that can be applied to an object. Relies on use patterns.

Concepts are compile-time predicates.
- `ForwardIterator < T >`: is `T` a `ForwardIterator`?
- Have always had concepts, in the designer's head, in the documentation, etc. Now there is direct language support for them.
- A good concept represents a fundamental concept of a domain, and is well-designed.
    - A concept is **not** the minimal requirements for an implementaiton
        - Does not define the requirements; requirements should be stable.
- Concepts are **not** types of types, nor are they type classes.

Ex. `Sortable` is a concept that describes what is and isn't sortable. This gives more succinct compilation errors when trying
to sort data types that are not sortable.
```c++
void sort( Sortable& c ); // Sortable is a Concept
// A sortable has a random access sequence with an operator< implementation

sort( myVectorOfInts );    // OK
sort( myListofInts );      // Error: lists aren't sortable
sort( myVectorOfStructs ); // Error: scructs aren't sortable
```

Defining a concept:
```c++
template< typename T > concept int = Same< T, int >
```

Concept benefits:
- Supports good design
- Readability, maintainability
    - Don't expect optimal readibility from older libs converted to use concepts (often need to be "bug compatible) and "advanced foundation
    libaries" (they often don't have much flexibility)
- Overloading
- Reduces compile times
- Concepts give precise and early error messages - and fewer errors accross the board.

```c++
// Ex. 1
template< typename T > class Ptr
{
    // Using concepts
    T* operator->() requires is_class< T >; // Offer -> only if T is a class

    // The old, enable_if method
    std::enable_if_t< is_class_v < U >, T* > operator->();
};

// Ex. 2
template< InputIterator Iter, typename Value > requires EqualityComparable< Value_type< iter, Value >
Iter find( iter first, iter last, Value val );
```

## Typed vs. Untyped
Most people prefer types because they:
- Document intended use
- Improves readability
- Enables overloading
- Helps catch errors
- Etc

Concepts will change the way that we think about
- Programming (not just GP)
- Design
- Interfaces

### Definiing concepts
Compose from existing concepts:
```c++
templace < typename T >
concept Sortable =
    Sequence< T>                     // has begin() and end()
    && Random_access< T >            // has [], +, etc
    && Comparable< Value_type< T > >; // has ==, !=, <, etc
```

Partial/incomplete concepts are useful...
- during development,
- as building blocks, but
- don't use them as interfaces in application code.
    - `requires requires` is a code smell for bad design & the concept should be written in a better way.

Sometimes concepts may accidentally match.
- Ex. may require function `draw()`, but several unlreated classes may have this member defined.
    - Typically you would have more than one constraint - has `draw()` **but also** has some other properties.
    - `static_assert( Range< Some_Type > )`: does `Some_Type` match the concept `Range`?

Concepts can be composed together; instead of asserting many concepts for a function `merge()`, you can instead
create a new concept, `Mergable`, to abstract out many of these concepts.