# C# - More advanced concepts and features

## Memory allocation

### Value Types

- Examples: int, float, bool, struct, enum
- Allocation: Value types are typically allocated on the **stack**. They hold their data directly, and their memory management is straightforward and efficient.
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
  - Hardware: The stack is tied closely to the CPU's stack pointer register, which keeps track of where the current stack frame begins. This proximity to the CPU allows for incredibly fast allocations and deallocations.
  - Location in RAM: Typically at a fixed, higher memory address and grows downwards towards lower memory addresses.

- Heap
  - Region  of memory used for dynamic memory allocation, Contains reference type variables and objects that are created using the new keyword.
  - Managed by the garbage collector, which deallocates memory that is no longer referenced.
  - Purpose: Used for dynamic memory allocation (e.g., objects created with new in C++ or malloc in C).
  - Management: Managed by the garbage collector or programmer, with memory allocated and deallocated using specific functions or operators.
  - Hardware: Heap memory generally resides in DRAM (Dynamic RAM), which offers more capacity but slower access speed compared to SRAM and is manged by **memory management unit** (MMU) of the CPU and may involve paging mechanisms.
  - Location in RAM: Typically starts at a fixed lower memory address and grows upwards towards higher memory addresses.

## Version History

[What's new](https://learn.microsoft.com/en-us/dotnet/csharp/whats-new/csharp-13)

### .NET 9 / C# 13

- [params-collections](https://learn.microsoft.com/en-us/dotnet/csharp/whats-new/csharp-13#params-collections)

### .NET 8 / C# 12

### .NET 7 / C# 11

### .NET 6 / C# 10

- [console app - top-level statements](https://learn.microsoft.com/en-gb/dotnet/core/tutorials/top-level-templates)
