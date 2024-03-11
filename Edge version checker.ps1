$ips = Get-Content C:\AdminTools\ipchrome.txt
$total_machines = (Get-Content C:\AdminTools\ipchrome.txt).Length
$counter = 0

foreach ($ip in $ips) {
$counter++
if(Test-Connection -ComputerName $ip -Count 1 -ErrorAction SilentlyContinue) {
    psexec \\$ip -s powershell -command (Select-Object "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" -ExcludeProperty FileVersion).VersionInfo
    Write-Output "^ Edge installed with this version ^ on $ip "
    Write-Output "$counter of $total_machines"
    }
else
    {
    Write-Host "Unable to find or contact $ip" -ForegroundColor Red
    Write-Output "$counter of $total_machines"
    }
}