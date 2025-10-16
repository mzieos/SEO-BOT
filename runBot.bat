@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
title Web Traffic Bot Launcher

set "PROJECT_ROOT=G:\GitHubRep\SEO_BOT"
set "REQUIREMENTS_PATH=%PROJECT_ROOT%\source\requirements.txt"
set "BOT_SCRIPT_PATH=%PROJECT_ROOT%\source\SEO_BOT.py"
set "CUSTOMIZE_DIR=%PROJECT_ROOT%\customize"
set "PYTHON_VERSION=3.11.4"
set "PYTHON_URL=https://www.python.org/ftp/python/%PYTHON_VERSION%/python-%PYTHON_VERSION%-amd64.exe"
set "PYTHON_INSTALLER=python_installer.exe"
set "TEMP_DIR=%TEMP%\web_SEO_BOT_setup"
set "LOG_FILE=%TEMP_DIR%\installation.log"

echo ========================================
echo    Web Traffic Bot Launcher
echo ========================================
echo.

REM Create temp directory for logs and downloads
if not exist "%TEMP_DIR%" (
    mkdir "%TEMP_DIR%" >nul 2>&1
    if errorlevel 1 (
        echo ERROR: Cannot create temporary directory: %TEMP_DIR%
        pause
        exit /b 1
    )
)

REM Function to log messages
set "LOG=>> "%LOG_FILE%" 2>&1 echo [%date% %time%]"
%LOG% Starting Web Traffic Bot Launcher

REM Check if project structure exists
echo Checking project structure...
if not exist "%PROJECT_ROOT%" (
    echo ERROR: Project root not found: %PROJECT_ROOT%
    %LOG% ERROR: Project root not found
    pause
    exit /b 1
)

REM Check if required files exist
echo Checking required files...
if not exist "%REQUIREMENTS_PATH%" (
    echo ERROR: Requirements file not found at: %REQUIREMENTS_PATH%
    %LOG% ERROR: Requirements file not found
    pause
    exit /b 1
)

if not exist "%BOT_SCRIPT_PATH%" (
    echo ERROR: Bot script not found at: %BOT_SCRIPT_PATH%
    %LOG% ERROR: Bot script not found
    pause
    exit /b 1
)

REM Check if customize folder and files exist
echo Checking configuration files...
if not exist "%CUSTOMIZE_DIR%\" (
    echo ERROR: Customize folder not found at: %CUSTOMIZE_DIR%
    echo Please create the customize folder with urls.txt and spend_time.txt
    %LOG% ERROR: Customize folder not found
    pause
    exit /b 1
)

if not exist "%CUSTOMIZE_DIR%\urls.txt" (
    echo ERROR: urls.txt not found in customize folder
    echo Please create %CUSTOMIZE_DIR%\urls.txt with your target URLs
    %LOG% ERROR: urls.txt not found
    pause
    exit /b 1
)

if not exist "%CUSTOMIZE_DIR%\spend_time.txt" (
    echo ERROR: spend_time.txt not found in customize folder
    echo Please create %CUSTOMIZE_DIR%\spend_time.txt with visit duration in seconds
    %LOG% ERROR: spend_time.txt not found
    pause
    exit /b 1
)

echo Required files and folders found.
%LOG% Project structure verified

REM Check if Python is installed and accessible
echo Checking Python installation...
python --version >nul 2>&1
set "PYTHON_CHECK=%errorlevel%"

if !PYTHON_CHECK! equ 0 (
    for /f "tokens=*" %%i in ('python --version 2^>^&1') do set "PYTHON_VERSION_INSTALLED=%%i"
    echo Python found: !PYTHON_VERSION_INSTALLED!
    %LOG% Python found: !PYTHON_VERSION_INSTALLED!
    goto INSTALL_REQUIREMENTS
)

echo Python not found in PATH or not installed.
%LOG% Python not found in PATH

REM Python installation section
echo.
echo ========================================
echo        Python Installation Required
echo ========================================
echo.

REM Check internet connectivity
echo Checking internet connectivity...
%LOG% Checking internet connectivity...
powershell -Command "Test-NetConnection -ComputerName www.google.com -Port 80 -InformationLevel Quiet" >nul 2>&1

if errorlevel 1 (
    echo ERROR: No internet connection detected.
    echo Please check your network connection and try again.
    %LOG% ERROR: No internet connection
    pause
    exit /b 1
)

echo Internet connection available.
%LOG% Internet connection verified

REM Download Python installer with retry mechanism
echo Downloading Python %PYTHON_VERSION% installer...
%LOG% Starting Python installer download
set "DOWNLOAD_ATTEMPTS=0"
set "MAX_DOWNLOAD_ATTEMPTS=3"

:DOWNLOAD_RETRY
set /a DOWNLOAD_ATTEMPTS+=1
echo Download attempt !DOWNLOAD_ATTEMPTS! of !MAX_DOWNLOAD_ATTEMPTS!...

if exist "%PYTHON_INSTALLER%" (
    del "%PYTHON_INSTALLER%" >nul 2>&1
    timeout /t 1 >nul
)

powershell -Command "$ProgressPreference = 'SilentlyContinue'; try { Invoke-WebRequest -Uri '%PYTHON_URL%' -OutFile '%PYTHON_INSTALLER%' -UserAgent 'Mozilla/5.0' -TimeoutSec 30; exit 0 } catch { exit 1 }"

if errorlevel 1 (
    echo Download failed (Attempt !DOWNLOAD_ATTEMPTS!).
    
    if !DOWNLOAD_ATTEMPTS! lss !MAX_DOWNLOAD_ATTEMPTS! (
        echo Retrying in 5 seconds...
        timeout /t 5 >nul
        goto DOWNLOAD_RETRY
    ) else (
        echo ERROR: Failed to download Python installer after !MAX_DOWNLOAD_ATTEMPTS! attempts.
        echo Please check your internet connection or download Python manually from:
        echo https://www.python.org/downloads/
        %LOG% ERROR: Python download failed after multiple attempts
        pause
        exit /b 1
    )
)

echo Download completed successfully.
%LOG% Python installer downloaded successfully

REM Verify downloaded file
echo Verifying downloaded file...
if not exist "%PYTHON_INSTALLER%" (
    echo ERROR: Downloaded file not found.
    %LOG% ERROR: Downloaded file not found
    pause
    exit /b 1
)

for /f %%i in ('dir /b "%PYTHON_INSTALLER%" ^| find /c /v ""') do set "FILE_SIZE=%%i"
if "!FILE_SIZE!"=="0" (
    echo ERROR: Downloaded file is empty.
    del "%PYTHON_INSTALLER%" >nul 2>&1
    %LOG% ERROR: Downloaded file is empty
    pause
    exit /b 1
)

echo File verified (!FILE_SIZE! bytes).
%LOG% Installer file verified: !FILE_SIZE! bytes

REM Install Python
echo.
echo Installing Python %PYTHON_VERSION%...
echo IMPORTANT: In the Python installer, please CHECK "Add Python to PATH"!
echo.
echo Installation in progress... This may take a few minutes.
%LOG% Starting Python installation

start /wait "" "%PYTHON_INSTALLER%" /quiet InstallAllUsers=1 PrependPath=1 Include_test=0

set "INSTALL_RESULT=%errorlevel%"

REM Clean up installer
if exist "%PYTHON_INSTALLER%" (
    del "%PYTHON_INSTALLER%" >nul 2>&1
    %LOG% Installer file cleaned up
)

if !INSTALL_RESULT! neq 0 (
    echo ERROR: Python installation failed with error code: !INSTALL_RESULT!
    echo Please install Python manually from https://www.python.org/
    %LOG% ERROR: Python installation failed with code: !INSTALL_RESULT!
    pause
    exit /b 1
)

echo Python installation completed successfully.
%LOG% Python installation completed

REM Verify Python installation after install
echo Verifying Python installation...
timeout /t 3 >nul
python --version >nul 2>&1

if errorlevel 1 (
    echo WARNING: Python installed but not detected in PATH.
    echo This script will now close. Please:
    echo 1. Restart your command prompt
    echo 2. Run this script again
    %LOG% WARNING: Python installed but not in PATH
    echo.
    echo Press any key to exit...
    pause >nul
    exit /b 0
)

for /f "tokens=*" %%i in ('python --version 2^>^&1') do set "PYTHON_VERSION_NEW=%%i"
echo Python verified: !PYTHON_VERSION_NEW!
%LOG% Python verified: !PYTHON_VERSION_NEW!

:INSTALL_REQUIREMENTS
echo.
echo ========================================
echo    Installing Python Requirements
echo ========================================
echo.

REM Check if pip is available
pip --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: pip not found. Please ensure Python installation includes pip.
    %LOG% ERROR: pip not found
    pause
    exit /b 1
)

echo Installing packages from requirements.txt...
%LOG% Starting requirements installation
pip install --upgrade pip >nul 2>&1

echo Installing required packages...
pip install -r "%REQUIREMENTS_PATH%"

if errorlevel 1 (
    echo ERROR: Failed to install some requirements.
    echo Please check the requirements.txt file and your internet connection.
    %LOG% ERROR: Requirements installation failed
    echo.
    echo You can try installing manually with: pip install -r "%REQUIREMENTS_PATH%"
    pause
    exit /b 1
)

echo Requirements installed successfully.
%LOG% Requirements installed successfully

REM Display configuration info
echo.
echo ========================================
echo    Configuration Summary
echo ========================================
echo Project Root:    %PROJECT_ROOT%
echo Bot Script:      %BOT_SCRIPT_PATH%
echo Customize Files: %CUSTOMIZE_DIR%
echo Logs Directory:  %PROJECT_ROOT%\Logs
echo.

REM Verify configuration files content
echo Verifying configuration files...
set "URLS_COUNT=0"
for /f "usebackq delims=" %%i in ("%CUSTOMIZE_DIR%\urls.txt") do (
    if not "%%i"=="" if not "%%i"==" " (
        set /a URLS_COUNT+=1
        if !URLS_COUNT! equ 1 (
            echo First URL: %%i
        )
    )
)

set "DURATION=0"
for /f "usebackq tokens=*" %%i in ("%CUSTOMIZE_DIR%\spend_time.txt") do (
    for /f "tokens=*" %%j in ("%%i") do (
        set "DURATION=%%j"
        goto :DURATION_FOUND
    )
)
:DURATION_FOUND

echo URLs Found:      !URLS_COUNT!
echo Visit Duration:  !DURATION! seconds
echo.

REM Create Logs directory if it doesn't exist
if not exist "%PROJECT_ROOT%\Logs" (
    mkdir "%PROJECT_ROOT%\Logs" >nul 2>&1
    echo Created Logs directory
)

REM Run the bot
echo ========================================
echo    Starting Web Traffic Bot
echo ========================================
echo.
%LOG% Starting traffic bot

echo Running: python "%BOT_SCRIPT_PATH%"
echo Bot is starting... This may take a moment.
echo.

python "%BOT_SCRIPT_PATH%"

set "BOT_EXIT_CODE=%errorlevel%"
%LOG% Traffic bot exited with code: %BOT_EXIT_CODE%

echo.
if %BOT_EXIT_CODE% equ 0 (
    echo ========================================
    echo    Bot Finished Successfully!
    echo ========================================
    %LOG% Bot finished successfully
) else (
    echo ========================================
    echo    Bot Finished with Errors
    echo ========================================
    echo Exit code: %BOT_EXIT_CODE%
    %LOG% Bot finished with error code: %BOT_EXIT_CODE%
)

echo.
echo Project Location: %PROJECT_ROOT%
echo Logs Location:    %PROJECT_ROOT%\Logs
echo Configuration:    %CUSTOMIZE_DIR%
echo Installation Log: %LOG_FILE%
echo.
echo Press any key to exit...
pause >nul

REM Final cleanup
if exist "%PYTHON_INSTALLER%" (
    del "%PYTHON_INSTALLER%" >nul 2>&1
)

endlocal