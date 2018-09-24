# The C++ Execution Model

**Lecture pretends that std::memory::order_consume doesn't exist, and applies to C++17 onward.**

## The Abstract Machine
A portable eabstraction of the OS, kernel, and hardware - the boundary between the portable C++ code and the hardware
itself.
- Portable code is written against the abstract machine.
- C++ code describes the operations that are performed on the abstract machine.
- Storage model is flat: no notion of hierarchy.
    - Some objects may not have a unique memory location or address (C++20).
    - An object cannot have more than one storage location.
- In C++, every thread can potentially access every function or variable in a program.
    - Thread of execution is a single flow of control in a program which evaluates a function call; threads may run
    concurrently.
    - Variaubles with static storage duration are initialized as a consequence of program initialization; variables with
    thread storage duration are initialized as a consequence of thread execution.
- Expression: sequence of operations and operands that specifies a computation.
    - Full expressions: top-level expressions; everything else is a sub-expression.
        - A deconstruction would be a full expression
        - Full expressions may include subexpressions that are not lexially part of the full expression.
        - Every full expression is sequenced relative to the other full expressions in a program.
- An expression has side-effects if it modifies the environment in some way (such as modifying the value of a variable).
    - The completion of a computation **does not imply that the computation of its side effects are completed**.
- Some expression A is sequenced before B: A is computed first, then B
    - A and B are indeterminately sequenced: either A runs first or B runs first, but they are not interleaved.
    - They are unseuquenced if A or B may execute first, and they may be interleaved.
    - `std::execution::seq` gives the compiler special permission to interleave user-defined expressions.

## Function Evaluation
When a function is called, every evaluation in the body of the function, and any function outside the body of the function,
are **indeterminately sequenced**. The expression designating the function is sequenced before the argument expressions.
New in C++17: argument expressions for a function are indeterminately sequenced.

`synchronizes with`: everything that happens in a thread prior to some execution is obserable to some other thread.
    - All mutex locks synchronize with all future mutex locks.

Given any two evaluations A and B...
- If A **happens before** B, either
    - A is sequenced before B, or
    - A synchronizes with B, or
    - for some evaluation X, A happens before X and X happens before B.
**Happens before** describes arbitrary concatenations of sequenced before and synchronizes with.

Forward progress guarantees that something observable should evenually happen.