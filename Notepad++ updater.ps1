$ips = Get-Content C:\AdminTools\notepad++.txt # Change this to your list
$total_machines = ($ips).Length # Don't change this, it checks the length of the list.
$counter = 0
cls
# Make sure latest Citrix installer is located and renamed to this -> C:\AdminTools\npp.8.6.Installer.x64.exe

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
    Write-Host "Copying over Notepad++" -ForegroundColor Yellow
    Copy-Item -force "C:\AdminTools\npp.8.6.Installer.x64.exe" -Destination "\\$ip\C$\AdminTools"
    Write-Host "Installing Notepad++" -ForegroundColor Yellow
    psexec \\$ip -s powershell -command "Start-Process -FilePath "C:\AdminTools\npp.8.6.Installer.x64.exe" -ArgumentList "/S""
    Write-Host "Finished installing Notepad++!" -ForegroundColor Green
    }
    else
    {
  Write-Host "Unable to find or contact $ip" -ForegroundColor Red
    }
 }