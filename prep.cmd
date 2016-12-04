@rem set keyboard layout to german
@powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-WinUserLanguageList -LanguageList de-DE -Force -Confirm:$false"

@rem configure winrm, this is quite dirty and spews errors.
cmd.exe /c winrm quickconfig -q
cmd.exe /c winrm set winrm/config/winrs @{MaxMemoryPerShellMB="512"} 
cmd.exe /c winrm set winrm/config @{MaxTimeoutms="1800000"} 
cmd.exe /c winrm set winrm/config/service @{AllowUnencrypted="true"} 
cmd.exe /c winrm set winrm/config/service/auth @{Basic="true"} 
sc config WinRM start= auto

netsh advfirewall firewall add rule name="WinRM-HTTP" dir=in localport=5985 protocol=TCP action=allow

reg add HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /d 0 /t REG_DWORD /f /reg:64


