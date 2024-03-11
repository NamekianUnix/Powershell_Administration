$ips = Get-Content C:\AdminTools\pingable.txt
$counter = 0
$total_machines = (Get-Content C:\AdminTools\pingable.txt).Length
cls

foreach ($ip in $ips) {
Write-Output "Working on $ip"
if(Test-Connection -ComputerName $ip -Count 1 -ErrorAction SilentlyContinue) {
$counter++
Get-WmiObject -ComputerName $ip -Class Win32_Product -Filter "Name LIKE 'Microsoft Visual C++%200%'"
Write-Output "$counter of $total_machines"
Write-Output "============================================================"
}
else
{
$counter++
Write-Host "$ip doesn't ping" -ForegroundColor Red
Write-Output "$counter of $total_machines"
Write-Output "============================================================"
}
}