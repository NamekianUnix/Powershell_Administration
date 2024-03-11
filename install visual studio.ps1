#install vcredist_x86

$computer = "zhtvwkbh6fmh3.med.ds.osd.mil"
#$file = "C:\AdminTools\vcredist_x86.exe"

#$OldApp = "Microsoft Visual C++ 2008 Redistributable - x86 9.0.30729.17"
#$NewApp = "Microsoft Visual C++ 2008 Redistributable - x86 9.0.30729.4148"
#$NewApp = "C:\AdminTools\vcredist_x86.exe"
#$App2install = Get-WmiObject -Class Win32_Product | Where-Object{$_.Name -eq $NewApp}
#$App2install.install()

#Start-Process -Wait -FilePath "\\$ip\C$\AdminTools\vcredist_x86.exe" -ArgumentList "/S,/v,/qn" -PassThru

#Invoke-Command –ComputerName $computer –ScriptBlock {Start-Process -Wait -FilePath "C:\AdminTools\vcredist_x86.exe" -ArgumentList "/S,/v,/qn" -PassThru}

#Install-Package $PackageName -Source MyRepoName

#Invoke-Command –ComputerName $ip –ScriptBlock {Install-Package $file}

#powershell.exe -executionpolicy unrestricted (script path)

#powershell.exe -executionpolicy unrestricted (Invoke-Command –ComputerName $ip –ScriptBlock {Start-Process -Wait -FilePath "C:\AdminTools\vcredist_x86.exe" -ArgumentList "/S,/v,/qn" -PassThru})

#enter-pssession $computer 

psexec \\$computer -s powershell -command "Start-Process -Wait -FilePath "C:\AdminTools\vcredist_x86.exe" -ArgumentList "/S,/v,/qn" -PassThru"