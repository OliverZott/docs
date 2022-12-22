<#
.Synopsis
    Test script.
.Example
    .\Test-Script.ps1 -v <VirtualMachineName> -s clean
#>

param (
    $vmName,
    $ssName
)

process {

    # $path = Get-Location
    $path = $MyInvocation.MyCommand.Path
    $parentPath = Split-Path $path -Parent
    $invokationCommand = $MyInvocation.MyCommand
    $scriptName = $MyInvocation.MyCommand.Name
    
    Write-Host "path: $path"
    Write-Host "parent path: $parentPath"
    Write-Host "invocation command: $invokationCommand"
    Write-Host "script name: $scriptName"
    Write-Host "VM: $vmName; SnapShot: $ssName"    

}