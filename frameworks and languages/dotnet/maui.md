# MAUI

## Emulator settings

- `adb -s emulator-5554 shell settings put global anr_show_background 0`
- `adb -s emulator-5554 shell setprop debug.anr.timeout_multiplier 100`

- `adb -s emulator-5554 shell settings put global anr_show_background 0` ...Disable ANR dialog for background apps
- `adb -s emulator-5554 shell setprop debug.anr.timeout_multiplier 100`   ... Increase ANR timeout threshold (100x) so debugger pauses don't trigger ANRs
- `adb -s emulator-5554 shell settings put global hide_error_dialogs 1` ...Suppress all crash/ANR error dialogs globally (useful for CI/automation too)
- `adb -s emulator-5554 shell settings put global wait_for_debugger 0`  ...Disable "Waiting for debugger" launch block (if Developer Options > Wait for debugger was set)
- `adb -s emulator-5554 shell settings put global debug_app ''`

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

## MAUI remarks

### Lifecycle

[builds](https://devblogs.microsoft.com/dotnet/a-deep-dive-into-how-net-builds-and-ships/?form=MG0AV3)
[lifecycle](https://dev.to/kcrnac/net-execution-process-explained-c-1b7a?form=MG0AV3)
[lifecycle](https://learn.microsoft.com/en-us/dotnet/maui/fundamentals/app-lifecycle?view=net-maui-9.0)

## Under the hood (Android)

### Is a MAUI app "native"?

- **UI + packaging: yes** ...normal APK, entry point is a regular Android activity (`MainActivity`), controls become real Android views (`Label` → `TextView`, `Button` → Android button)
- **C# logic: no** ...Android only runs Java/Kotlin bytecode or native machine code, not C#
  - so the **.NET runtime ships inside every APK** (nothing has to be installed on the phone)
  - start: Android starts `MainActivity` → loads the bundled .NET runtime → runs your C# (IL) → creates Android views via the Java ↔ .NET bridge
  - consequence: bigger APK (~8 MB just for the runtime) and slightly slower startup than a Kotlin app

What's inside a release APK (`unzip -l app-Signed.apk`, example net11 / arm64):

| File (`lib/arm64-v8a/`) | What it is |
|---|---|
| `libcoreclr.so` | the .NET runtime (net11 uses CoreCLR on Android) |
| `libclrjit.so` | JIT, compiles IL to ARM machine code at runtime |
| `libassembly-store.so` | all .NET DLLs (own code, MAUI, NuGet packages) packed into one file |
| `libe_sqlite3.so` | native libs from NuGet packages, e.g. SQLite |
| `libmonodroid.so` | bridge between Android/Java and .NET |

### RuntimeIdentifiers (RID)

- C# is compiled **once** to IL (CPU independent)
- the **native parts** (runtime, JIT, native NuGet libs) are built **once per RID** → one folder per CPU type in the APK
  - `android-arm64` → `lib/arm64-v8a/` ...practically all real phones
  - `android-x64` → `lib/x86_64/` ...mainly emulators on a PC
- on install, Android picks the folder matching the phone's CPU, the rest is dead weight
- default builds both `android-arm64` + `android-x64`
- if the app is only sideloaded to a real phone, limit release builds to arm64 (example: APK 27.0 MB → 15.4 MB):

```xml
<PropertyGroup Condition="'$(Configuration)|$(TargetFramework)'=='Release|net11.0-android'">
    <RuntimeIdentifiers>android-arm64</RuntimeIdentifiers>
</PropertyGroup>
```

- such an APK won't install on an x64 emulator → keep Debug builds multi-RID
- not needed for Play Store: an AAB is split per CPU by Google Play anyway

### Images: SVG → PNG (Resizetizer)

- Android/iOS can't show SVG in an `Image` → at **build time** MAUI's *Resizetizer* converts every `MauiImage` SVG into PNGs, one per screen density (mdpi 1× … xxxhdpi 4×)
- only the PNGs go into the APK, the SVG is not shipped; `Source="weight"` loads `weight.png`
- see them in `obj/Debug/net11.0-android/resizetizer/r/drawable-*/`
- the **base size** in dp comes from the SVG's `width`/`height` (or `viewBox` if missing)
  - pitfall: `width="512pt"` or `viewBox="0 0 1000 1000"` → 2732 px / 4000 px PNGs for an icon shown at 44dp (≈ 64 MB RAM when decoded)
  - fix: set `BaseSize` to the display size in the csproj (SVG stays untouched):

```xml
<MauiImage Include="Resources\Images\*" />
<MauiImage Update="Resources\Images\dino.svg" BaseSize="24,24" />
<MauiImage Update="Resources\Images\weight.svg" BaseSize="48,48" />
```

## Basic structure

- `App.xaml` used to define shared resources like styles and themes for your application (defined in Resource folder)
- `App.xaml.cs` code-behind file, containing the logic for application-level events and initialization. Represents your application at runtime. Include OnStart, OnResume, and OnSleep event handlers.

- `AppShell.xaml` defines the navigation structure of the app, including styling, URI based navigation, and options for layout, including flyout navigation and tabs for the application's root
- `AppShell.xaml.cs` code-behind file, handling navigation logic

- `MainPage.xaml` main user interface file where you define the layout and UI elements.
- `MainPage.xaml.cs` code-behind file, containing the logic for user interactions and UI updates
- `MainPageViewModel.cs` view model for the main page

- `MauiProgram.cs`  file to configure services, middleware, and other app-level settings. It’s similar to the Startup.cs file in ASP.NET Core and  entry point for the application. All platform-specific code calls the CreateMauiApp method of the static MauiProgram class in the end! You also register your services to **IoC/DI container** here `builder.Services.AddSingleton<IMyService, MyService>();`

At runtime, the app starts up in a platform-specific way and when initialization is complete, the platform-specific code calls the `MauiProgram.CreateMauiApp` method, which then creates and runs the `App` object

- `csproj`
  - `PropertyGroup` specifies the platform frameworks that the project targets, and items such as the application title, ID, version, display version, and supported operating systems.
  - `ItemGroup` specifies an image and color for the splash screen that appears while the app is loading, before the first window appears. You can also set the default locations for the fonts, images, and assets the app uses.

## Basic concept

### Shell

...the app's visual hierarchy is described in a class that subclasses the Shell class. This class can consist of three main hierarchical objects:

- `FlyoutItem` or `TabBar`
- `Tab` grouped content, navigable by bottom tabs
- `ShellContent` ContentPage objects for each tab

### Pages

...the root of the UI hierarchy in .NET MAUI inside of a Shell (e.g. class `MainPage`)

- `ContentPage` simplest and most common page type, simply displays its contents
- `TabbedPage` root page used for tab navigation. A tabbed page contains child page objects; one for each tab
- `FlyoutPage` contains a list of items. When you select an item, a view displaying the details for that item appears (master/detail style presentation)

### Views

A content page typically displays a view. A view enables you to retrieve and present data in a specific manner.

- `ContentView` default view for a content page, which displays items as-is
- `ScrollView` display items in a scrolling window
- `CarouselView` swipe through a collections
- `CollectionView` can retrieve data from a named data source and present each item using a template as a format

### Layouts and Controls

A view can contain a single control such as a **button**, **label**, or **text boxes** (views itself are controls)  

Controls are positioned in a layout. A layout defines the rules by which the controls are displayed relative to each other (layouts are also controls, sp you can add it to view).

- `StackLayout` as `HorizontalStackLayout` or `VerticalStackLayout`
- `AbsoluteLayout` exact coordinates for controls
- `FlexLayout` enables you to wrap the child controls it contains if they don't fit in a single row or column
- `Grid`

### Simple Porject structure

```txt
MyApp/
│
├── App.xaml
├── App.xaml.cs
├── MainPage.xaml
├── MainPage.xaml.cs
│
├── Views/
│   ├── Pages/
│   │   ├── HomePage.xaml
│   │   ├── HomePage.xaml.cs
│   │   ├── SettingsPage.xaml
│   │   ├── SettingsPage.xaml.cs
│   │
│   ├── Controls/
│       ├── CustomButton.xaml
│       ├── CustomButton.xaml.cs
│
├── ViewModels/
│   ├── HomeViewModel.cs
│   ├── SettingsViewModel.cs
│
├── Models/
│   ├── UserModel.cs
│   ├── SettingsModel.cs
│
├── Services/
│   ├── ApiService.cs
│   ├── LocalStorageService.cs
│
├── Helpers/
│   ├── NavigationHelper.cs
│   ├── FileHelper.cs
│
└── Resources/
    ├── Styles/
    │   ├── Styles.xaml
    ├── Images/
    │   ├── logo.png
    ├── Fonts/
        ├── customfont.ttf
```

- **Root** Folder
  - App.xaml / App.xaml.cs: Main application class
  - MainPage.xaml / MainPage.xaml.cs: Main page of the app.
- **Views**: Contains XAML files for UI components
  - Pages: For full pages
    - HomePage.xaml / HomePage.xaml.
    - SettingsPage.xaml / SettingsPage.xaml.cs
- **Controls**: For reusable UI components.
  - CustomButton.xaml / CustomButton.xaml.cs
- **ViewModels**: Contains ViewModel classes for MVVM pattern.
  - HomeViewModel.cs
  - SettingsViewModel.cs
- **Models**: Contains data model classes.
  - UserModel.cs
  - SettingsModel.cs
- **Services**: Contains service classes for data access, APIs, etc
  - ApiService.cs
  - LocalStorageService.cs
- **Helpers**: Contains helper classes and utilities.
  - NavigationHelper.
  - FileHelper.cs
- **Resources**: Contains application resources like styles, templates, images, etc
  - Styles
    - Styles.xaml
  - Images
    - logo.png
  - Fonts
    - customfont.ttf
