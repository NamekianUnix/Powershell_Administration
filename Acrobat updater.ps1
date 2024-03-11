$ips = Get-Content C:\AdminTools\AdobeAcrobat.txt # Change this to your list
$total_machines = ($ips).Length # Don't change this, it checks the length of the list.
$counter = 0
cls
# Make sure latest Citrix installer is located and renamed to this -> C:\AdminTools\Adobe_Acrobat_Reader_2023.006.20380.EXE

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
    Write-Host "Copying over Adobe_Acrobat_Reader_2023.006.20380.exe" -ForegroundColor Yellow
    Copy-Item -force "C:\AdminTools\Adobe_Acrobat_Reader_2023.006.20380.exe" -Destination "\\$ip\C$\AdminTools"
    Write-Host "Installing Adobe Acrobat Reader" -ForegroundColor Yellow
    psexec \\$ip -d \\$ip\C$\admintools\Adobe_Acrobat_Reader_2023.006.20380.exe
    #psexec \\$ip -s powershell -command "Start-Process -Wait -FilePath "C:\AdminTools\Adobe_Acrobat_Reader_2023.006.20380.exe -ArgumentList /sAll /rs /rps /msi /qn /norestart ALLUSERS=1 EULA_ACCEPT=YES""
    Write-Host "Finished installing Adobe Acrobat Reader!" -ForegroundColor Green
    }
    else
    {
  Write-Host "Unable to find or contact $ip" -ForegroundColor Red
    }
 }