$ips = Get-Content C:\AdminTools\00_pingable.txt
$total_machines = ($ips).Length # Don't change this, it checks the length of the list.
$counter = 0
cls

foreach ($ip in $ips) {
$counter++

# Formatting to help keep track of how far along it is
Write-Output " "
Write-Output "======================================"
Write-Output "$counter of $total_machines"
Write-Output "======================================"
Write-Output " "
Write-Host "Testing connection for $ip" -ForegroundColor yellow

if (Test-Connection -ComputerName $ip -Count 1 –ErrorAction SilentlyContinue –WarningAction SilentlyContinue) {
Write-Host "Connection Successful!" -ForegroundColor Green
write-Host "copying CCMrepair to $ip" -ForegroundColor yellow
Copy-Item "C:\Windows\CCM\CCMREPAIR.exe" -Destination \\$ip\C$\Windows\CCM\ -Force -Recurse
Write-Host "running CCMrepair on $ip" -ForegroundColor yellow
psexec \\$ip -s powershell -command "Start-Process -Wait -FilePath "C:\Windows\CCM\CCMREPAIR.exe" -ArgumentList "/S""

 }
else
 {
 Write-Warning "Unable to find or contact $ip"
 }
}