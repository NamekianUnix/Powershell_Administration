$ips = Get-Content C:\AdminTools\VisualStudio.txt # Change this to your list
$total_machines = ($ips).Length # Don't change this, it checks the length of the list.
$counter = 0
$OldApp2005 = "Microsoft Visual C++ 2005 Redistributable" # Doesn't has a specific decimal version
$OldApp2008 = "Microsoft Visual C++ 2008 Redistributable - x86 9.0.30729.17" # This is the default 2008 version
$NewApp2008 = "Microsoft Visual C++ 2008 Redistributable - x86 9.0.30729.6161" # This should be the latest 2008 version
cls
# Make sure latest Visual Studio 2008 installer is located and renamed to this -> C:\AdminTools\vcredist_x86.exe

foreach ($ip in $ips) {
$counter++

# Formatting to help keep track of how far along it is
Write-Output " "
Write-Output "======================================"
Write-Output "$counter of $total_machines"
Write-Output "======================================"
Write-Output " "
Write-Host "Testing connection for $ip" -ForegroundColor Yellow

if (Test-Connection -ComputerName $ip -Count 1 –ErrorAction SilentlyContinue –WarningAction SilentlyContinue) {
Write-Host "Connection Successful!" -ForegroundColor Green

# Checks which versions of visual studio exists on the machine and removes certain versions
Write-Host "Checking for $OldApp2005 on $ip. This may take a minute." -ForegroundColor Yellow
if (Get-WmiObject -Class Win32_Product -ComputerName $ip | Where-Object{$_.Name -eq $OldApp2005}){
    Write-Host "Uninstalling $OldApp2005 from $ip" -ForegroundColor Yellow
    $App2remove2005 = Get-WmiObject -Class Win32_Product -ComputerName $ip | Where-Object{$_.Name -eq $OldApp2005}
    $App2remove2005.Uninstall()
    }
    else
    {
    Write-Host "The old $OldApp2005 Doesn't exist on $ip. That's a good thing!" -ForegroundColor Green
    }

Write-Host "Checking for $OldApp2008 on $ip. This may take a minute." -ForegroundColor Yellow
if (Get-WmiObject -Class Win32_Product -ComputerName $ip | Where-Object{$_.Name -eq $OldApp2008}){
    Write-Host "Uninstalling $OldApp2008 from $ip" -ForegroundColor Yellow
    $App2remove2008 = Get-WmiObject -Class Win32_Product -ComputerName $ip | Where-Object{$_.Name -eq $OldApp2008}
    $App2remove2008.Uninstall()
    }
    else
    {
    Write-Host "The old $OldApp2008 Doesn't exist on $ip. That's a good thing!" -ForegroundColor Green
    }

Write-Host "Checking for $NewApp2008 on $ip. This may take a minute." -ForegroundColor Yellow
if (Get-WmiObject -Class Win32_Product -ComputerName $ip | Where-Object{$_.Name -eq $NewApp2008}){
    Write-Host "$NewApp2008 is already installed on $ip. Installing anyways." -ForegroundColor Green
    }
    else
    {
    Write-Host "The new $NewApp2008 Doesn't exist on $ip. Proceeding with Installation." -ForegroundColor Red
    }

# Copy vcredist_x86 file for installation
Write-Host "Copying new vcredist file to $ip" -ForegroundColor Yellow
Copy-Item "C:\AdminTools\vcredist_x86.exe" -Destination "\\$ip\C$\AdminTools\" -recurse -force

# Install the 2008 version silently
Write-Host "Installing Visual Studio 2008 on $ip" -ForegroundColor Yellow
psexec \\$ip -s powershell -command "Start-Process -Wait -FilePath "C:\AdminTools\vcredist_x86.exe" -ArgumentList "/S,/v,/qn" -PassThru"
Write-Output "Exit code 0 means installation was successful"

# Cleanup the vcredist file once installation is done
Write-Host "Removing vcredist file" -ForegroundColor Yellow
Remove-Item "\\$ip\C$\AdminTools\vcredist_x86.exe" -Force -Recurse

# Checks if the new version installed correctly
Write-Host "Checking for $NewApp2008 on $ip. This may take a minute." -ForegroundColor Yellow
if (Get-WmiObject -Class Win32_Product -ComputerName $ip | Where-Object{$_.Name -eq $NewApp2008}){
    Write-Host "$NewApp2008 successfully installed on $ip." -ForegroundColor Green
    }
    else
    {
    Write-Host "$NewApp2008 Doesn't exist on $ip. Check to see what went wrong." -ForegroundColor Red
    }
}
else
{
Write-Host "= $ip doesn't ping" -ForegroundColor Red
}
}