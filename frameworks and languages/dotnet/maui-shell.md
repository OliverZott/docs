# Maui Shell

## Hierarchy

In MAUI Shell there are three main levels:

- ShellItem – top-level containers
  - Types: FlyoutItem, TabBar, or a lone ShellContent directly under Shell.
  - e.g. In AppShell, a <TabBar>, if the only ShellItem, it’s the single top-level item.
- ShellSection – sections inside a ShellItem
  - Normally created implicitly from ShellContent or explicitly via <Tab> / <ShellSection>.
  - Each of your ShellContent entries inside the TabBar becomes a ShellSection; these are what you see as bottom navbar tabs: Home, Calendar, Medication, Education.
- Pages (Navigation stack) – actual ContentPages in each section’s navigation stack.
  - So in example app:
    - Top-level ShellItem: the single <TabBar> (this is what ShellItemChanged would fire for if you ever had more than one).
    - Per-tab level (ShellSection): each ShellContent under the TabBar; these are the navbar items, and switching between them raises ShellSectionChanged.
    - Flyout MenuItem (“Help”) is not a ShellItem; it’s just a clickable menu entry that runs a command and pushes a page onto whatever section/tab is currently active.

## Example

Explain the relationship between `AppShell` and `MainPage`:

1. **AppShell Class**:
   - `AppShell` is a class that inherits from `Shell` (MAUI's navigation container)
   - It's defined in two files:
     - `AppShell.xaml` (the XAML definition)
     - `AppShell.xaml.cs` (the code-behind)
   - It's the root container for your entire app's navigation

2. **MainPage**:
   - `MainPage` is just one of the pages in your app
   - It's a child of the `AppShell`
   - It's not the same as `AppShell`

3. **The Casting**:

```csharp
var appShell = Application.Current.MainPage as AppShell;
```

This line is actually a bit confusing because of the naming. Let me explain what's happening:

- `Application.Current.MainPage` is the root page of your application
- In your app, this root page IS the `AppShell` (because you set it up that way in `App.xaml.cs`)
- So when we do `as AppShell`, we're casting the root page to its actual type

Here's the relevant code from your `App.xaml.cs` that sets this up:

```csharp
protected override Window CreateWindow(IActivationState? activationState)
{
    var appShell = serviceProvider.GetRequiredService<AppShell>();
    return new Window(appShell);
}
```

To make this clearer, let's look at the hierarchy:

```txt
Application
└── Window
    └── AppShell (root navigation container)
        ├── MainPage
        ├── SurveyPage
        ├── SettingsPage
        └── ... other pages
```

So when we do:

```csharp
var appShell = Application.Current.MainPage as AppShell;
```

We're essentially saying "get the root navigation container of our app", because in your app's setup, the `MainPage` property of the application is actually the `AppShell`.

A better way to write this might be:

```csharp
var appShell = Shell.Current as AppShell;
```

Because `Shell.Current` is specifically designed to get the current shell instance, and since your app uses `AppShell` as its shell, this would be more semantically correct.

The reason we need the `AppShell` instance is to access its `BindingContext` (which is the `AppShellViewModel`) so we can update the survey state. The `AppShell` is the container that holds all the navigation and flyout menu items, so it's the right place to update the visibility of menu items.
