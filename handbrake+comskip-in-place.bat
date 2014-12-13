@ECHO off
SETLOCAL enableDELayedexpansion
SET "file-ext=%1"
SET "startdir=%2"
SET "comskip=start /B /WAIT /D "%HOMEDRIVE%\Program Files (x86)\NPVR\" comskip.exe"
SET "hb-ex=start /B /WAIT /D "%HOMEDRIVE%\Program Files\Handbrake" HandBrakeCLI.exe"
SET "hb-args=--large-file --optimize -e x264 -q 22 --x264-tune fastdecode --maxWidth 1280 --maxHeight 720 --cfr -B 128"

FOR /r %startdir% %%i IN (*.%file-ext%) DO (
	SET "inputtemp=%%i"
	SET "subname=!inputtemp:~0,-3!"
	SET "input="%%i""
	SET "output="!subname!m4v""
	SET "transcode=%hb-ex% -i !input! -o !output! %hb-args% > NUL 2>&1"
	!transcode!
	IF ERRORLEVEL 1 EXIT
	%comskip% !output!
	rem IF ERRORLEVEL 1 EXIT	
	rem DEL !input!
	rem IF ERRORLEVEL 1 EXIT	
	rem DEL "!subname!nfo"
)
ENDLOCAL
