# Get-WmiObject -ComputerName $ip -Class Win32_Product -Filter "Name LIKE 'Microsoft Visual C++%200%'"
#Get-WmiObject -Class Win32_Product -Filter "Name LIKE '%java%'"

$ips = Get-Content C:\AdminTools\testpad.txt # Change this to your list
$total_machines = ($ips).Length # Don't change this, it checks the length of the list.
$counter = 0
cls

Remove-Item -force C:\admintools\Javaversion.txt
cls

foreach ($ip in $ips) { 
$counter++

# Formatting to help keep track of how far along it is
Write-Output " "
Write-Output "======================================"
Write-Output "$counter of $total_machines"
Write-Output "======================================"
Write-Output " "
Write-Host "Testing connection for $ip" -ForegroundColor Yellow

if (Test-Connection –ComputerName $ip -Count 1 –ErrorAction SilentlyContinue –WarningAction SilentlyContinue) {
    Write-Host "$ip Pings!" -ForegroundColor Green
    Write-Host "Checking for Java Version and outputing it to a file" -ForegroundColor Yellow
    Get-WmiObject -ComputerName $ip -Class Win32_Product `
    | where {($_.Name -like "*java*") -and ($_.Vendor -like "*Oracle*")} `
    | Select Name `
    | Out-File -FilePath C:\admintools\Javaversion.txt -Append
    Write-Host "Done" -ForegroundColor Green
    }
    else
    {
    Write-Host "$ip doesn't ping" -ForegroundColor Red
    }
}