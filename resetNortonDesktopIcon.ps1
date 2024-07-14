if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole("Administrators")) { Start-Process powershell.exe "-File `"$PSCommandPath`"" -Verb RunAs; exit }

(Get-Content "C:\Users\Public\Desktop\desktop.ini") | foreach { $_ -replace "^Norton Security.*$","" } | Set-Content "C:\Users\Public\Desktop\desktop.ini"