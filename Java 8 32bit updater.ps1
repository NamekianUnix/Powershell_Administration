$ips = Get-Content C:\AdminTools\java.txt # Change this to your list
$total_machines = ($ips).Length # Don't change this, it checks the length of the list.
$counter = 0 # Don't change this, It keeps the counter accurate.

$LatestJava32Bit = "C:\AdminTools\jre-8u401-windows-i586.exe" # Update to the latest installer version location and name.
$CurrentVersion = "jre-8u401-windows-i586.exe" # Update to the latest installer name.
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

    # Uninstall Java 8 64bit
    Write-Host "Uninstalling x64 bit version of Java 8, This may take a minute." -ForegroundColor Yellow
    gwmi Win32_Product -ComputerName $ip -filter "name like 'Java%64%' AND vendor like 'Oracle%'" | % {$_.Uninstall()}

    # Copy over Java 8 32bit install file
    Write-Host "Copying over $CurrentVersion" -ForegroundColor Yellow
    Copy-Item -Force $LatestJava32Bit -Destination "\\$ip\C$\AdminTools"

    # Install latest Java 8 32bit
    Write-Host "Installing Java 32bit, which will overwrite the previous 32bit version." -ForegroundColor Yellow
    psexec.exe \\$ip -d \\$ip\C$\admintools\$CurrentVersion /s
    Write-Host "Done!" -ForegroundColor Green
    }
    else
    {
    Write-Host "Unable to find or contact $ip" -ForegroundColor Red
    }
}