@echo off
rem installSwingJS.bat eclipse|swingjs [-ver [latest|3.1.1|etc...]] [-dir directory] [-32|-64]
setlocal EnableDelayedExpansion
set UNZIPSOURCE=https://sourceforge.net/p/swingjs/code/HEAD/tree/trunk/dist/unzip-5.51-1.exe?format=raw
set LATEST_ECLIPSE=oxygen
set UNZIPEXE=unzip
set UNZIPTYPE=GNU
set WORKINGDIR=%USERPROFILE%
set OXYGEN=R
set NEON=3
set MARS=2
set LUNA=SR2
set KEPLER=SR2
set JUNO=SR2

set PROG=INSTALL-help
set VERSION=latest
set DIRECTORY=
set WIN=64

goto CHECKPOWERSHELL

rem process command line variables

:LOOP
if "%1%"=="" goto DONE
if %1%==-ver goto VERSION
if %1%==-dir goto DIRECT
if %1%==-32 goto WIN32
if %1%==-64 goto WIN64
if %1%==-stahl goto STAHL 
set PROG=INSTALL%1%
:NEXT
shift
goto LOOP

:VERSION
shift
set VERSION=%1%
goto NEXT

:DIRECT
shift
set DIRECTORY=%1%
goto NEXT

:WIN64
set WIN=64
goto NEXT

:WIN32
set WIN=32
goto NEXT

:STAHL
set UNZIPTYPE=stahl
goto NEXT

:DONE

rem now do the installation or version checking

if "%PROG%"=="INSTALLeclipse" goto CHECKJAVA
rem if "%PROG%"=="INSTALLj2s" goto CHECKUNZIP
if "%PROG%"=="INSTALLswingjs" goto CHECKUNZIP
goto HELP

:INSTALLeclipse
rem Install Eclipse. The unzipping will create its own eclipse directory
if "%DIRECTORY%"=="" set DIRECTORY=.
if "%VERSION%"=="" goto INSTALLeclipseCHECKVERSION
if %VERSION%==latest set VERSION=%LATEST_ECLIPSE%
echo %PROG% -ver %VERSION% -%WIN% -dir %DIRECTORY%
set TARGET=%WORKINGDIR%\eclipse-%VERSION%-%WIN%.zip
if exist %TARGET% goto INSTALLeclipseOK
  if %WIN%==64 set WIN=32-x86_64
  set DOWNLOAD=http://eclipse.mirror.rafal.ca/technology/epp/downloads/release/%VERSION%/!%VERSION%!/eclipse-java-%VERSION%-!%VERSION%!-win%WIN%.zip
  echo ...downloading %DOWNLOAD%
  powershell -Command (new-object System.Net.WebClient).DownloadFile('%DOWNLOAD%','%TARGET%')
:INSTALLeclipseOK
echo unzipping %TARGET% into %DIRECTORY%
%UNZIPEXE% %TARGET% -d %DIRECTORY%
:INSTALLeclipseCHECKVERSION
type %DIRECTORY%\eclipse\.eclipseProduct
GOTO END

:INSTALLswingjs
rem Install SwingJS in the eclipse plugins directory
rem Q: Should we delete all net.sf.j2s files there first?
rem Unfortunately "latest" tag will not work
goto CHECKECLIPSEDIR
:INSTALLswingjsOK
set DIRECTORY=%DIRECTORY%\dropins
if "%VERSION%"=="" goto INSTALLswingjsCHECKVERSION
echo %PROG% -ver %VERSION% -dir %DIRECTORY%
set TARGET=%DIRECTORY%\SwingJS_full.zip
if %VERSION%==latest (
  set DIR=trunk
) else (
  set DIR=tags/%VERSION%
)
set DOWNLOAD=https://sourceforge.net/p/swingjs/code/HEAD/tree/%DIR%/dist/SwingJS_full.zip?format=raw
powershell -Command (new-object System.Net.WebClient).DownloadFile('%DOWNLOAD%','%TARGET%')
echo unzipping %TARGET% into %DIRECTORY%
%UNZIPEXE% %TARGET% -d %DIRECTORY%
:INSTALLswingjsCHECKVERSION
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
if "%VERSION%"=="" goto %PROG%
echo... checking for UNZIP.EXE
where %UNZIPEXE% >nul 2>&1
IF not errorlevel 1 GOTO %PROG%

IF %UNZIPTYPE%==stahl GOTO CHECKUNZIPSTAHL
  set /P c=We utilize GNU unzip.exe to unzip files. Install now? [Y/N]?
  IF /I "%c%" EQU "N" GOTO END
  echo installing GNU unzip.exe
  set TARGET=%WORKINGDIR%\unzip_installer.exe
  powershell -Command (new-object System.Net.WebClient).DownloadFile('%UNZIPSOURCE%','%TARGET%')
  %TARGET%
goto CHECKUNZIPOK
:CHECKUNZIPSTAHL
  powershell -Command (new-object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/SwingJS/SwingJSUtils/master/Windows/Unzip_License','%cd%\Unzip_License')
  powershell -Command (new-object System.Net.WebClient).DownloadFile('http://stahlworks.com/dev/unzip.exe','unzip.exe')
  START notepad Unzip_License
:CHECKUNZIPOK
set UNZIPEXE=unzip.exe
goto %PROG%

:CHECKJAVA
rem Check to see that we have Java, and what version it is
where java >nul 2>&1
IF not errorlevel 1 GOTO CHECKJAVA64
echo No Java installed. Please install Java first
GOTO END
:CHECKJAVA64
java -d64 -version >nul 2>&1
IF errorlevel 1 set WIN=32
goto CHECKUNZIP

:CHECKECLIPSEDIR
rem Check to see that we have eclipse in the designated directory or its eclipse subdirectory
if "%DIRECTORY%"=="" set DIRECTORY=.
if exist %DIRECTORY%\eclipse.exe goto %PROG%OK
set DIRECTORY=%DIRECTORY%\eclipse
if exist %DIRECTORY%\eclipse.exe goto %PROG%OK
echo eclipse.exe was not found in %DIRECTORY%
goto END

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
