$ips = Get-Content C:\AdminTools\edge.txt # Change this to your list.
$total_machines = ($ips).Length # Don't change this, it checks the length of the list.
$counter = 0 # Don't change this, it keeps the counter accurate.
cls
# Make sure latest Edge installer located in C:\AdminTools\MicrosoftEdgeEnterpriseX64.msi

foreach ($ip in $ips) {
$counter++

# Formatting to help keep track of how far along it is
Write-Output " "
Write-Output "======================================"
Write-Output "$counter of $total_machines - $ip"
Write-Output "======================================"
Write-Output " "
Write-Host "Testing connection for $ip" -ForegroundColor yellow

#Checks if it pings, Stops Edge on their machine to avoid parallel installs, Copies Edge installer to their machine, Installs edge WITHOUT a reboot.
if (Test-Connection -ComputerName $ip -Count 1 –ErrorAction SilentlyContinue –WarningAction SilentlyContinue) {
    Write-Host "Connection successful" -ForegroundColor Green
    Write-Host "Stopping edge on $ip. $counter of $total_machines" -ForegroundColor Yellow
    psexec \\$ip -s powershell -command "Stop-Process -name msedge -force"
    Write-Host "Copying over new .msi file" -ForegroundColor Yellow
    Copy-Item -Force "C:\AdminTools\MicrosoftEdgeEnterpriseX64.msi" -Destination "\\$ip\C$\AdminTools"
    Write-Host "Installing Edge on $ip. $counter of $total_machines" -ForegroundColor Yellow
    #psexec.exe \\$ip msiexec.exe /i "\\$ip\C$\admintools\MicrosoftEdgeEnterpriseX64.msi" /forcerestart /quiet
    psexec.exe \\$ip msiexec.exe /i "\\$ip\C$\admintools\MicrosoftEdgeEnterpriseX64.msi" /quiet
    Write-Host "Edge installation finished, rebooting $ip" -ForegroundColor Green
    }       
    else
    {
Write-Host "Unable to find or contact $ip" -ForegroundColor Red
    }
}