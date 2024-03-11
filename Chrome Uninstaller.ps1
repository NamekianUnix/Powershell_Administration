$ips = Get-Content C:\AdminTools\ipchrome.txt # Change this to your list
$total_machines = ($ips).Length # Don't change this, it checks the length of the list.
$counter = 0
cls

foreach ($ip in $ips) {
$counter++

# Formatting to help keep track of how far along it is
Write-Output " "
Write-Output "======================================"
Write-Output "$counter of $total_machines"
Write-Output "======================================"
Write-Output " "
Write-Output "Testing connection for $ip"

# Checks connectivity, checks if Chrome is installed, turns off Chrome, uninstalls Chrome.
if (Test-Connection –ComputerName $ip –Count 1 –ErrorAction SilentlyContinue –WarningAction SilentlyContinue) {
    Write-Host "Connection Successful!" -ForegroundColor Green
    if (Test-Path "\\$ip\C$\Program Files (x86)\Google\Chrome\Application\chrome.exe") {
        Write-Host "Chrome exists on $ip" -ForegroundColor Red
        Write-Host "Stopping Chrome" -ForegroundColor Yellow
        psexec \\$ip -s powershell -command "Stop-Process -Name chrome -force"
        $app = Get-WmiObject -ComputerName $ip -Class Win32_Product | Where-Object {$_.Name -match “Google Chrome”}
        Write-Host "Removing Chrome from $ip" -ForegroundColor Yellow
        $app.Uninstall()
        Write-Host "Uninstalled Chrome for $ip" -ForegroundColor Green
        }
        else 
        {
        Write-Host "Chrome not installed on $ip. That's good." -ForegroundColor Green
        }
    }
    else 
    {
    Write-Host "Unable to find or contact $ip" -ForegroundColor Red
    }
}