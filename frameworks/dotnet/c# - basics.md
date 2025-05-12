# C# - Language Basics

- [const vs readonly](#const-vs-readonly)
- [Collection Types](#collection-types)
- [keywords / types / features](#keywords--types--features)

## const vs readonly

### `const`

- Definition: A `const` field is a compile-time constant, meaning its value is determined at compile time and cannot change thereafter.
- Must be initialized at declaration `public const int MaxValue = 100;`
- Its value is **baked into the code** wherever it is used (literal replacement at compile time).
- Implicitly `static`, so you don't need to declare it as `static`.
- Can only have **primitive types**, `enum` values, or `string` as its type.
- Usage: When you need a value that remains **constant forever**, such as mathematical constants (`Pi = 3.14`) or app-wide configurations (`DefaultTimeoutSeconds = 30`), constants that don't depend on runtime data

### `readonly`

- **Definition: A `readonly` field is a runtime constant, meaning it can be assigned at declaration or in the constructor, but once assigned, it cannot be modified.
- `public readonly int InitialValue;`
- Can be initialized in **two places**:
   1. At declaration: `public readonly int Value = 10;`
   2. Inside the constructor: `Value = 20;`.
- Lifecycle:
   1. persists for **Instance lifecycle**
   2. If `static readonly` it persists for **application lifecycle**
- Unlike `const`, it supports **non-primitive types** such as objects or arrays.
- Its value can differ between instances of the class since it is assigned during object construction.
- Usage: When you need **per-instance immutability**, such as configuration values determined at runtime (e.g., based on constructor parameters or configuration files - `readonly string ConfigPath`) or dependency-injected fields.  When immutability is needed for instance-level or runtime scenarios.

| Feature               | `const`                   | `readonly`                  |
|-----------------------|---------------------------|-----------------------------|
| **Assignment**         | At declaration only       | At declaration or constructor |
| **Mutability**         | Completely immutable      | Immutable after assignment    |
| **Type Support**       | Primitive and strings only| Any type, including objects  |
| **Scope**              | Implicitly `static`       | Instance or static           |
| **Compile-Time/Runtime**| Compile-time constant     | Runtime constant             |

## Collection Types

| **Type**       | **Allocations**   | **Resizing**   | **Async Support** | **Use Cases**                               |
|-----------------|-------------------|----------------|-------------------|---------------------------------------------|
| `Span<T>`       | Stack-only        | No             | No                | High-performance slicing, buffers.          |
| Array (`T[]`)   | Heap              | No             | Yes               | Fixed-size, static collections.             |
| `List<T>`       | Heap              | Yes            | Yes               | Dynamic collections, frequent modifications.|
| `Memory<T>`     | Heap              | No             | Yes               | Async data processing, persistent slices.   |

- **`Span<T>`**: Lightweight, high performance, but limited to stack memory.
- **Array**: Simple and fast, but fixed in size.
- **`List<T>`**: Dynamic and versatile, though with higher memory overhead.
- **`Memory<T>`**: Ideal for async and long-lived operations but slower than `Span<T>`.

Choose the right type based on your application's **performance**, **size**, and **lifetime requirements**.

## keywords / types / features

- `ref struct` [ref structure types](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/builtin-types/ref-struct)
- `span` [System.Span\<T\> struct](https://learn.microsoft.com/en-us/dotnet/fundamentals/runtime-libraries/system-span%7Bt%7D)
- `lock` [lock statement](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/statements/lock)
