$ips = Get-Content C:\AdminTools\STIG.txt
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
write-Host "copying STIG Tools to $ip" -ForegroundColor yellow
Copy-Item "C:\temp\Delivery\STIG_2-15-24.zip" -Destination \\$ip\C$\temp\ -Force -Recurse
Get-Item -Path "\\$ip\C$\temp\*"
 }
else
 {
 Write-Warning "Unable to find or contact $ip"
 }
}