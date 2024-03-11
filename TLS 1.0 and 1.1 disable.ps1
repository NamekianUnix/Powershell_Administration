$ips = Get-Content C:\AdminTools\TLS.txt # Change this to your list
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

if (Test-Connection –ComputerName $ip -Count 1 –ErrorAction SilentlyContinue –WarningAction SilentlyContinue) {
    Write-Host "Connection Successful!" -ForegroundColor Green
    
    # Copy over TLS reg file
    Write-Host "Copying over TLSfix.reg file" -ForegroundColor Yellow
    Copy-Item -Force 'C:\admintools\TLSfix.reg' -Destination "\\$ip\C$\AdminTools"
    
    # Import Reg file to edit TLS settings
    Write-Host "Importing Reg key values for TLS." -ForegroundColor Yellow
    psexec \\$ip -s powershell -command "reg import C:\admintools\TLSfix.reg"
    Write-Host "All done! Error code 0 means it was successful." -ForegroundColor Green
    }
    else
    {
  Write-Host "Unable to find or contact $ip" -ForegroundColor Red
    }
}