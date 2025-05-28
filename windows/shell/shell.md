# Shell Basics

## windows powershell

PowerShell is different from both Bash and Zsh because it is designed to interact with .NET structures natively in Windows. This means that it can pipe objects and data between scripts, applications, and sessions. Each object in PowerShell has its own series of properties, which makes the data handling within PowerShell even more granular.

## Commands

### ENV vars

- `$env:tmp`
- `gci env:`
- `gci env: | Select-String "java_"`
- `dir env:appdata`
- `setx ENV_VAR env_var_value`  ... set env var
- `[Environment]::SetEnvironmentVariable("TEST", $null ,"User")`  ... delete env var [link](https://www.digitalcitizen.life/remove-edit-clear-environment-variables/)

- [env vars docu](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_environment_variables?view=powershell-7.2)
- [computer information](https://learn.microsoft.com/en-us/powershell/scripting/samples/collecting-information-about-computers?view=powershell-7.2)
  - `Get-CimInstance -ClassName Win32_PhysicalMemory`
  - `Get-CimInstance -ClassName Win32_Processor`

### Basics

<https://www.youtube.com/watch?v=Jfvg3CS1X3A>

- clear screen
  - `cls`
  - ctrl+l
- `findstr /i <STRING>` ...ignore case sensitivity
- `ipconfig /all | findstr DNS`
- `gci env: | findstr Prog`
- Copy to clipboard: `gci env: | clip`
- `powercfg /energy`
- `powercfg /batteryreport`
- `assoc` and `assoc .mp4=VLC.vlc`
- `chkdsk /f` `chkdsk /r` disk check
- `sfc` system file checker
- `netsh`

### Check Ports

- `netstat -ab` ...Lists ports and their corresponding applications
- `netstat -ab | findstr "Lucee Tomcat Apache"`
- `netstat -ano` ...Lists active network connections and listening ports, including the Process ID (PID), but without resolving executable names
- `netstat -ano | findstr ":80 " | findstr LISTEN`  ...filters for connections specifically on port 80 and shows the listening ones
- `tasklist /fi "PID eq 6292"` ...filters the task list to show only the process with PID 6292
- ``

### Services

#### Find services

- `Get-Service postgresql-x64-17`  ...get a specific service
- `sc query | findstr /i postgres` ...find postgres service
- `tasklist | findstr postgres` ...find postgres process
- `tasklist | findstr 18596` ...find service with id 18596
- `Get-Process -Id (Get-NetTCPConnection -LocalPort 5432).OwningProcess` ...check PORT
- `netstat -aon | findstr 5432` ...check PORT

#### Restart service

- `net stop <servicename>` ...e.g. net start postgresql-x64-17
- `net start <servicename>`
- `Restart-Service postgresql-x64-17`  ...restart a specific service

### Aliases

- `Set-Alias -Name ll -Value Get-ChildItem`
- open profile: `notepad $profile`
- add: e.g. `Set-Alias -Name kc -Value kubectl`

```powershell
function Get-Dockerstuff { 
    Write-Output "DOCKER IMAGES"; 
    Write-Output "--------------------------------------------------------------------"; 
    docker image ls; 
    Write-Output "`nDOCKER CONTAINERS"; 
    Write-Output "--------------------------------------------------------------------"; 
    docker container ls -a; 
    Write-Output "`nDOCKER NETWORKS"; 
    Write-Output "--------------------------------------------------------------------"; 
    docker network ls; 
    Write-Output "`nDOCKER VOLUMES"; 
    Write-Output "--------------------------------------------------------------------"; 
    docker volume ls
}

Set-Alias -Name dockerstuff -Value Get-Dockerstuff
```
