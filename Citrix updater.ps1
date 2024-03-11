$ips = Get-Content C:\AdminTools\citrix.txt # Change this to your list
$total_machines = ($ips).Length # Don't change this, it checks the length of the list.
$counter = 0
cls
# Make sure latest Citrix installer is located and renamed to this -> C:\AdminTools\Citrix_Workspace_2203_CU3.exe

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
    Write-Host "Copying over Citrix_Workspace_2203_CU3.exe" -ForegroundColor Yellow
    Copy-Item -force "C:\AdminTools\Citrix_Workspace_2203_CU3.exe" -Destination "\\$ip\C$\AdminTools"
    Write-Host "Installing Citrix" -ForegroundColor Yellow
    psexec \\$ip -d \\$ip\C$\admintools\Citrix_Workspace_2203_CU3.exe
    Write-Host "Finished installing Citrix!" -ForegroundColor Green
    }
    else
    {
  Write-Host "Unable to find or contact $ip" -ForegroundColor Red
    }
 }