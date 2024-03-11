#Visual studio uninstall

$computer = "zhtvwkbh6fmh3.med.ds.osd.mil"

#$OldApp = "Microsoft Visual C++ 2005 Redistributable"
$OldApp = "Microsoft Visual C++ 2008 Redistributable - x86 9.0.30729.17"
#$NewApp = "Microsoft Visual C++ 2008 Redistributable - x86 9.0.30729.4148"
$App2remove = Get-WmiObject -Class Win32_Product -ComputerName $computer | Where-Object{$_.Name -eq $OldApp}
$App2remove.Uninstall()

#This output means it uninstalled properly.

#__GENUS          : 2
#__CLASS          : __PARAMETERS
#__SUPERCLASS     : 
#__DYNASTY        : __PARAMETERS
#__RELPATH        : 
#__PROPERTY_COUNT : 1
#__DERIVATION     : {}
#__SERVER         : 
#__NAMESPACE      : 
#__PATH           : 
#ReturnValue      : 0
#PSComputerName   : 

