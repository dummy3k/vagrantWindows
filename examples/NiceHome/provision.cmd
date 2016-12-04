@echo off
cmd.exe /c choco --version 2>> %TEMP%/null
if not errorlevel 1 goto skip_choco

@powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

choco feature enable -n=allowGlobalConfirmation
choco install hashtab notepadplusplus 

:skip_choco
