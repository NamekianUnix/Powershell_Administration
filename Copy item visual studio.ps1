#Copy item to target computer and it overwrites older item with the same name.

$ip = "zhtvwk2052y2n.med.ds.osd.mil"
Copy-Item "C:\AdminTools\windows10.0-kb5033372-x64_822cb06e298fd32637584b623f2cdaa3468f42a1.msu" -Destination "\\$ip\C$\AdminTools\" -recurse -force