$ips = Get-Content C:\AdminTools\zoom.txt # Change this to your list.
$total_machines = ($ips).Length # Don't change this, it checks the length of the list.
$counter = 0 # Don't change this, It keeps the counter accurate.
$UserTextFile = "C:\AdminTools\zoomdel\users.txt" # You need to make a users.txt for this script to work. Change it to your preferred location.
cls

foreach ($ip in $ips){ 
$counter++

# Formatting to help keep track of how far along it is
Write-Output " "
Write-Output "======================================"
Write-Output "$counter of $total_machines - $ip"
Write-Output "======================================"
Write-Output " "
Write-Host "Testing connection for $ip" -ForegroundColor Yellow

# Ping Test
if (Test-Connection –ComputerName $ip -Count 1 –ErrorAction SilentlyContinue –WarningAction SilentlyContinue) {
    Write-Host "Connection Successful!" -ForegroundColor Green
    
    # Records all users on target device for reference later
    Get-ChildItem -Directory -name -path \\$ip\C$\Users\ | Out-File -FilePath $UserTextFile
    $users = Get-Content $UserTextFile

    # Deletes all Zoom files in AppData folders for each user on target device
	foreach ($user in $users) {
		if (Test-Path -Literalpath "\\$ip\C$\Users\$user\AppData\Roaming\Zoom\" -PathType container){
            Remove-Item "\\$ip\C$\Users\$user\AppData\Roaming\Zoom\" -Force -Recurse
            Write-Host "Zoom found and removed from $user" -ForegroundColor Yellow             
            }
            else 
            {
            Write-Host "Zoom not found on $user" -ForegroundColor Green
       }
    }
 }        
 else
 {
 Write-Host "Unable to find or contact $ip" -ForegroundColor Red
 }
}