$ips = Get-Content C:\AdminTools\mecm.txt # Rename to your desired list.
$TotalCount = ($ips).Length # Don't change this one, it checks the length of your list.

#Choose the names of your ping files. Successful pings and failed pings will be put in their own .txt files for later reference. I put "00"'s in front so they stay together at the top of your chosen directory.
$ItPings = "C:\admintools\00_pingable.txt"
$ItDead = "C:\admintools\00_dead.txt"
cls # Starting the script with a clear screen

#Removes existing ping files so it doesn't append additional info to an existing file. 
Remove-Item $ItPings -Force
Remove-Item $ItDead -Force
cls # Not sure if file deletion was successful or not. Keeping it clean either way.

# Wakes up the machine for better connectivity accuracy, also sets expectations for the user.
Write-Host "Waking up all $TotalCount machines with 1 ping each. This part should take a 10 seconds or less depending on your computer specs and list size." -ForegroundColor Yellow
Write-Output "Expect screen spam showing if connections were true or false for each machine."
$ips | ForEach-Object { Test-Connection -ComputerName $_ -Count 1 -AsJob } | Get-Job | Receive-Job -Wait | Select-Object @{Name='ComputerName';Expression={$_.Address}},@{Name='Reachable';Expression={if ($_.StatusCode -eq 0) { $true }  else { $false }}} | ft -AutoSize
cls # Get rid of all that spam

# Setting expectations for the user
Write-Output "Waiting 2 seconds for the machines to wake up."
Start-Sleep -Seconds 2
Write-Host "Pinging all $TotalCount machines with a single ping and outputing the results into the .txt files you specified. This part should take less than 20 seconds." -ForegroundColor Yellow
Write-Host "The screen will flood with blank space soon, this is normal." -ForegroundColor Yellow
Write-Host "I'll let you know when I'm done." -ForegroundColor Yellow

# Ping everything once, and output the list to .txt files.
$ips `
| ForEach-Object { Test-Connection -ComputerName $_ -Count 1 -AsJob } `
| Get-Job `
| Receive-Job -Wait `
| Select-Object {if ($_.StatusCode -eq 0) { $_ | Select-Object $_.address -ExpandProperty address | Out-File -FilePath $ItPings -Append }  else { $_ | Select-Object $_.address -ExpandProperty address | Out-File -FilePath $ItDead -Append }}

cls # to clear the blank space

# Quick stats at the end of the script are displayed, it also tells you the script has finished.
$PingCount = (Get-Content $ItPings).Length
$DeadCount = (Get-Content $ItDead).Length

Write-Host "Finished!" -ForegroundColor Green
Write-Host "Out of $TotalCount total machines, here's the final count:"
Write-Host "Ping: $PingCount" -ForegroundColor Green
Write-Host "Dead: $DeadCount" -ForegroundColor Red
Write-output "Check out your pingable list at $ItPings"
Write-output "Check out your dead list at $ItDead"