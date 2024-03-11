$ips = Get-Content C:\AdminTools\firefox.txt # Change this to your list.
$total_machines = ($ips).Length # Don't change this, it checks the length of the list.
$counter = 0
cls
# Make sure latest Firefox installer is located and renamed to this -> C:\AdminTools\Mozilla_Firefox.exe

foreach ($ip in $ips){ 
$counter++

# Formatting to help keep track of how far along it is
Write-Output " "
Write-Output "======================================"
Write-Output "$counter of $total_machines"
Write-Output "======================================"
Write-Output " "
Write-Output "Testing connection for $ip"

if (Test-Connection –ComputerName $ip –Count 1 –ErrorAction SilentlyContinue –WarningAction SilentlyContinue) {
    Write-Host "Connection Successful!" -ForegroundColor Green
    Write-Host "Copying over Mozilla_Firefox.exe" -ForegroundColor Yellow
    Copy-Item -force "C:\AdminTools\Mozilla_Firefox.exe" -Destination "\\$ip\C$\AdminTools"
    Write-Host "Installing Firefox" -ForegroundColor Yellow
    psexec.exe \\$ip -d "\\$ip\C$\admintools\Mozilla_Firefox.EXE"
    Write-Host "Finished installing Firefox!" -ForegroundColor Green
    }
    else
    {
  Write-Host "Unable to find or contact $ip" -ForegroundColor Red
    }
}