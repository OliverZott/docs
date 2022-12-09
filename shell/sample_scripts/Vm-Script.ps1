$vmName = vm-name
$machine = Get-VM -Name $vmName
$machine.Heartbeat


$errorInvoke = $null
$name = Invoke-Command -ComputerName $vmName -ScriptBlock { hostname } -Credential $creds -ErrorVariable $errorInvoke -erroraction 'silentlycontinue'
Write-Host $name 
Write-Host $errorInvoke