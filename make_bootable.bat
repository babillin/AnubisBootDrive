@echo off
rem v1.0 Script to make the USB Flash device from which this is run bootable.
rem v1.1 Priviledge check code contributed by forum member "Spectrum"
rem v1.2 Include 'f' switch to syslinux invokation to handle devices not marked "removeable"

echo Make Bootable v1.2

ATTRIB %windir%\system32 -h | FINDSTR /I "denied" >nul
IF NOT ERRORLEVEL 1 (
	ECHO.
	ECHO This script must be run as an Administrator.
	ECHO.
	ECHO Right click and select 'Run as administrator' or execute
	ECHO from an elevated command prompt.
	ECHO.
	GOTO exit
)

rem Output volume information
vol %~d0

rem Find the volume label
for /f "tokens=1-5*" %%1 in ('vol %~d0') do (
  set label=%%6
  goto checkit
)

:checkit
if "%label%"=="UNRAID" goto valid
echo Error: volume label must be UNRAID
goto exit

:valid
pause
echo %~d0\syslinux\syslinux.exe -maf %~d0
%~d0\syslinux\syslinux.exe -maf %~d0
echo Completed

:exit
pause
