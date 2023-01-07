# Shell Basics

## windows powershell

- `$env:tmp`
- `gci env:`
- `dir env:appdata`
- `setx ENV_VAR env_var_value`  ... set env var
- `[Environment]::SetEnvironmentVariable("TEST", $null ,"User")`  ... delete env var [link](https://www.digitalcitizen.life/remove-edit-clear-environment-variables/)

- [env vars docu](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_environment_variables?view=powershell-7.2)
- [computer information](https://learn.microsoft.com/en-us/powershell/scripting/samples/collecting-information-about-computers?view=powershell-7.2)
  - `Get-CimInstance -ClassName Win32_PhysicalMemory`
  - `Get-CimInstance -ClassName Win32_Processor`

## linux bash shell

- [computer information](https://www.tecmint.com/commands-to-collect-system-and-hardware-information-in-linux/#:~:text=1.,kernel%20name%20of%20your%20system.&text=To%20view%20your%20network%20hostname,the%20uname%20command%20as%20shown.)
- [memory usage](https://phoenixnap.com/kb/linux-commands-check-memory-usage#:~:text=Checking%20Memory%20Usage%20in%20Linux%20using%20the%20GUI,-Using%20a%20graphical&text=Navigate%20to%20Show%20Applications.,including%20historical%20information%20is%20displayed.)
- [memory info](https://www.cyberciti.biz/faq/linux-ram-info-command/)
- `sudo lshw -html > hardwareinfo.html` ... create file with infos
- `sudo lshw` or `sudo lshw -short` ... computer information
- `lscpu` ... cpu information
- `sudo dmidecode -t processor` ... processor information
- `sudo dmidecode -t memory` ... memory information
- `sudo dmidecode -t bios` ... BIOS information
