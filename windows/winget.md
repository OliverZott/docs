# Winget commands

- `winget list` e.g. `winget list | findstr Power`
- `winget upgrade` ...show list of upgradable software
- `winget upgrade --all` ...upgrade all software
- `winget search <appname>` ...search software to install in internet
  - e.g. `winget search Microsoft.PowerShell`
- `winget install --id <appname> --source winget --force`

e.g.

- `winget install Microsoft.PowerToys --source winget`
