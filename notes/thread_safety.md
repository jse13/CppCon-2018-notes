# What Do You Mean, "Thread Safe?"

Thread-safe functions my not actually be safe with certain inputs.

API race: when program performs two concurrent actions on an object, when that object's API doesn't permit those operations to be concurrent.
- Technically different from data races


-Thread safe object: live object can't be the site for an API race.
- Thread compatible object: live object can't be the site for an API race, *if it's not being mutated.*
- Thread hostile object: can cause API races at sites other  than their inputs.

---

- Reentrancy