# Created by Shawn Rydalch
# This script pings large lists of machines in parallel really really fast.

$ips = Get-Content C:\AdminTools\TLS.txt # Change $ips to the file path of computer you wish to mass ping.
cls # The script starts off by clearing your screen because its about to flood it with results.

# The script is running each ping as a job and doesn't wait for the job to finish before starting another job. 
# The output doesn't populate for 3-4 seconds as it waits for responses from all of the jobs before it displays the output.
$ips `
| ForEach-Object { Test-Connection -ComputerName $_ -Count 10 -AsJob } `
| Get-Job `
| Receive-Job -Wait `
| Select-Object @{Name='ComputerName';Expression={$_.Address}},@{Name='Reachable';Expression={if ($_.StatusCode -eq 0) { $true }  else { $false }}} `
| ft -AutoSize

#After about 6 seconds or less your screen will filled with a long list of IP's with a true or false statement next to each ip stating if they were reachable. 
#This script was tested on a list of 1300+ IP's and finished in 6 seconds.