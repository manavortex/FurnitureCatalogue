:: Package your ESO add-on ready for distribution.
:: Version 2.0 2023-05-09
@echo off
setlocal enableextensions enabledelayedexpansion

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
:: variables: You can adjust the script here
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
:: Set URL of website to anything but "" to open the page after packaging is complete
@REM SET ESOUI_URL=""
SET ESOUI_URL="https://www.esoui.com/downloads/editfile.php?id=1617"

:: Set target directory to anything but "" to have the script move the generated zip file there
:: %USERPROFILE% will be resolved to "C:\Users\<yourusername>
@REM SET TARGET_DIRECTORY=""
SET TARGET_DIRECTORY=""

:: Set github branch to anything but "" to have this script automatically push to github
@REM SET GITHUB_BRANCH="master"
SET GITHUB_BRANCH=""

:: Custom filename to be deleted, set to anything but "" to have it automatically removed from the package
@REM SET DELETE_CUSTOM_FILENAME=""
SET DELETE_CUSTOM_FILENAME="Custom.lua"

:: Path to your 7zip binary
@REM SET ZIP_PROGRAM_PATH="%ProgramFiles%\7-Zip\7z.exe"
SET ZIP_PROGRAM_PATH="%SCOOP%\apps\7zip\current\7z.exe"
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:: check for existence of 7zip
if not exist %ZIP_PROGRAM_PATH% goto :zipnotfound

:: use root folder as base
pushd ..

:: read addon name from manifest.txt
for %%* in (.) do set name=%%~nx*

if not exist %name%.txt (
  echo * Please enter the name of your add-on:
  set /P name=^>
)

:: read addon version from txt
for /F "tokens=3" %%i in ('findstr /C:"## Version:" %name%.txt') do set version=%%i

:: throw it on git
IF NOT %GITHUB_BRANCH% == "" (
	echo * Pushing to github branch %GITHUB_BRANCH% with commit message %version%...
	git commit -am "%version%"
	:: Strip ""s 
	git push origin %GITHUB_BRANCH:"=%
)

set archive=%name%-%version%.zip

echo * Packaging %archive%...
set "basefolder=.package\%name%"
md %basefolder%

:: parse and copy all files mentioned in detected AddOn manifests
for /R %%G in (*.txt) do (
  for /F "tokens=3" %%i in ('findstr /C:"## Title:" "%%G"') do (
    echo Manifest detected: "%%G"

		:: get filepath relative to manifest
		set "filepath=%%~dpG"
		set "filepath=!filepath:%CD%=!"

    :: parse file names in current AddOn manifest
    for /F %%i in ('findstr /B /R "[^#;]" "%%G"') do (
      set file=!filepath!%%i

			:: use *.lua wildcard to copy all luas from language file directory
			set file=!file:$^(language^)=*!

			:: fix slashes
			set file=!file:/=\!
			if "!file:~0,1!"=="\" set "file=!file:~1!"

			:: get directory from the file path and create it
			set "dir=!file!\.."
			set "relativedir=!basefolder!\!dir!"
      if not exist "!relativedir!" mkdir "!relativedir!"

			:: copy parsed file to the package
      copy /Y "!file!" "!basefolder!\!file!" > nul
    )
  )
)

:: move back into script directory
popd

:: copy additional files (assets etc.) from package.manifest
if exist package.manifest (
	echo package.manifest detected
  for /F "tokens=*" %%i in (package.manifest) do (
	set file=%%i

	:: get filepath relative to package.manifest
	set "filepath=%%~dpi"
	set "filepath=!filepath:%CD%=!"

	set "dir=!basefolder!\!filepath!"

	:: fix slashes
	set "file=!file:/=\!"
	if "!file:~0,1!"=="\" set "file=!file:~1!"
	set "relativedir=!dir:\\=\!"

	:: create target directory if needed
	if not exist "..\!relativedir!" mkdir "..\!relativedir!"

	:: copy parsed file to the package
	copy /Y "..\!file!" "..\!basefolder!\!file!" > nul
  )
)

:: go into base dir and save it
cd ..
pushd .package 
:: package dir and zip it
if not "%DELETE_CUSTOM_FILENAME%" == "" (
	del /S "%DELETE_CUSTOM_FILENAME%"
)

%ZIP_PROGRAM_PATH% a -tzip -bd ..\%archive% %name% > nul

:: go back into base dir and delete .package
popd
rd /S /Q .package

IF NOT %TARGET_DIRECTORY% == "" (
	echo * Moving %archive% to %TARGET_DIRECTORY%...
	move /Y %archive% %TARGET_DIRECTORY%
)

:: open it in default browser
IF NOT %ESOUI_URL% == "" rundll32 url.dll,FileProtocolHandler %ESOUI_URL%

echo * Done^^!
echo.

pause
exit /B

:zipnotfound
echo 7-Zip cannot be found, get it free at http://www.7-zip.org
pause
exit /B