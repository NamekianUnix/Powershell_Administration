#How to check for visual studio
cls
$ip = "zhtvwkbh6fmh3.med.ds.osd.mil"
Get-WmiObject -ComputerName $ip -Class Win32_Product -Filter "Name LIKE 'Microsoft Visual C++%200%'"


#$App = "Microsoft Visual C++ 2008 Redistributable - x86 9.0.30729.4148"
#$App = "Microsoft Visual C++ 2010  x64 Redistributable - 10.0.40219"
#Get-WmiObject -ComputerName $ip -Class Win32_Product | Where-Object{$_.Name -eq $App}