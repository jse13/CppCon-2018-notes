# Fancy Pointers for Fun and Profit
## Stupid Allocator Tricks
*Code and presentation available on speaker's GitHub.*

---

### Overview

#### Motivating problems
Problem is persistance.
- Set of types/objects have container data members
- Large number of them
- Have time-consuming consruction/copy/traversal

Would like to:
- save to storage
- transmit somewhere else

Obvious solution is serialization:
1. iterate over source objects & serialize to some intermediate format (GPB, JSON, etc)
    - want to save **important** object state
2. De-serialize intermediate format into some destination format
    - want to **recover** important state
    - post-condition: each destination object in the destination is semantically identical to its corresponding source
    object.
        - Traversal-based serialization (TBS)

The intermediate format can provide independence.
- Architecutral independence: byte ordering, class member layout, address space layout
- Representational independence: intra-language or inter-language

Costs of TBS:
- In C++, per-type code must be written or generated
    - traverse source objects and render them to intermediate format
    - parse the intermediate format and reconstruct destination objects
    - this code can be come coplex and fragile
- Time: entire stream must be read end-to-end
- Space: many common intermediate formats are verbose
- Private implementation details may be exposed
- Encapsulation might be violated: intermediate format may be modified before its deserialized

Suppose I don't need architectural or representional independence
- Source and destination platforms are the same (same OS and hardware)
- Class member layout is the same on the source and dest paltforms
- i can use the same object code on the soruce and dest platofrms

I watnt to implement persistence
- that does not require per type serialization/deserialization

Idea: relocatable heaps.
- relocatable if
    - it can be serialized and de-serialized with simple binary IO
- and, afterwards the heap continues to function correctly and its contents continue to function correctly.
    - every object in this heap must be a relocatable type
        - it is serialziable by writing raw bytes and deserialzied by reading raw bytes
        - dest object of that type is semantically identical to is corresponding source object
        - Integer, floating point, standard layout types that only contain ints & floats, etc are relocatable
        - ordinary pointers are not relocatable (to objects, member functions, static member functions, etc)
        - Types with virtual functions are not relocatable (vtables may exist elsewhere)
        - File descriptors, etc are process-dependent and thus aren't relocatable

In practice:
- provide methods to initialize, serialize, and deserialize the heap
- provide methods to store and access a master object residing in the heap
- src side
    - ensure that relocatable type requirements are observedby all contents
    - construct the master object in the heap ata known address
    - allocate stuff to be persisted from the heap and acessible via master obejct
    - serialize the heap
- dest side
    - de-serialize
    - obtain access to heaps contents via master object

---

#### Addressing and allocation
Problems:
- structural management
    - addressing model
    - storage model
    - pointer interface
    - allocated strategy
- concurrency management
    - thread safety
    - transaction safety

Addressing model: policy type that implements primitive addressing operations, analogous to `void*`.
- Defines the bits used to represent an address
- How an address is computed from those bits
- How memory from the storage model is arranged
- Representations:
    - `void*`
    - fancy `void` pointer (aka synthetic pointer, pointer-like type)
- Usually closely coupled with the storage model

Storage model: policy type that manages segments.
- Interacts with external source of memory to borrow and return segments
- provides an interface to segments in terms of the addressing model
- Lowest-level of allocation
- Usually closely coupled with the addressing model
- Segment: a large region of memory that has been provided to the storage model by some external source
    - `brk(), sbrk()`
    - `VirtualAlloc(), HeapAlloc()`
    - etc

Pointer interface: policy type that wraps the addressing model to emulate a pointer to data.
- Analogous to `T*`
- Provides enough pointer syntax for containers to function
- Is convertable "in the right direction" to ordinary pointers
- Is convertable "in the right direction" to other pointer interface types
- Extends the interface of `RandomAccessIterator`
- Representations:
    - `T*`
    - Synthetic pointers

Allocation strategy: policy type that manages the process of allocating memory for clients
- requests segment allocation/deallocation from storage model
- interacts with segments in terms of the addressing model
- divides segments into chunks: region o fmemory caved out of asegment to be used by allocator's client

Thread safety: correct operation with multiple threads/processes

Transaction safety: supporting allocate/commit/rollback semantics

---

#### Framework and synthetic pointer implementation
Synthetic pointers must be equality comparable, default construction, copy construction, copy assignment, and destructors.
- Must have swappable lvalues
- default initialization may produce an indeterminate result
- value initialization produces a null result

Runtime cost with fancy pointers: the arithmetic needed to be implemented will not be as fast as that of ordinary
pointers.
- Can only static cast since it's the only cast that can invoke code.



#### Synthetic pointer performance

#### Relocatable heap examples

- `reinterpret_cast`
- SFINAE
- allocator-aware