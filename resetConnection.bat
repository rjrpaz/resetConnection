@echo off
set RUNDIR=C:\Users\stick new\Desktop\resetConnection

set LOG="%RUNDIR%\resetConnection.log"
set DELAY=10
set TESTINGHOST=10.0.0.1

echo %DATE% %TIME% >> %LOG%

REM Connectivity test
"%RUNDIR%\fping.exe" %TESTINGHOST% >nul

REM echo %ERRORLEVEL%

IF ERRORLEVEL 1 (
goto :RECONNECT
) ELSE (
goto :SUCCESS
)


:RECONNECT
REM Reconnect interface
echo No connectivity with %TESTINGHOST%  >> %LOG%

echo Disabling interface  >> %LOG%
netsh interface set interface "Wi-Fi" disabled

timeout -T %DELAY% /NOBREAK >nul

echo Enabling interface  >> %LOG%
netsh interface set interface "Wi-Fi" enabled
goto :END

:SUCCESS
echo OK >> %LOG%

:END
echo. >> %LOG%
