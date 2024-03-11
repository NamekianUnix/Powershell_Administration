$ips = Get-Content C:\AdminTools\testpad.txt

Write-Host Checking $ip
Copy-Item "C:\AdminTools\Mozilla_Firefox.EXE" -Destination "\\$ip\C$\AdminTools" -force
Get-Item -Path "\\$ip\C$\Admintools\*"
psexec.exe \\$ip -d "\\$ip\C$\admintools\Mozilla_Firefox.EXE"

#https://community.spiceworks.com/topic/579023-need-a-powershell-script-to-remove-and-reinstall-all-c-redistributables
$app = Get-WmiObject -Class Win32_Product -Filter "Name LIKE 'Microsoft Visual C++ 2008 Redistributable%'" | Write-output $app | $app

$app = Get-WmiObject -Class Win32_Product -Filter "Name LIKE 'Microsoft Visual C++ 2008 Redistributable%'" | foreach-object -process {$app.Uninstall()}


$App = "Microsoft Visual C++ 2008 Redistributable - x86 9.0.30729.4148"
$App2remove = Get-WmiObject -Class Win32_Product | Where-Object{$_.Name -eq $App}
$App2remove.Uninstall()

#This output means it uninstalled properly.

#__GENUS          : 2
#__CLASS          : __PARAMETERS
#__SUPERCLASS     : 
#__DYNASTY        : __PARAMETERS
#__RELPATH        : 
#__PROPERTY_COUNT : 1
#__DERIVATION     : {}
#__SERVER         : 
#__NAMESPACE      : 
#__PATH           : 
#ReturnValue      : 0
#PSComputerName   : 