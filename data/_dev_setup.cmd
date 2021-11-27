@echo off
setlocal enabledelayedexpansion 

WHERE git
IF %ERRORLEVEL% NEQ 0 (
	ECHO You need to install git. Please get it from https://git-scm.com/downloads and add it to Windows PATH variable.
	goto :EOF
)

IF not exist "C:\Program Files\SmartGit" (
	ECHO No installation of SmartGit was found. 
	ECHO If you installed it elsewhere or know what you're doing, you're fine.
	echo Otherwise, please install it from https://www.syntevo.com/smartgit/download/
)

if not exist "..\..\sidTools" (
	echo Please install the AddOn "sidTools" from esoui: https://www.esoui.com/downloads/info1210-sidTools.html
	echo It needs to be in the same directory as FurnitureCatalogue ^(%USERPROFILE%\Documents\Elder Scrolls Online\live\AddOns^)
	echo for this script to work.
	goto :EOF
) else (
	echo.
	echo AddOn sidTools found.
	echo.
	echo We need to add a bit of code to one of sirinsidiator's AddOns now.
	echo If the file already exists and you don't want to overwrite, please append the code from "_SidTools_Custom.lua" to it.
	echo Without doing this, the slash command will not work.
	Move /-Y .\_SidTools_Custom.lua "..\..\sidTools\Custom.lua"
	echo.
)

if not exist "..\..\LibDebugLogger" (
	echo AddOn LibDebugLogger not found. 
	echo I strongly recommend installing it: https://www.esoui.com/downloads/info2275-LibDebugLogger.html
	echo You probably already have it, a lot of AddOns pack it as a dependency. Make sure it is enabled.
) else (
	echo AddOn LibDebugLogger found. Make sure that you keep it loaded in case you run into errors!
)

if not exist "..\..\DebugLogViewer" (
	echo.
	echo AddOn DebugLogViewer not found.
	echo I strongly recommend installing it: https://www.esoui.com/downloads/info2389-DebugLogViewer.html
	echo Without this, finding any kind of error will be a pain in the ass.
) else (
	echo AddOn DebugLogViewer found. Make sure that you keep it loaded in case you run into errors!
)

if not exist "..\..\ZAM_Notebook" (
	echo.
	echo AddOn ZAM Notebook not found.
	echo I recommend installing it: https://www.esoui.com/downloads/info244-ZAMNotebook.html
	echo It lets you run LUA code straight from ESO, which will help you for assisted debugging.
) 

echo.
echo This file is your playground so you can fuck around and find out. 
if exist ".\Custom.lua" (
	echo If you overwrite it, you will lose any changes you have made.
)
Move /-Y ".\Custom_Example.lua" ".\Custom.lua"
echo.
echo Congratulations, you're all set up.

endlocal
