:: Package your ESO add-on ready for distribution.
:: Version 1.3 Sat, 14 Nov 2015 22:36:23 +0000
@echo off
setlocal enableextensions enabledelayedexpansion

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
:: variables: You can adjust the script here
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
:: Set URL of website to anything but "" to open the page after packaging is complete
REM SET ESOUI_URL=""
SET ESOUI_URL="https://www.esoui.com/downloads/editfile.php?id=1617"

:: Set target directory to anything but "" to have the script move the generated zip file there
:: !USERPROFILE! will be resolved to "C:\Users\<yourusername>
REM SET TARGET_DIRECTORY=""
SET TARGET_DIRECTORY="!USERPROFILE!\Dropbox"

:: Set github branch to anything but "" to have this script automatically push to github 
:: SET GITHUB_BRANCH=""
SET GITHUB_BRANCH="master"

set EXCLUDE_FROM_PACK=^
	Custom.lua^
	_dev_setup.cmd


:: check for existence of 7zip
set zip="%ProgramFiles%\7-Zip\7z.exe"
if not exist !zip! goto :zipnotfound

:: read addon name from manifest.txt
for %%* in (.) do set name=%%~nx*

if not exist !name!.txt (
  echo * Please enter the name of your add-on:
  set /P name=^>
)

:: read addon version from txt
for /F "tokens=3" %%i in ('findstr /C:"## Version:" !name!.txt') do set version=%%i


:: throw it on git
IF NOT !GITHUB_BRANCH! == "" (
	echo * Pushing to github branch !GITHUB_BRANCH! with commit message !VERSION!...
	git commit -am "!VERSION!"	
	git push origin %GITHUB_BRANCH:"=%
)

set archive=!name!-!version!.zip

echo * Packaging !archive!...
md .package\!name!

:: read files from manifest
set files=!name!.txt
for /F %%i in ('findstr /B /R "[^#;]" !name!.txt') do (
  set file=%%~nxi
  set files=!files! !file:$^(language^)=*!
)

:: read additional files (assets etc.) from package.manifest
if exist package.manifest (
  for /F "tokens=*" %%i in (package.manifest) do (
    set files=!files! %%~nxi
  )
)

:: copy everything to assembly folder
robocopy . .package\!name! !files! /S /XD .* /NJH /NJS /NFL /NDL > nul


:: zip it
pushd .package 
for  %%A in (!EXCLUDE_FROM_PACK!) do (
	if exist "%%A"
	del /S "%%A"
)

!zip! a -tzip -bd ..\!archive! !name! > nul
popd

rd /S /Q .package

IF NOT !TARGET_DIRECTORY! == "" (
	echo * Moving !archive! to !TARGET_DIRECTORY!...
	move /Y !archive! !TARGET_DIRECTORY!
)

:: open it in default browser
IF NOT !ESOUI_URL! == "" rundll32 url.dll,FileProtocolHandler !ESOUI_URL!

echo * Done^^!
echo.

pause
exit /B

:zipnotfound
echo 7-Zip cannot be found, get it free at http://www.7-zip.org
pause
exit /B
