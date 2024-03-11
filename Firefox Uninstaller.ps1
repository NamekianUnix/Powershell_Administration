$ips = Get-Content C:\AdminTools\firefox.txt # Change this to your list.
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
Write-Output "Testing connection for $ip"

if (Test-Connection –ComputerName $ip –Count 1 –ErrorAction SilentlyContinue –WarningAction SilentlyContinue) {
    if(Test-Path "\\$ip\C$\Program Files (x86)\Mozilla Firefox\uninstall\helper.exe") {
        Write-Host "Connection Successful!" -ForegroundColor Green
        Write-Host "Firefox exists on $ip" -ForegroundColor Red
        Write-Host "Stopping Firefox" -ForegroundColor Yellow
        psexec \\$ip -s powershell -command "Stop-Process -Name firefox -force"
        Write-Host "Removing Firefox from $ip" -ForegroundColor Yellow
        psexec.exe \\$ip -d \\$ip\"C$\\Program Files (x86)\Mozilla Firefox\uninstall\helper.exe" /silent
        Write-Host "Uninstalled Firefox for $ip" -ForegroundColor Green 
        }
        else 
        {
        Write-Host "Connection Successful!" -ForegroundColor Green
        Write-Host "Firefox not installed on $ip" -ForegroundColor Green
        }
    }
    else
    {
    Write-Host "Unable to find or contact $ip" -ForegroundColor Red
    }
}