# The Nightmare of Initialization in C++

Early rules were a mess as they had to maintain backwards compatiblity with C.
```c++
int i1; // undefined
int i2 = 43;
int vals[] = { 1, 2, 3};
complex< double > c( 3, 4 );
int i3( 43 );
int i4 = int();
auto i5 = 4;
auto i6 { 4 }; // Creates std::initializer_list< int > in C++11
auto i7 = int{ 4 } // Creates std::initializer_list< int >
```

`auto i{ 4 }`, in C++11, this creates an initializer list of type int. Fixed in C++14.
`auto i = { 4 }`, in all standards, will create an initialzer list type int.
    - An `=` with auto may change the type of the data
    - Avoid `auto = {}` pattern when initializing

If you don't care about the type, `auto x = initializer` is fine; otherwise use `auto x = type{ expr }`.

Now `prvalue` and `glvalue` and `xvalue` are part of the C++ value model, in addition to `lvalue` and `rvalue`.

Auto decays:
```c++
int i = 42;
const int& r = i; // r has type const
auto v = r; // v has type int and is a new object
```


Use `{}` as the uniform way to initialize everything.
```c++
int i { 44 };
int i {};
int i = {};
```

Never use `()` to initialize.

Curlies disable implicit narrowing: converting floating-point to integral values, or unsigned to signed, for example.
- `unsigned foo { -17 }` will throw an error, if `--pedantic-errors` flag is set on compiler.
- `char c1 { c + 1 }` will throw an error as well, because a char plus an int will always result in an int.
- `{}` used to create initializer lists; `P( initializer_list< int > )` will allow initialization via
```c++
P foo { 1, 2, 3 };
P foo { 1 };
```
etc

---

- Elision