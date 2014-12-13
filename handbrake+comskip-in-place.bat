@echo off
setlocal enabledelayedexpansion
set "file-ext=%1"
set "startdir=%2"
set "comskip=start /B /WAIT /D "%HOMEDRIVE%\Program Files (x86)\NPVR\" comskip.exe"
set "hb-ex=start /B /WAIT /D "%HOMEDRIVE%\Program Files\Handbrake" HandBrakeCLI.exe"
set "hb-args=--large-file --optimize -e x264 -q 22 --x264-tune fastdecode --maxWidth 1280 --maxHeight 720 --cfr -B 128"

for /r %startdir% %%i in (*.%file-ext%) do (
	set "inputtemp=%%i"
	set "subname=!inputtemp:~0,-3!"
	set "input="%%i""
	set "output="!subname!m4v""
	set "transcode=%hb-ex% -i !input! -o !output! %hb-args% > NUL 2>&1"
	!transcode!
	if errorlevel 1 do exit
	%comskip% !output!
	rem del /F !input!
)
endlocal
