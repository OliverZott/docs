# Shell Basics

PowerShell is different from both Bash and Zsh because it is designed to interact with .NET structures natively in Windows. This means that it can pipe objects and data between scripts, applications, and sessions. Each object in PowerShell has its own series of properties, which makes the data handling within PowerShell even more granular.

## windows powershell

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

### set aliases

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
