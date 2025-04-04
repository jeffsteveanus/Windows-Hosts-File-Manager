@echo off
color 0a
title Hosts File Manager
cls

>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else (
    goto gotAdmin
)

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /b

:gotAdmin

:menu
echo.
echo Hosts File Manager
echo ------------------
echo 1. Add Entry
echo 2. Search Entry
echo 3. Search and Replace Entry
echo 4. Search and Remove Entry
echo 5. Backup Hosts File
echo 6. Reset Hosts File
echo 7. Exit
echo.
set /p choice="Enter your choice: "

if "%choice%"=="1" goto :add_entry
if "%choice%"=="2" goto :search_entry
if "%choice%"=="3" goto :replace_entry
if "%choice%"=="4" goto :remove_entry
if "%choice%"=="5" goto :backup_hosts
if "%choice%"=="6" goto :reset_hosts
if "%choice%"=="7" goto :exit
echo Invalid choice. Please try again.
pause
goto :menu

:add_entry
echo.
set /p ip_address="Enter IP Address to add: "
set /p url_to_add="Enter URL to add: "
echo %ip_address% %url_to_add% >> %SystemRoot%\System32\drivers\etc\hosts
echo Entry added successfully!
pause
goto :menu

:search_entry
echo.
set /p search_url="Enter URL to search for: "
findstr /i "%search_url%" %SystemRoot%\System32\drivers\etc\hosts
echo.
pause
goto :menu

:replace_entry
echo.
set /p search_url_replace="Enter URL to search and replace: "
set /p new_ip_address="Enter new IP Address: "
set /p new_url="Enter new URL: "
set "temp_file=%TEMP%\hosts_temp.txt"
(for /f "usebackq delims=" %%a in ("%SystemRoot%\System32\drivers\etc\hosts") do (
    echo %%a | findstr /i "%search_url_replace%" >nul
    if errorlevel 1 (
        echo %%a
    ) else (
        echo %new_ip_address% %new_url%
    )
)) > "%temp_file%"
move /y "%temp_file%" "%SystemRoot%\System32\drivers\etc\hosts" >nul
echo Entry replaced successfully!
pause
goto :menu

:remove_entry
echo.
set /p remove_url="Enter URL to remove: "
set "temp_file=%TEMP%\hosts_temp.txt"
(for /f "usebackq delims=" %%a in ("%SystemRoot%\System32\drivers\etc\hosts") do (
    echo %%a | findstr /i "%remove_url%" >nul
    if errorlevel 1 (
        echo %%a
    )
)) > "%temp_file%"
move /y "%temp_file%" "%SystemRoot%\System32\drivers\etc\hosts" >nul
echo Entry removed successfully!
pause
goto :menu

:backup_hosts
echo.
set "backup_path=%UserProfile%\Desktop\hosts_backup_%date:~-4,4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%%time:~6,2%.txt"
copy "%SystemRoot%\System32\drivers\etc\hosts" "%backup_path%"
echo Hosts file backed up to %backup_path%
pause
goto :menu

:reset_hosts
echo.
echo Are you sure you want to reset your hosts file? This will remove all entries.
choice /c yn /m "Confirm (y/n): "
if %errorlevel% equ 1 (
    attrib -r -s -h "%SystemRoot%\System32\drivers\etc\hosts"
    (
    ECHO # Copyright ^(c^) 1993-2009 Microsoft Corp.
    ECHO #
    ECHO # This is a sample HOSTS file used by Microsoft TCP/IP for Windows.
    ECHO #
    ECHO # This file contains the mappings of IP addresses to host names. Each
    ECHO # entry should be kept on an individual line. The IP address should
    ECHO # be placed in the first column followed by the corresponding host name.
    ECHO # The IP address and the host name should be separated by at least one
    ECHO # space.
    ECHO #
    ECHO # Additionally, comments ^(such as these^) may be inserted on individual
    ECHO # lines or following the machine name denoted by a '#' symbol.
    ECHO #
    ECHO # For example:
    ECHO #
    ECHO #      102.54.94.97     rhino.acme.com          # source server
    ECHO #       38.25.63.10     x.acme.com              # x client host
    ECHO # localhost name resolution is handled within DNS itself.
    ECHO #    127.0.0.1       localhost
    ECHO #    ::1             localhost
    ) > "%SystemRoot%\System32\drivers\etc\hosts"
    echo Hosts file reset to default.
) else (
    echo Reset cancelled.
)
pause
goto :menu

:exit
echo Exiting...
pause
exit