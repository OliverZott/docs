# C++

## Stack / Heap

- `auto a = 2;` ...Since a is a local variable and no dynamic memory allocation (new or malloc) is involved, a is stored on the stack.
- Variables with automatic storage duration, such as local variables declared inside a function, are stored on the stack.

Stack:

- Fast allocation and deallocation (LIFO order).
- Limited size, typically a few MBs.
- Used for local variables, function parameters, and return addresses.
- Memory is automatically managed, with variables being destroyed when they go out of scope.

Heap:

- Managed using new/delete or malloc/free.
- Larger and more flexible memory size compared to the stack.
- Used for dynamic memory allocation where the lifetime of variables needs to be controlled manually.
- Requires manual deallocation to avoid memory leaks.

### Stack Frame Allocation / Stack Reuse

Two functions creating a copy of a local var:

```c++
void copy(int v)
{
    v *= 2;
    std::cout << "f1: " << v << std::endl;
    std::cout << "f1: " << &v << std::endl;
}

void copy_const(const int v)
{
    std::cout << "f2: " << v << std::endl;
    std::cout << "f2: " << &v << std::endl;
}

auto a = 2;
copy(a);
copy_const(a);
```

- Local variables and function parameters are typically allocated on the stack.
- When a function is called, a new **stack frame** is created, and the local variables are allocated in this frame.
- After `copy(a)` finishes execution, its stack frame is removed. When `copy_const(a)` is called, a new stack frame is created. Often, the same stack space may be reused by subsequent function calls, leading to the same address being reused for the local variable v.
- If/how tis happens is not defined by the C++ standard and can vary depending on the compiler, optimization settings, and runtime environment.
