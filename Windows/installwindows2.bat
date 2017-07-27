echo off
set /P c=We utilize Stahl Work's Unzip.exe to unzip files. Install now? [Y/N]?
IF /I "%c%" EQU "N" GOTO END
bitsadmin /transfer unziplicense /priority high https://raw.githubusercontent.com/SwingJS/SwingJSUtils/master/Windows/Unzip_License %THIS_DIR%\Unzip_License
bitsadmin /transfer unzip /priority high http://stahlworks.com/dev/unzip.exe %THIS_DIR%\unzip.exe
start notepad %THIS_DIR%\Unzip_License

set arg1=%1
set arg2=%2

IF "%~3" == "" GOTO EMPTYARG3 REM If argument 3 is empty, then user said ___ -version, and just wants to know the version of what they installed
IF EXIST %3\* GOTO PATHARG3 REM If argument 3 is a path, user said ___ -version path, and just wants to know the version of what they installed at "path"

:EMPTYARG3
echo "EMPTY ARG 3"

:PATHARG3
echo "PATH ARG 3"
