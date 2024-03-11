<#
@ REM This script was made by Shawn Rydalch to fix Wsus a little more thoroughly 10/5/23
net /wait stop CcmExec
net /wait stop wuauserv
powershell Set-Service -Name "cryptSvc" -Status stopped -StartupType disabled
net /wait stop cryptSvc
net /wait stop bits
net /wait stop msiserver
powershell remove-item C:\Windows\ccmcache -recurse -force
powershell remove-item C:\Windows\SoftwareDistribution -recurse -force
powershell remove-item C:\Windows\System32\catroot2 -recurse -force
reg import niprwsus.reg
net start wuauserv
powershell Set-Service -Name "cryptSvc" -Status running -StartupType enabled
net start cryptSvc
net start bits
net start msiserver
>