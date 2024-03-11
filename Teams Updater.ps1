$ips = Get-Content C:\AdminTools\teams.txt # Change this to your list.
$total_machines = ($ips).Length # Don't change this, it checks the length of the list.
$counter = 0
cls
# Make sure latest Teams installer is located and renamed to this -> \\$ip\C$\admintools\teams.exe

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
    Write-Host "Copying over teams.exe" -ForegroundColor Yellow
    Write-Host "Copying over teams script" -ForegroundColor Yellow
    Copy-Item -force "C:\AdminTools\teams.exe" -Destination "\\$ip\C$\AdminTools"
    Copy-Item -force "C:\AdminTools\powershell\teamremoteinstaller.ps1" -Destination "\\$ip\C$\AdminTools"
    Write-Host "Installing Teams" -ForegroundColor Yellow
    #psexec \\$ip -d "\\$ip\C$\admintools\teamremoteinstaller.ps1"
    psexec \\$ip -s powershell -command "Start-Process -FilePath "C:\AdminTools\Teamremoteinstaller.ps1" -ArgumentList "/S""
    #Invoke-Command -ComputerName $ip -FilePath \\$ip\C$\AdminTools\teamremoteinstaller.ps1
    Write-Host "Finished installing Teams!" -ForegroundColor Green
    }
    else
    {
  Write-Host "Unable to find or contact $ip" -ForegroundColor Red
    }
}