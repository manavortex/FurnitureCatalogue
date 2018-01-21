@echo off
set dest=%USERPROFILE%\Dropbox
set programlocation="C:\Program Files\7-Zip\7z.exe"
REM "C:\Program Files (x86)\WinRAR\Rar.exe"
for %%* in (.) do set CurrDirName=%%~nx*
for %%i in ("%~dp0..") do set "parentfolder=%%~fi"
REM echo %CurrDirName%
set versionNo=
for /F "tokens=1,2,3" %%i in (%CurrDirName%.txt) do call :process %%i %%j %%k
call :zipfile

:process
	set str1=%2	
	if not x%str1:Version=%==x%str1% (
		if x%str1:API=%==x%str1% (
			set versionNo=%3
		)
	)
goto :EOF


:zipfile
	set destzipname=%dest%\%CurrDirName%.%versionNo%.zip
	del "%destzipname%"
	%programlocation% a -tzip -r %destzipname%  "%parentfolder%\%CurrDirName%" "-x!*.bat" "-x!*.ps1" "-x!.git*"
	goto :EOF


REM COMMANDS TO PROCESS INFORMATION
goto :EOF