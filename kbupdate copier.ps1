$ips = Get-Content C:\AdminTools\kbupdate.txt # Change this to your list
$total_machines = ($ips).Length # Don't change this, it checks the length of the list.
$counter = 0
$kbupdate = "KB5034122"
$kbupdatefile = "windows10.0-kb5034122-x64_de14dfac8817c1d0765b899125c63dc7b581958b.msu"
cls
# Make sure latest KB installer is located and renamed to this -> C:\AdminTools\windows10.0-kb5033372-x64_822cb06e298fd32637584b623f2cdaa3468f42a1.msu

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
    Write-Host "Copying over $kbupdate" -ForegroundColor Yellow
    Copy-Item "C:\AdminTools\$kbupdatefile" -Destination "\\$ip\C$\AdminTools\" -recurse -force
    Write-Host "Finished copying over $kbupdate!" -ForegroundColor Green
    }
    else
    {
  Write-Host "Unable to find or contact $ip" -ForegroundColor Red
    }
 }
