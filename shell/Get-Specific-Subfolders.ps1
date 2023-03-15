[Cmdletbinding()]
param(
    # Path to delete all obj / bin folders in.
    [string]
    [Parameter(Mandatory)]
    $Path
)
Write-Host "Searching in path '$Path'" @parameters -ForegroundColor Magenta

# $foldersToDelete = Get-ChildItem -Path $Path -Recurse -Directory
# $result = $foldersToDelete.where{ $_ -match "bin" -or $_ -match "obj" }

$foldersToDelete = Get-ChildItem -Path $Path -include bin, obj  -Recurse
if ($foldersToDelete.count -eq 0) {
    Write-Host "No bin or obj folder found in path: '$path'" -ForegroundColor Red
}

foreach ($folder in $foldersToDelete) {
    Write-Output "Removing $folder ..." 
    # Remove-Item $folder -Recurse -Force
}
