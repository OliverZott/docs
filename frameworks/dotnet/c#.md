# C# basics

## Memory allocation

### Value Types

- Examples: int, float, bool, struct, enum
- Allocation: Value types are typically allocated on the stack. They hold their data directly, and their memory management is straightforward and efficient.
- Scope and Lifetime: The lifetime of value types is limited to the scope in which they are declared. They are automatically cleaned up when they go out of scope.

### Reference Types

- Examples: class, interface, delegate, array, string
- Allocation: Reference types are allocated on the heap. They hold a reference (or pointer) to the actual data rather than the data itself.
- Scope and Lifetime: Reference types are managed by the garbage collector, which automatically handles memory management. They exist until there are no more references to them.

### Stack vs. Heap

- Stack
  - Used for static memory allocation, Contains value types and local variables
  - Memory is allocated and deallocated in a last-in, first-out manner.
  - Purpose: Holds local variables, function call information, and control flow data.
  - Management: Managed automatically by the operating system, with memory allocated and deallocated in a LIFO (Last In, First Out) manner.
  - Location in RAM: Typically at a fixed, higher memory address and grows downwards towards lower memory addresses.

- Heap
  - Used for dynamic memory allocation, Contains reference types and objects that are created using the new keyword.
  - Managed by the garbage collector, which deallocates memory that is no longer referenced.
  - Purpose: Used for dynamic memory allocation (e.g., objects created with new in C++ or malloc in C).
  - Management: Managed by the programmer, with memory allocated and deallocated using specific functions or operators.
  - Location in RAM: Typically starts at a fixed lower memory address and grows upwards towards higher memory addresses.

## Language features

keywords / types / features.

- `ref struct` [ref structure types](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/builtin-types/ref-struct)
- `span` [System.Span\<T\> struct](https://learn.microsoft.com/en-us/dotnet/fundamentals/runtime-libraries/system-span%7Bt%7D)
- `lock` [lock statement](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/statements/lock)

## Version History

[What's new](https://learn.microsoft.com/en-us/dotnet/csharp/whats-new/csharp-13)

### .NET 9 / C# 13

- [params-collections](https://learn.microsoft.com/en-us/dotnet/csharp/whats-new/csharp-13#params-collections)

### .NET 8 / C# 12

### .NET 7 / C# 11

### .NET 6 / C# 10

- [console app - top-level statements](https://learn.microsoft.com/en-gb/dotnet/core/tutorials/top-level-templates)
