# .NET Knowledgebase

## Assemblies, artifacts, and packages

In .NET and Azure Pipelines, **assemblies** are the output of the build process that contains compiled code and other resources that are required by the application at runtime. They are typically DLLs or EXEs. On the other hand, **artifacts** are files that are produced by a build and are used for deployment purposes. Artifacts can include assemblies, but they can also include other files such as configuration files, scripts, and documentation².

The outcome of a pipeline build is called a **build artifact**. It is a collection of files that were produced by the build process and can be used for deployment purposes².

Source: Conversation with Bing, 03/08/2023
(1) Artifacts in Azure Pipelines - Azure Pipelines | Microsoft Learn. <https://learn.microsoft.com/en-us/azure/devops/pipelines/artifacts/artifacts-overview?view=azure-devops>.
(2) Build, test, and deploy .NET Core apps - Azure Pipelines. <https://learn.microsoft.com/en-us/azure/devops/pipelines/ecosystems/dotnet-core?view=azure-devops>.
(3) Azure Artifacts vs Build Artifacts vs Pipeline Artifacts: Difference .... <https://dev.to/n3wt0n/azure-artifacts-vs-build-artifacts-vs-pipeline-artifacts-difference-explained-1k24>.

---

In .NET and Azure Pipelines, **NuGet packages** are considered **artifacts**. You can use Azure Pipelines to publish your NuGet packages within your pipeline, to your Azure Artifacts feed, or to public registries such as nuget.org¹.

I hope this helps! Let me know if you have any more questions.

Source: Conversation with Bing, 03/08/2023
(1) Publish NuGet packages with Azure Pipelines (YAML/Classic). <https://learn.microsoft.com/en-us/azure/devops/pipelines/artifacts/nuget?view=azure-devops>.
(2) Get started with NuGet packages in Azure Artifacts. <https://learn.microsoft.com/en-us/azure/devops/artifacts/get-started-nuget?view=azure-devops>.
(3) NuGetCommand@2 - NuGet v2 task | Microsoft Learn. <https://learn.microsoft.com/en-us/azure/devops/pipelines/tasks/reference/nuget-command-v2?view=azure-pipelines>.

## Async

<https://github.com/davidfowl/AspNetCoreDiagnosticScenarios/blob/master/AsyncGuidance.md>

In C#, the **await** keyword is used to suspend the execution of a method until the awaited task completes. The method in which await is used must be modified with the **async** keyword. The key benefit of using **await** is that it does not block the calling thread while the task is running. Instead, the control is returned to the caller, and the method is resumed when the task completes. This allows for more efficient use of resources and can help improve the responsiveness of your application.

It’s important to note that **await** does not create a new thread or block the current thread. Instead, it uses a state machine to keep track of where it left off and resume execution when the awaited task completes. This allows for asynchronous code to be written in a way that looks similar to synchronous code, making it easier to read and understand.

In summary, **await** allows you to write asynchronous code that is more efficient and responsive, without blocking the calling thread or creating new threads. It’s a powerful tool for writing modern, scalable applications.

- `State Machine`: C# uses a compiler-generated state machine to handle the state and execution flow of asynchronous methods, enabling them to pause and resume at await points.
- `Multi-Threading`: While not all async operations involve multiple threads, C# can use thread pools to manage asynchronous tasks, especially for CPU-bound operations.
- `Task-Based`: C#'s async/await pattern is built on the Task Parallel Library (TPL). await works with Task and Task<T>, pausing the method until the task completes.
- `Synchronization Context`: In GUI applications, C# maintains a synchronization context to ensure that async methods resume on the UI thread, preventing cross-threading issues.
- `Explicit Control`: C# offers more explicit control over asynchronous operations and concurrency, allowing for more complex task coordination and resource management.

Thread Pool:

- **Purpose**: The thread pool is a collection of worker threads managed by the .NET runtime. It is designed to handle a large number of short-lived tasks efficiently.
- **Reuse**: Instead of creating a new thread for each task, the thread pool reuses existing threads, reducing the overhead associated with thread creation and destruction.
- **Management**: The .NET runtime dynamically manages the size of the thread pool based on the workload and system resources.
- The thread pool has a limited number of threads. If all threads are busy, new tasks are queued until a thread becomes available.
- Causes of Exhaustion
  - Long-running synchronous operations within asynchronous methods can block threads, reducing the number of available threads for other tasks.
  - A high volume of asynchronous tasks, especially those waiting on I/O operations, can quickly deplete the thread pool if not managed properly.
- When thread pool exhaustion occurs, tasks are delayed, leading to increased latency and reduced responsiveness of the application.
- If the exhaustion is severe, it can cause timeouts and failures in task execution.

Summary:
- JavaScript: Utilizes a single-threaded event loop for non-blocking I/O and promise-based async/await.
- C#: Leverages compiler-generated state machines and can involve multi-threading for efficient task management and concurrency.

### State Machine vs. Thread Pool

- State Machine:
  - Purpose: The state machine is used to manage the state and execution flow of the asynchronous method.
  - When Used: Every time you use async and await in a method, the compiler generates a state machine to handle the method’s asynchronous execution.
  - Function: It allows the method to pause at await points and resume once the awaited task is complete, without blocking the main thread.

- Thread Pool:
  - Purpose: The thread pool provides a pool of reusable threads to execute tasks, especially CPU-bound tasks that might need parallel execution.
  - When Used: The thread pool is used when you perform operations that need to run on separate threads, particularly CPU-bound tasks using methods like `Task.Run`.
  - Function: It handles background tasks and operations that would otherwise block the main thread.


### Example 

I/O-Bound Operations (State Machine):  
These operations often involve awaiting tasks that don’t require additional threads because they’re waiting on I/O operations like network requests.

```c#
public async Task<string> GetDataAsync(string url)
{
    HttpClient client = new HttpClient();
    // This await uses the state machine to handle the async operation
    string data = await client.GetStringAsync(url);
    return data;
}
```

CPU-Bound Operations (Thread Pool):  
For CPU-bound tasks, you often use Task.Run to explicitly run the task on a thread pool thread.

```c#
public async Task<int> ComputeAsync(int input)
{
    // This await uses the thread pool to handle the CPU-bound operation
    int result = await Task.Run(() => HeavyComputation(input));
    return result;
}

private int HeavyComputation(int input)
{
    // Simulate a CPU-bound operation
    return input * input;
}
```


### asny Task vs async void

#### async Task

- Usage: Preferred for most async methods, particularly those that are called directly and can be awaited.
- Behavior:
  - Awaitable: Methods that return Task can be awaited. This allows the caller to wait for the method to complete and handle the result or any exceptions.
  - Exception Handling: Exceptions thrown in async Task methods can be caught and handled by the caller.
  - Chainable: Task methods can be part of asynchronous workflows, where you can chain await calls.
- Example: Ideal for most async methods where you want to perform asynchronous operations and handle the results or exceptions. Methods that perform I/O operations, network calls, or any async operations that need to be awaited.

#### async void

- Usage: Mostly used for event handlers.

- Behavior:
  - Non-Awaitable: Methods that return void cannot be awaited. This means that the caller cannot wait for the method to complete, and any exceptions thrown inside the method won't be caught by the caller.
  - **Fire-and-Forget**: Since they don't return a Task, these methods are essentially "fire and forget", meaning the caller starts the method and doesn't wait for it to finish.
  - Exception Handling: Exceptions thrown in async void methods must be handled within the method itself. If not, they result in application-level unhandled exceptions.
- Example: Button click events, UI events. Commonly used in event handlers where the method signature must be void.

---

## Middleware

- IMiddleware Interface in Middleware ??
- Register to middleware pipeline with app.UseMiddleware

- [docs](https://learn.microsoft.com/en-us/aspnet/core/fundamentals/middleware/?view=aspnetcore-9.0)
- [youtube](https://www.youtube.com/watch?v=utt-5J9PN3Q&list=PLUOequmGnXxMlnHs9EQzOpLxVeEDw7uQn)

## Logging

### Serilog & OpenTelemetry &  Seq

- Structured logging
- [youtube](https://www.youtube.com/watch?v=MHJ0BHfWhRw)
- maybe try **Grafana Loki** as aggregation system [loki](https://grafana.com/oss/loki/)
