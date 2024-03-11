$ips = Get-Content C:\AdminTools\ipchrome.txt
$counter_online = 0 
$counter_offline = 0 
$total_machines = (Get-Content C:\AdminTools\ipchrome.txt).Length
cls

ForEach ($ip in $ips){
if (Test-Connection -ComputerName $ip -Count 1 -ErrorAction SilentlyContinue) 
  { 
  clear  
  Write-Host "$ip is good" -ForegroundColor Green
  $counter_online++
  $counter_both_combined = $counter_online+$counter_offline
  $progress_percent = ($counter_both_combined/$total_machines)*100 | % {$_.ToString("#.##")}
  Write-Host " Tested online so far: $counter_online"
  Write-Host "Tested offline so far: $counter_offline"
  Write-Host "      Machines tested: $counter_both_combined"
  Write-Host "             Progress: $progress_percent%"
  }
else{ 
  clear
  Write-Host "$ip is down" -ForegroundColor Red
  $counter_offline++
  $counter_both_combined = $counter_online+$counter_offline
  $progress_percent = ($counter_both_combined/$total_machines)*100 | % {$_.ToString("#.##")}
  Write-Host " Tested online so far: $counter_online"
  Write-Host "Tested offline so far: $counter_offline"
  Write-Host "      Machines tested: $counter_both_combined"
  Write-Host "             Progress: $progress_percent%"
    }
}