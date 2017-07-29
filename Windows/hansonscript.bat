@echo off
rem installSwingJS.bat eclipse|swingjs [-ver [latest|3.1.1|etc...]] [-dir directory] [-32|-64]
SET PROG=INSTALL-help
SET VERSION=latest
SET LATEST_ECLIPSE=oxygen
SET DIRECTORY=
SET WIN=64
SET UNZIPEXE=unzip
SET WORKINGDIR=%USERPROFILE%
SET UNZIPSOURCE=http://stahlworks.com/dev/unzip.exe

SET LATESTLINK64 "http://eclipse.mirror.rafal.ca/technology/epp/downloads/release/oxygen/R/eclipse-java-oxygen-R-win32-x86_64.zip" REM will need to be updated accordingly
SET LATESTLINK32 "http://mirror.csclub.uwaterloo.ca/eclipse/technology/epp/downloads/release/oxygen/R/eclipse-java-oxygen-R-win32.zip" REM will need to be updated accordingly

SET OXYGENLINK64 "http://eclipse.mirror.rafal.ca/technology/epp/downloads/release/oxygen/R/eclipse-java-oxygen-R-win32-x86_64.zip"
SET OXYGENLINK32 "http://mirror.csclub.uwaterloo.ca/eclipse/technology/epp/downloads/release/oxygen/R/eclipse-java-oxygen-R-win32.zip"
SET NEONLINK64 "http://mirror.csclub.uwaterloo.ca/eclipse/technology/epp/downloads/release/neon/3/eclipse-java-neon-3-win32-x86_64.zip"
SET NEONLINK32 "http://mirror.csclub.uwaterloo.ca/eclipse/technology/epp/downloads/release/neon/3/eclipse-java-neon-3-win32.zip"
SET MARSLINK64 "http://mirror.csclub.uwaterloo.ca/eclipse/technology/epp/downloads/release/mars/2/eclipse-java-mars-2-win32-x86_64.zip"
SET MARSLINK32 "http://eclipse.mirror.rafal.ca/technology/epp/downloads/release/mars/2/eclipse-java-mars-2-win32.zip"
SET LUNALINK64 "http://mirror.csclub.uwaterloo.ca/eclipse/technology/epp/downloads/release/luna/SR2/eclipse-java-luna-SR2-win32-x86_64.zip"
SET LUNALINK32 "http://mirror.cc.vt.edu/pub/eclipse/technology/epp/downloads/release/luna/SR2/eclipse-java-luna-SR2-win32.zip"
SET KEPLERLINK64 "http://mirror.csclub.uwaterloo.ca/eclipse/technology/epp/downloads/release/kepler/SR2/eclipse-java-kepler-SR2-win32-x86_64.zip"
SET KEPLERLINK32 "http://eclipse.mirror.rafal.ca/technology/epp/downloads/release/kepler/SR2/eclipse-java-kepler-SR2-win32.zip"
SET JUNOLINK64 "http://mirror.math.princeton.edu/pub/eclipse//technology/epp/downloads/release/juno/SR2/eclipse-java-juno-SR2-win32-x86_64.zip"
SET JUNOLINK32 "http://mirror.math.princeton.edu/pub/eclipse//technology/epp/downloads/release/juno/SR2/eclipse-java-juno-SR2-win32.zip"


SET /P c=We utilize Stahl Work's Unzip.exe to unzip files. Install now? [Y/N]?
IF /I "%c%" EQU "N" GOTO END
bitsadmin /transfer unziplicense /priority high https://raw.githubusercontent.com/SwingJS/SwingJSUtils/master/Windows/Unzip_License %cd%\Unzip_License
bitsadmin /transfer unzip /priority high http://stahlworks.com/dev/unzip.exe %cd%\\stahworksunzip.exe
start notepad %cd%\Unzip_License




GOTO CHECKPOWERSHELL

rem process command line variables

:NEXT
SHIFT
:LOOP
if "%1%"=="" GOTO DONE
if %1%==-ver GOTO VERSION
if %1%==-dir GOTO DIRECT
if %1%==-32 GOTO WIN32
if %1%==-64 GOTO WIN64
SET PROG=INSTALL%1%
GOTO NEXT

:VERSION
SHIFT
SET VERSION=%1%
GOTO NEXT

:DIRECT
SHIFT
SET DIRECTORY=%1%
GOTO NEXT

:WIN64
SET WIN=64
GOTO NEXT

:WIN32
SET WIN=32
GOTO NEXT

:DONE

rem now do the installation or version checking

if "%PROG%"=="INSTALLECLIPSE" GOTO CHECKJAVA
rem if "%PROG%"=="INSTALLj2s" GOTO CHECKUNZIP
if "%PROG%"=="INSTALLSWINGJS" GOTO CHECKUNZIP
GOTO HELP

:INSTALLECLIPSE
rem Install Eclipse. The unzipping will create its own eclipse directory
if "%DIRECTORY%"=="" SET DIRECTORY=.
if "%VERSION%"=="" GOTO INSTALLECLIPSECHECKVERSION
if %VERSION%==latest SET VERSION=%LATEST_ECLIPSE%
echo %PROG% -ver %VERSION% -%WIN% -dir %DIRECTORY%
SET TARGET=%WORKINGDIR%\eclipse-%VERSION%-%WIN%.zip
if not exist %TARGET% (
  if WIN==64 SET WIN=32-x86_64
  SET DOWNLOAD=http://eclipse.mirror.rafal.ca/technology/epp/downloads/release/%VERSION%/R/eclipse-cpp-%VERSION%-R-win%WIN%.zip
  powershell -Command (new-object System.Net.WebClient).DownloadFile('%DOWNLOAD%','%TARGET%')
)
echo unzipping %TARGET% into %DIRECTORY%
%UNZIPEXE% %TARGET% -d %DIRECTORY%
:INSTALLECLIPSECHECKVERSION
type %DIRECTORY%\eclipse\.eclipseProduct
GOTO END

:INSTALLSWINGJS
rem Install SwingJS in the eclipse plugins directory
rem Q: Should we delete all net.sf.j2s files there first?
rem Unfortunately "latest" tag will not work
GOTO CHECKECLIPSEDIR
:INSTALLSWINGJSOK
SET DIRECTORY=%DIRECTORY%\dropins
if "%VERSION%"=="" GOTO INSTALLSWINGJSCHECKVERSION
echo %PROG% -ver %VERSION% -dir %DIRECTORY%
SET TARGET=%DIRECTORY%\SwingJS_full.zip
if %VERSION%==latest (
  SET DIR=trunk
) else (
  SET DIR=tags/%VERSION%
)
SET DOWNLOAD=https://sourceforge.net/p/swingjs/code/HEAD/tree/%DIR%/dist/SwingJS_full.zip?format=raw
powershell -Command (new-object System.Net.WebClient).DownloadFile('%DOWNLOAD%','%TARGET%')
echo unzipping %TARGET% into %DIRECTORY%
%UNZIPEXE% %TARGET% -d %DIRECTORY%
:INSTALLSWINGJSCHECKVERSION
type %DIRECTORY%\readme*.properties|find "J2S."
GOTO END

:CHECKPOWERSHELL
rem Check to see that we can use PowerShell
where powershell >nul 2>&1
IF not errorlevel 1 GOTO LOOP 
echo You need PowerShell to use this installation script
GOTO END

:CHECKUNZIP
rem Check to see that we have unzip.exe installed
if "%VERSION%"=="" GOTO %PROG%
echo... checking for UNZIP.EXE
where %UNZIPEXE% >nul 2>&1
IF not errorlevel 1 GOTO %PROG%
SET /P c=We utilize GNU unzip.exe to unzip files. Install now? [Y/N]?
IF /I "%c%" EQU "N" GOTO END
echo installing GNU unzip.exe
SET TARGET=%WORKINGDIR%\unzip_installer.exe
powershell -Command (new-object System.Net.WebClient).DownloadFile('%UNZIPSOURCE%','%TARGET%')
%TARGET%
SET UNZIPEXE=unzip.exe
GOTO %PROG%

:CHECKJAVA
rem Check to see that we have Java, and what version it is
where java >nul 2>&1
IF not errorlevel 1 GOTO CHECKJAVA64
echo No Java installed. Please install Java first
GOTO END
:CHECKJAVA64
java -d64 -version >nul 2>&1
IF errorlevel 1 SET WIN=32
GOTO CHECKUNZIP

:CHECKECLIPSEDIR
rem Check to see that we have eclipse in the designated directory or its eclipse subdirectory
if "%DIRECTORY%"=="" SET DIRECTORY=.
if exist %DIRECTORY%\eclipse.exe GOTO %PROG%OK
SET DIRECTORY=%DIRECTORY%\eclipse
if exist %DIRECTORY%\eclipse.exe GOTO %PROG%OK
echo eclipse.exe was not found in %DIRECTORY%
GOTO END

:HELP
echo primary options are eclipse or swingjs
echo secondary options are -ver and -dir:
echo -ver v  version to install or just -ver to check version only
echo         for eclipse versions, use luna, mars, neon, oxygen, photon, etc.
echo -dir d  directory to install into (containing eclipse directory) -- default: current directory
echo.
echo for example:
echo.
echo    installswingjs eclipse -ver neon -dir c:\temp
echo    installswingjs swingjs -ver latest -dir c:\temp

:END
