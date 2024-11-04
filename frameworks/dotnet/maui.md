# MAUI

## Versions

### dotnet

- `dotnet sdk check`
- [dotnet maui version dependencies](https://github.com/dotnet/maui/wiki/Release-Versions)
- [dotnet android releas notes](https://github.com/dotnet/android/releases)
- [dotnet ios releas notes](https://github.com/xamarin/xamarin-macios/releases/tag/dotnet-9.0.1xx-rc2-9600)

### workloads

- [dotnet workload](https://learn.microsoft.com/en-us/dotnet/core/tools/dotnet-workload-sets)
  - `dotnet workload --help`
  - `dotnet workload --info`
  - `dotnet workload list`

  - Pin projects to specific workloadVersions, via configuration in  `global.json`
  - [global.json usage](https://learn.microsoft.com/en-us/dotnet/core/tools/dotnet-workload-sets#use-globaljson-for-the-workload-set-version)

### Multiframework

- Multi-Framework targetting:
  - `<TargetFrameworks>net9.0-ios17.0;net9.0-ios17.2</TargetFrameworks>`

## .NET 9 MAUI

- Workloads
- Multi Framework targetting
- Android Asset Packs
