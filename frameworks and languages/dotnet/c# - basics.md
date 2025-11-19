# C# - Language Basics

- [Types](#types)
- [const vs readonly](#const-vs-readonly)
- [Collection Types](#collection-types)
- [keywords / types / features](#keywords--types--features)

## Types

2 Categories of types in C#:

- [Value types](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/builtin-types/value-types#built-in-value-types)
- [Reference types](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/reference-types)

**Value types** (aka primitives/structs)

- `int`, `double`, `bool`, `char`, `decimal`, `structs`, `enums`, and `Nullable<T>`.
- They live on the stack when used directly, copy their entire value when assigned/passed, and default-initialize to zeros/false. They can’t be null unless wrapped in `Nullable<T>` (e.g., `int?`).

**Reference types**

- `string`, `arrays`, `collections`, `classes`, `interfaces`, `delegates`, `records`, `object`, and `dynamic`.
- They store references to objects on the managed heap, so assignments/passing copy the reference, not the object.
- Multiple variables can point at the same instance, and they can be null.

### ValueType vs ReferenceType

- Value type assignment creates independent copies; reference type assignment shares the same object.
- Value types have deterministic memory layout and don’t require garbage collection; reference types rely on GC.
- Value types can be boxed/unboxed when treated as object; reference types already are objects.

### Arrays / Collections / respective Interfaces

**Array**

- fixed-size, contiguous block of elements (int[]), strongly typed, and provide fast indexed access.
- Arrays implement IList, IEnumerable, etc., but you rarely resize them; you’d have to allocate a new array.

**Collection**

- broader term for the types in System.Collections / System.Collections.Generic that manage groups of items with extra behaviors (dynamic sizing, hashing, ordering, queues, etc.).
- They typically wrap arrays internally but expose richer APIs.

- `List<T>`: resizable array-backed list.
- `LinkedList<T>`: doubly linked list. advantages for frequent insertions/deletions. disa
- `Queue<T>` / `Stack<T>`: FIFO / LIFO.
- `HashSet<T>` / `SortedSet<T>`: unique-element sets (hash-based vs ordered).
- `Dictionary<TKey,TValue>` / `SortedDictionary<TKey,TValue>` / `SortedList<TKey,TValue>`: key–value maps with different ordering/performance tradeoffs.

**Interfaces**

Interfaces like `IEnumerable<T>`, `ICollection<T>`, `IList<T>`, etc. describe capabilities rather than concrete storage.

- `IEnumerable<T>` means “I only need to iterate,”
- `ICollection<T>` adds count/add/remove,
- `IList<T>`  adds indexing.

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

- [Comparison of collection types](https://learn.microsoft.com/en-us/dotnet/standard/collections/#choose-a-collection)
- [System collection generics](https://learn.microsoft.com/en-us/dotnet/api/system.collections.generic?view=net-10.0)

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

### HashSet vs List

- https://stackoverflow.com/questions/150750/hashset-vs-list-performance
- [docs hashset](https://learn.microsoft.com/en-us/dotnet/fundamentals/runtime-libraries/system-collections-generic-hashset%7Bt%7D)

## keywords / types / features

- `ref struct` [ref structure types](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/builtin-types/ref-struct)
- `span` [System.Span\<T\> struct](https://learn.microsoft.com/en-us/dotnet/fundamentals/runtime-libraries/system-span%7Bt%7D)
- `lock` [lock statement](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/statements/lock)
