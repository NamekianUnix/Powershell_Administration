$ips = Get-Content C:\AdminTools\00_pingable.txt # pulls from a list of pingable addresses. There are no ping tests in this script, I use another script for that.
$total_machines = ($ips).Length # Don't change this, it checks the length of the list.
$counter = 0 # Don't change this, it keeps the counter accurate.
$latestagent = "DHA-ePO_Agent Pkg_WIN_581.exe" # update to whatever the newest agent is.
cls

foreach ($ip in $ips) {
$counter++

# Formatting to help keep track of how far along it is.
Write-Output " "
Write-Output "======================================"
Write-Output "$counter of $total_machines - $ip"
Write-Output "======================================"
Write-Output " "

#check if agent exists, if so, prompt the agent to update itself. if not, it installs the agent.
Write-Host "Checking if Trellix is installed" -ForegroundColor Yellow
if(Test-Path -path "\\$ip\C$\Program Files\McAfee\Agent\" -ErrorAction SilentlyContinue)
    {
    Write-Host "Trellix exists! Here's the version info:" -ForegroundColor green
    Write-Host (Get-Item "\\$ip\C$\Program Files\McAfee\Agent\cmdagent.exe").VersionInfo
    #Write-Host "Prompting the Trellix cmdagent to update itself" -ForegroundColor yellow
    #psexec.exe \\$ip -d "\\$ip\C$\Program Files\McAfee\Agent\cmdagent.exe" /s
    #The 2 lines above update the existing agent. The 8 lines below Install a new agent. Either comment the 2 above or comment the 8 below depending on if agent updates are working for you or not. Do not comment both or uncomment both. Choose one section to comment, and uncomment the other.
    Write-Host "Copying $latestagent to the AdminTools on $ip" -ForegroundColor yellow
    Copy-Item "C:\AdminTools\$latestagent" -Destination "\\$ip\C$\AdminTools" -Force
    Get-Item -Path "\\$ip\C$\Admintools\*"
    Write-Host "If you see $latestagent listed, the install may work" -ForegroundColor yellow
    Write-Host "Installing Trellix agent now" -ForegroundColor yellow
    psexec.exe \\$ip "\\$ip\C$\admintools\$latestagent" /install=agent /silent
    Write-Host "Error code 0 means it worked" -ForegroundColor yellow
    Write-Host "Trellix installation started, moving to the next machine" -ForegroundColor green
    }
    #if agent is not installed, push new agent.
    else
    {
    Write-Host "Trellix is not installed." -ForegroundColor red
    Write-Host "Copying $latestagent to the AdminTools on $ip" -ForegroundColor yellow
    Copy-Item "C:\AdminTools\$latestagent" -Destination "\\$ip\C$\AdminTools" -Force
    Get-Item -Path "\\$ip\C$\Admintools\*"
    Write-Host "If you see $latestagent listed, the install should work" -ForegroundColor yellow
    Write-Host "Installing Trellix agent now" -ForegroundColor yellow
    psexec.exe \\$ip "\\$ip\C$\admintools\$latestagent" /install=agent /silent
    Write-Host "Error code 0 means it worked" -ForegroundColor yellow
    Write-Host "Trellix installation started, moving to the next machine" -ForegroundColor green
    }
}