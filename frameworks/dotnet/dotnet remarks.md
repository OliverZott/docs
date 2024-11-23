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

### asny Task vs async avoid

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

- [youtube](https://www.youtube.com/watch?v=MHJ0BHfWhRw)
- maybe try **Grafana Loki** as aggregation system [loki](https://grafana.com/oss/loki/)
