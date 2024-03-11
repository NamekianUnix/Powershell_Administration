$ips = Get-Content C:\AdminTools\ADremoval.txt #Determines where the list is and what you named the list
$TotalCount = ($ips).Length #don't change this one. It counts the list length.
$Removed = "C:\AdminTools\AD-COMPUTER\Removed_from_AD.txt" #Where you want the text file stored for removed devices
$Not_Found = "C:\AdminTools\AD-COMPUTER\Not_Found_IN_AD.txt" #Where you want the text file stored for devices that were not found in AD

#Starts by deleting old text files from previous ADremoval script sessions
Remove-Item -force $Removed
Remove-Item -force $Not_Found
cls 

#Looks for device in AD, Removes it automatically if it finds it, moves on to the next device if it doesn't. Then outputs a text file with all the results.
foreach ($ip in $ips)
{
try {
    Get-ADComputer $ip | Remove-ADComputer -Confirm:$false
    Write-Output "$ip Removed from AD"
    Write-Output "$ip Removed from AD" | Out-File $Removed -Append
    }
catch {
    Write-Output "$ip not found in AD"
    Write-Output "$ip not found in AD" | Out-File $Not_Found -Append  
}
}

#uncomment below if you want a final count of what was removed and what wasn't found.

#$Removed_count = (Get-Content $Removed).Length
#$Not_Found_count = (Get-Content $Not_Found).Length

#Write-Host "Finished!" -ForegroundColor Green
#Write-Host "Out of $TotalCount total machines, here's the final count:"
#Write-Host "Removed from AD: $Removed_count" -ForegroundColor Yellow
#Write-Host "Not Found in AD: $Not_Found_count" -ForegroundColor Green
#Write-output "Check out the Removed list at $Removed"
#Write-output "Check out the Not Found list at $Not_Found"