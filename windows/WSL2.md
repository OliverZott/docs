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
# Start linux shell
wsl
sudo apt update && sudo apt upgrade -y
sudo apt autoclean && sudo apt autoremove -y

# Show installed distros
wsl -l -v

# Show available distros
wsl --list --online
wsl --install -d <DistroName>
wsl --unregister <DistroName>

# Update WSL
wsl.exe --update 

# Set default distribution
wsl --setdefault ubuntu
```
