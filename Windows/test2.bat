echo off
set /P c=We utilize Stahl Work's Unzip.exe to unzip files. Install now? [Y/N]?
IF /I "%c%" EQU "N" GOTO END
bitsadmin /transfer unziplicense /priority high https://raw.githubusercontent.com/SwingJS/SwingJSUtils/master/Windows/Unzip_License %THIS_DIR%\Unzip_License
bitsadmin /transfer unzip /priority high http://stahlworks.com/dev/unzip.exe %THIS_DIR%\unzip.exe
start notepad %THIS_DIR%\Unzip_License






set arg1=%1
set arg2=%2
IF %3.==. GOTO NoArg3
set arg3=%3
shift
shift
shift




IF %arg1%==swingjs GOTO PathSwing
IF %arg1%==no-swingjs GOTO PathNoSwing

:PathNoSwing
REM  figure out if they already have Eclipse installed
IF NOT EXIST %arg3%\eclipse GOTO PathNoSwingNoEclipse
IF EXIST %arg3%\eclipse GOTO PathNoSwingEclipse

:PathSwing
IF NOT EXIST %arg3%\eclipse GOTO PathSwingNoEclipse
IF EXIST %arg3%\eclipse GOTO PathSwingEclipse



:NoArg3
shift
shift
IF %arg1%==swingjs GOTO NoPathSwing
IF %arg1%==no-swingjs GOTO NoPathNoSwing

:NoPathNoSwing
REM  figure out if they already have Eclipse installed
IF NOT EXIST %THIS_DIR%\eclipse GOTO NoPathNoSwingNoEclipse
IF EXIST %THIS_DIR%\eclipse GOTO NoPathNoSwingEclipse


:NoPathSwing
REM  figure out if they already have Eclipse installed
IF NOT EXIST %THIS_DIR%\eclipse GOTO NoPathSwingNoEclipse
IF EXIST %THIS_DIR%\eclipse GOTO NoPathSwingEclipse







:NoPathNoSwingNoEclipse
java -d64 -version 2>&1
IF errorlevel 1 GOTO NoPathNoSwingNoEclipse32Bit
GOTO NoPathNoSwingNoEclipse64Bit

:NoPathSwingNoEclipse
java -d64 -version 2>&1
IF errorlevel 1 GOTO NoPathNoSwingNoEclipse32Bit
GOTO NoPathNoSwingNoEclipse64Bit

:PathNoSwingNoEclipse
java -d64 -version 2>&1
IF errorlevel 1 GOTO PathNoSwingNoEclipse32Bit
GOTO PathNoSwingNoEclipse32Bit

:PathSwingNoEclipse
java -d64 -version 2>&1
IF errorlevel 1 GOTO PathSwingNoEclipse32Bit
GOTO PathSwingNoEclipse32Bit















:NoPathNoSwingEclipse
bitsadmin /transfer swingversion /priority high https://raw.githubusercontent.com/SwingJS/SwingJSUtils/master/latestj2s %THIS_DIR%\swingversion
set /p J2SV=<swingversion

:NoPathSwingEclipse
bitsadmin /transfer swingversion /priority high https://sourceforge.net/p/swingjs/code/HEAD/tree/trunk/src/SwingJS.properties?format=raw" %THIS_DIR\swingversion
for /F "delims=" %%a in ('findstr /I "J2Score_Version" %THIS_DIR%\swingversion') do set "LINE=%%a"


:PathNoSwingEclipse
bitsadmin /transfer swingversion /priority high https://raw.githubusercontent.com/SwingJS/SwingJSUtils/master/latestj2s %THIS_DIR%\swingversion
set /p J2SV=<swingversion
:PathSwingEclipse
bitsadmin /transfer swingversion /priority high https://raw.githubusercontent.com/SwingJS/SwingJSUtils/master/latestj2s %THIS_DIR%\swingversion
set /p J2SV=<swingversion





:NoPathNoSwingNoEclipse64Bit
:NoPathNoSwingNoEclipse32Bit
where java >nul 2>&1
IF errorlevel 1 GOTO  NOJAVA

:NoPathSwingNoEclipse64Bit
:NoPathSwingNoEclipse32Bit
where java >nul 2>&1
IF errorlevel 1 GOTO  NOJAVA

:PathNoSwingNoEclipse64Bit
:PathNoSwingNoEclipse32Bit
where java >nul 2>&1
IF errorlevel 1 GOTO  NOJAVA

:PathSwingNoEclipse64Bit
:PathSwingNoEclipse32Bit
where java >nul 2>&1
IF errorlevel 1 GOTO  NOJAVA











:NOJAVA
echo No Java Installed. Please install Java first
GOTO END

:END
