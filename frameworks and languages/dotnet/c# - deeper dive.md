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

## Compilation

- The .NET compiler (**Roslyn**) compiles source code into Intermediate Language (**IL**).

### JIT (Just-In-Time)

- The **IL** is stored in an **assembly** (DLL or EXE).
- At **runtime**
  - The **CLR** loads these compiled assemblies containing IL code and calls JIT compiler.
  - The **JIT**  compiler translates IL into **native machine code**.
- Caching and optimization
  - The native code is cached per process, but may not persist beyond execution (unlike AOT, which produces a persistent native binary).
  - JIT does optimizations dynamically, depending on runtime conditions.
  - JIT optimizes **per execution** (while AOT optimizes once at compile time).

#### Execution

- The CPU executes the native machine code directly.
- The CLR manages memory, garbage collection, and security.

#### Difference JIT - Interpreter

- Interpreted languages (like Python, JavaScript) execute directly from source- or bytecode using an interpreter, while JIT compiles IL first into native code
- JIT compilation converts IL into native machine code **before execution**, making it faster than interpretation.

#### CLR

The CLR is the core **execution engine** within the .NET runtime that handles:

- JIT compilation (if not using AOT)
- Garbage collection
- Memory management
- Exception handling
- Security enforcement

### AOT (Ahead-Of-Time)

- At **buildtime**, the **AOT** compiler (e.g Native AOT in .NET 9) translates IL into **native machine code** (**before deployment**, compared to JIT).
  - AOT optimizes once at compile time
  - ... removes unused code (through tree-shaking) for efficiency

- Final output/result is a **self-contained platform-specific native executable** that does not require the .NET runtime (**CLR**) to execute.

#### Execution

- The CPU runs the precompiled native machine code without CLR/JIT.

### Use Cases

- Use JIT
  - for runtime optimizations (e.g., long-running applications).
  - forcross-platform flexibility (same IL runs on different architectures).
  - if rely on dynamic code generation.
- Use AOT
  - for fast startup (e.g., microservices, cloud functions).
  - for lower memory usage (e.g., embedded systems).
  - for deploying to restricted environments where JIT is not allowed.

### Links

- [github - roslyn](https://github.com/dotnet/roslyn)  
- [docs - compiler](https://learn.microsoft.com/en-us/dotnet/csharp/roslyn-sdk/compiler-api-model)
- [rider - decompile/open assemblies](https://www.jetbrains.com/help/rider/Opening_Assembly_Files.html)

## Version History

[What's new](https://learn.microsoft.com/en-us/dotnet/csharp/whats-new/csharp-13)

### .NET 9 / C# 13

- [params-collections](https://learn.microsoft.com/en-us/dotnet/csharp/whats-new/csharp-13#params-collections)

### .NET 8 / C# 12

### .NET 7 / C# 11

### .NET 6 / C# 10

- [console app - top-level statements](https://learn.microsoft.com/en-gb/dotnet/core/tutorials/top-level-templates)
