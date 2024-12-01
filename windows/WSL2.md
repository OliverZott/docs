# WSL2

- <https://docs.microsoft.com/en-us/windows/wsl/install>

- `Turn Windows Features OnOff`
  - *Virtual Machine Platform*
  - *Windows Subsystem For Linux*
- Kernel Update
  - <https://docs.microsoft.com/en-us/windows/wsl/install-manual#step-4---download-the-linux-kernel-update-package>
- `Install distribution`
  - via Store or Terminal:

```bash
`wsl -l -v`
`wsl --list --online`
`wsl --install -d <DistroName>`
`wsl --unregister <DistroName>`
`wsl -l -v`
`wsl.exe --update` 
```
