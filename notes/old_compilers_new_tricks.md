# Teaching Old Compilers New Tricks
## Transpiling C++17 to C++11

**Check out slides for Tony tables on new C++17 features**

---

### Clang-from-the-future
- Preprocessor for a proper compiler
- C++17 ➡ C++11
- CFTF works as a black-box precompilation step

#### Components
- CLI
    - `cftf <filename> -frontend-compiler=/path/to/compiler`
