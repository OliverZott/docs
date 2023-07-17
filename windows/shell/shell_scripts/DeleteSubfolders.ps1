<#
.SYNOPSIS
    Searching for all "obj" and "bin folders recursively and delete them

.DESCRIPTION
    Detailed description of the script and its purpose.

.PARAMETER Path
    Path where to search for "obj" and "bin" folders (including all subfolders)

.EXAMPLE
    Example of how to use the script:

    > .\DeleteSubfolders.ps1 -Path "C:\Example"
    > .\DeleteSubfolders.ps1 -Path "C:\Example" -y
    > Get-Help .\DeleteSubfolders.ps1

.NOTES
    -

.LINK
    -
#>

[Cmdletbinding()]
param (
    [Parameter(Mandatory = $true)]
    [ValidateScript({ Test-Path $_ -PathType 'Container' })]
    [string]$Path,
    [switch]$y
)

$foldersToDelete = Get-ChildItem -Path $Path -include bin, obj -Recurse -Directory | Select-Object -ExpandProperty FullName

if ($foldersToDelete.Count -eq 0) {
    Write-Host "No folders named 'bin' or 'obj' found."
}
else {

    Write-Host "The following folders will be deleted:" -ForegroundColor Blue
    foreach ($folder in $foldersToDelete) {
        Write-Host $folder -ForegroundColor Red
    }

    if ($y) {
        $confirmation = "y"
    } 
    else {
        $confirmation = Read-Host "Do you want to continue deleting? (y/n)"
    }
    if ($confirmation.ToLower() -eq 'y') {
        $foldersToDelete | ForEach-Object {
            Remove-Item -Path $_ -Recurse -Force
        }
        Write-Host "Folders deleted successfully."
    }
    else {
        Write-Host "Deletion canceled."
    }
}