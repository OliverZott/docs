# Knowledgebase

## .NET

### Assemblies, artifacts, and packages

In .NET and Azure Pipelines, **assemblies** are the output of the build process that contains compiled code and other resources that are required by the application at runtime. They are typically DLLs or EXEs. On the other hand, **artifacts** are files that are produced by a build and are used for deployment purposes. Artifacts can include assemblies, but they can also include other files such as configuration files, scripts, and documentation².

The outcome of a pipeline build is called a **build artifact**. It is a collection of files that were produced by the build process and can be used for deployment purposes².

I hope this helps! Let me know if you have any more questions.

Source: Conversation with Bing, 03/08/2023
(1) Artifacts in Azure Pipelines - Azure Pipelines | Microsoft Learn. <https://learn.microsoft.com/en-us/azure/devops/pipelines/artifacts/artifacts-overview?view=azure-devops>.
(2) Build, test, and deploy .NET Core apps - Azure Pipelines. <https://learn.microsoft.com/en-us/azure/devops/pipelines/ecosystems/dotnet-core?view=azure-devops>.
(3) Azure Artifacts vs Build Artifacts vs Pipeline Artifacts: Difference .... <https://dev.to/n3wt0n/azure-artifacts-vs-build-artifacts-vs-pipeline-artifacts-difference-explained-1k24>.

In .NET and Azure Pipelines, **NuGet packages** are considered **artifacts**. You can use Azure Pipelines to publish your NuGet packages within your pipeline, to your Azure Artifacts feed, or to public registries such as nuget.org¹.

I hope this helps! Let me know if you have any more questions.

Source: Conversation with Bing, 03/08/2023
(1) Publish NuGet packages with Azure Pipelines (YAML/Classic). <https://learn.microsoft.com/en-us/azure/devops/pipelines/artifacts/nuget?view=azure-devops>.
(2) Get started with NuGet packages in Azure Artifacts. <https://learn.microsoft.com/en-us/azure/devops/artifacts/get-started-nuget?view=azure-devops>.
(3) NuGetCommand@2 - NuGet v2 task | Microsoft Learn. <https://learn.microsoft.com/en-us/azure/devops/pipelines/tasks/reference/nuget-command-v2?view=azure-pipelines>.
