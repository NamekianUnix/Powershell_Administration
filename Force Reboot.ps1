$ips = Get-Content C:\AdminTools\tls.txt # Change this to your list.
$total_machines = ($ips).Length # Don't change this, it checks the length of the list.
$counter = 0 # Don't change this, It keeps the counter accurate.
cls

foreach ($ip in $ips){ 
$counter++

# Formatting to help keep track of how far along it is
Write-Output " "
Write-Output "======================================"
Write-Output "$counter of $total_machines"
Write-Output "======================================"
Write-Output " "
Write-Host "Testing connection for $ip" -ForegroundColor Yellow

if (Test-Connection –ComputerName $ip –Count 1 –ErrorAction SilentlyContinue –WarningAction SilentlyContinue) {
    Write-Host "Connection Successful!" -ForegroundColor Green
    Write-Host "Rebooting $ip" -ForegroundColor Yellow
    Restart-Computer -ComputerName $ip -Force
    }
    else
    {
  Write-Host "Unable to find or contact $ip" -ForegroundColor Red
    }
}