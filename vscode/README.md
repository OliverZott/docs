# Task and Launch files

Minimalistic sample project showing Visual Studio Code configuration basics. Repsective JSON files are in .vscode folder.

[Link](https://www.udemy.com/course/einfuhrung-in-visual-studio-code/learn/lecture/27149020#overview)

## Launch

**launch.json** is used for to launch an app for debugging (Contains settings for things mapping to  workspace source code or defining the Chrome port to use).

To use a configuration from launch.json,  select it on the Debug panel and click the run button.

create debug file

- in debug view select: _create a launch.json file_
- customize **launch.json** same as tasks.json
- in debug view select respective debug-run from dropdown

## Tasks

**tasks.json** is used to execute anything else besides debugging/running (source code formatters, bundlers or a SASS compiler).

To use a configuration from tasks.json, select **Run Task** from the command list.

- `ctrl + shift + B`
- select: _Create Task.Json file from template_
- select: _Others_
- Additions to **tasks.json**:
  - For `ctrl+shift+B` `"group": "build"`

## Settings

For general settings use **settings.json**

### formatter

- add respective line in settings.json

### folding

- <https://code.visualstudio.com/docs/editor/codebasics#_folding>
- `ctrl + K + ctrl +1` & `ctrl + K + ctrl + J`
