@echo off
setlocal

:: Set version number (must match the .nsi script)
set VERSION=1.2.3

:: Folder and file names
set NSIS_SCRIPT=PlayzDownloader.nsi
set OUTPUT_DIR=NSIS-Installer-Output
set OUTPUT_FILE=PlayzDownloaderInstaller_v%VERSION%.exe

:: Create output directory if it doesn't exist
if not exist "%OUTPUT_DIR%" (
    mkdir "%OUTPUT_DIR%"
    echo Created output folder: %OUTPUT_DIR%
)

:: Compile using makensis
echo Compiling %NSIS_SCRIPT%...
"C:\Program Files (x86)\NSIS\makensis.exe" %NSIS_SCRIPT%

:: Check result
if exist "%OUTPUT_DIR%\%OUTPUT_FILE%" (
    echo.
    echo Installer successfully created: %OUTPUT_DIR%\%OUTPUT_FILE%
) else (
    echo.
    echo ERROR: Installer failed to compile.
)

endlocal
pause
