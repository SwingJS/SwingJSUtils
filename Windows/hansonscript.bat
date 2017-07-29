@echo off
REM installSwingJS.bat eclipse|swingjs [-ver [latest|3.1.1|etc...]] [-dir directory] [-32|-64]
SET PROG=INSTALL-help
SET VERSION=latest
SET LATEST_ECLIPSE=oxygen
SET DIRECTORY=
SET WIN=64
SET UNZIPEXE=stahlworksunzip.exe
SET WORKINGDIR=%USERPROFILE%
SET UNZIPSOURCE=http://stahlworks.com/dev/unzip.exe

SET LATESTLINK64=http://eclipse.mirror.rafal.ca/technology/epp/downloads/release/oxygen/R/eclipse-java-oxygen-R-win32-x86_64.zip REM will need to be updated accordingly
SET LATESTLINK32=http://mirror.csclub.uwaterloo.ca/eclipse/technology/epp/downloads/release/oxygen/R/eclipse-java-oxygen-R-win32.zip REM will need to be updated accordingly

SET PHOTONLINK64=REM ADD LINK HERE WHEN PHOTON COMES OUT
SET PHOTONLINK32=REM ADD LINK HERE WHEN PHOTON COMES OUT
SET OXYGENLINK64=http://eclipse.mirror.rafal.ca/technology/epp/downloads/release/oxygen/R/eclipse-java-oxygen-R-win32-x86_64.zip
SET OXYGENLINK32=http://mirror.csclub.uwaterloo.ca/eclipse/technology/epp/downloads/release/oxygen/R/eclipse-java-oxygen-R-win32.zip
SET NEONLINK64=http://mirror.csclub.uwaterloo.ca/eclipse/technology/epp/downloads/release/neon/3/eclipse-java-neon-3-win32-x86_64.zip
SET NEONLINK32=http://mirror.csclub.uwaterloo.ca/eclipse/technology/epp/downloads/release/neon/3/eclipse-java-neon-3-win32.zip
SET MARSLINK64=http://mirror.csclub.uwaterloo.ca/eclipse/technology/epp/downloads/release/mars/2/eclipse-java-mars-2-win32-x86_64.zip
SET MARSLINK32=http://eclipse.mirror.rafal.ca/technology/epp/downloads/release/mars/2/eclipse-java-mars-2-win32.zip
SET LUNALINK64=http://mirror.csclub.uwaterloo.ca/eclipse/technology/epp/downloads/release/luna/SR2/eclipse-java-luna-SR2-win32-x86_64.zip
SET LUNALINK32=http://mirror.cc.vt.edu/pub/eclipse/technology/epp/downloads/release/luna/SR2/eclipse-java-luna-SR2-win32.zip
SET KEPLERLINK64=http://mirror.csclub.uwaterloo.ca/eclipse/technology/epp/downloads/release/kepler/SR2/eclipse-java-kepler-SR2-win32-x86_64.zip
SET KEPLERLINK32=http://eclipse.mirror.rafal.ca/technology/epp/downloads/release/kepler/SR2/eclipse-java-kepler-SR2-win32.zip
SET JUNOLINK64=http://mirror.math.princeton.edu/pub/eclipse//technology/epp/downloads/release/juno/SR2/eclipse-java-juno-SR2-win32-x86_64.zip
SET JUNOLINK32=http://mirror.math.princeton.edu/pub/eclipse//technology/epp/downloads/release/juno/SR2/eclipse-java-juno-SR2-win32.zip


SET /P c=We utilize Stahl Work's Unzip.exe to unzip files. Install now? [Y/N]?
IF /I "%c%" EQU "N" GOTO END
bitsadmin /transfer unziplicense /priority high https://raw.githubusercontent.com/SwingJS/SwingJSUtils/master/Windows/Unzip_License %cd%\Unzip_License
bitsadmin /transfer unzip /priority high http://stahlworks.com/dev/unzip.exe %cd%\stahlworksunzip.exe
START notepad %cd%\Unzip_License
DEL %cd%\Unzip_License




GOTO CHECKPOWERSHELL

REM process command line variables

:NEXT
SHIFT
:LOOP
IF "%1%"=="" GOTO DONE
IF %1%==-ver GOTO VERSION
IF %1%==-dir GOTO DIRECT
IF %1%==-32 GOTO WIN32
IF %1%==-64 GOTO WIN64
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

REM now do the installation or version checking

IF "%PROG%"=="INSTALLECLIPSE" GOTO CHECKJAVA
REM IF "%PROG%"=="INSTALLj2s" GOTO %PROG%
IF "%PROG%"=="INSTALLSWINGJS" GOTO %PROG%
GOTO HELP

:INSTALLECLIPSE
REM Install Eclipse. The unzipping will create its own eclipse directory
IF "%DIRECTORY%"=="" SET DIRECTORY=.
IF "%VERSION%"=="" GOTO INSTALLECLIPSECHECKVERSION
IF %VERSION%==latest SET VERSION=%LATEST_ECLIPSE%
echo %PROG% -ver %VERSION% -%WIN% -dir %DIRECTORY%
SET TARGET=%WORKINGDIR%\eclipse-%VERSION%-%WIN%.zip
IF not exist %TARGET% (
  REM  IF WIN==64 SET WIN=32-x86_64
  REM  SET DOWNLOAD=http://eclipse.mirror.rafal.ca/technology/epp/downloads/release/%VERSION%/R/eclipse-cpp-%VERSION%-R-win%WIN%.zip
    IF [%VERSION%]==[photon] GOTO ECLIPSEPHOTON
    IF [%VERSION%]==[Photon] GOTO ECLIPSEPHOTON
    IF [%VERSION%]==[4.8] GOTO ECLIPSEPHOTON
    IF [%VERSION%]==[latest] GOTO ECLIPSELATEST
    IF [%VERSION%]==[oxygen] GOTO ECLIPSEOXYGEN
    IF [%VERSION%]==[Oxygen] GOTO ECLIPSEOXYGEN
    IF [%VERSION%]==[4.7] GOTO ECLIPSEOXYGEN
    IF [%VERSION%]==[neon] GOTO ECLIPSENEON
    IF [%VERSION%]==[Neon] GOTO ECLIPSENEON
    IF [%VERSION%]==[4.6] GOTO ECLIPSENEON
    IF [%VERSION%]==[mars] GOTO ECLIPSEMARS
    IF [%VERSION%]==[Mars] GOTO ECLIPSEMARS
    IF [%VERSION%]==[4.5] GOTO ECLIPSEMARS
    IF [%VERSION%]==[luna] GOTO ECLIPSELUNA
    IF [%VERSION%]==[Luna] GOTO ECLIPSELUNA
    IF [%VERSION%]==[4.4] GOTO ECLIPSELUNA
    IF [%VERSION%]==[kepler] GOTO ECLIPSEKEPLER
    IF [%VERSION%]==[Kepler] GOTO ECLIPSEKEPLER
    IF [%VERSION%]==[4.3] GOTO ECLIPSEKEPLER
    IF [%VERSION%]==[juno] GOTO ECLIPSEJUNO
    IF [%VERSION%]==[Juno] GOTO ECLIPSEJUNO
    IF [%VERSION%]==[4.2] GOTO ECLIPSEJUNO
    GOTO END
)

:ECLIPSELATEST
IF WIN==64 SET BINARYLINK=%LATESTLINK64%
IF WIN==32 SET BINARYLINK=%LATESTLINK32%
GOTO DOWNLOADUNZIPECLIPSE

:ECLIPSEPHOTON
IF WIN==64 SET BINARYLINK=%PHOTONLINK64%
IF WIN==32 SET BINARYLINK=%PHOTONLINK32%
GOTO DOWNLOADUNZIPECLIPSE

:ECLIPSEOXYGEN
IF WIN==64 SET BINARYLINK=%OXYGENLINK64%
IF WIN==32 SET BINARYLINK=%OXYGENLINK32%
GOTO DOWNLOADUNZIPECLIPSE

:ECLIPSENEON
IF WIN==64 SET BINARYLINK=%NEONLINK64%
IF WIN==32 SET BINARYLINK=%NEONLINK32%
GOTO DOWNLOADUNZIPECLIPSE

:ECLIPSEMARS
IF WIN==64 SET BINARYLINK=%MARSLINK64%
IF WIN==32 SET BINARYLINK=%MARSLINK32%
GOTO DOWNLOADUNZIPECLIPSE

:ECLIPSELUNA
IF WIN==64 SET BINARYLINK=%LUNALINK64%
IF WIN==32 SET BINARYLINK=%LUNALINK32%
GOTO DOWNLOADUNZIPECLIPSE

:ECLIPSEKEPLER
IF WIN==64 SET BINARYLINK=%KEPLERLINK64%
IF WIN==32 SET BINARYLINK=%KEPLERLINK32%
GOTO DOWNLOADUNZIPECLIPSE

:ECLIPSEJUNO
IF WIN==64 SET BINARYLINK=%JUNOLINK64%
IF WIN==32 SET BINARYLINK=%JUNOLINK32%
GOTO DOWNLOADUNZIPECLIPSE


:DOWNLOADUNZIPECLIPSE
powershell -Command (new-object System.Net.WebClient).DownloadFile('%BINARYLINK%','%TARGET%')
echo unzipping %TARGET% into %DIRECTORY%
%UNZIPEXE% %TARGET% -d %DIRECTORY%
:INSTALLECLIPSECHECKVERSION
type %DIRECTORY%\eclipse\.eclipseProduct
GOTO END



:INSTALLSWINGJS
REM Install SwingJS in the eclipse plugins directory
REM Q: Should we delete all net.sf.j2s files there first?
REM Unfortunately "latest" tag will not work
GOTO CHECKECLIPSEDIR
:INSTALLSWINGJSOK
SET DIRECTORY=%DIRECTORY%\dropins
IF "%VERSION%"=="" GOTO INSTALLSWINGJSCHECKVERSION
echo %PROG% -ver %VERSION% -dir %DIRECTORY%
SET TARGET=%DIRECTORY%\SwingJS_full.zip
IF %VERSION%==latest (
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
REM Check to see that we can use PowerShell
where powershell >nul 2>&1
IF not errorlevel 1 GOTO LOOP 
echo You need PowerShell to use this installation script
GOTO END

REM :CHECKUNZIP
REM Check to see that we have unzip.exe installed
REM IF "%VERSION%"=="" GOTO %PROG%
REM echo... checking for UNZIP.EXE
REM where %UNZIPEXE% >nul 2>&1
REM IF not errorlevel 1 GOTO %PROG%
REM SET /P c=We utilize GNU unzip.exe to unzip files. Install now? [Y/N]?
REM IF /I "%c%" EQU "N" GOTO END
REM echo installing GNU unzip.exe
REM SET TARGET=%WORKINGDIR%\unzip_installer.exe
REM powershell -Command (new-object System.Net.WebClient).DownloadFile('%UNZIPSOURCE%','%TARGET%')
REM %TARGET%
REM SET UNZIPEXE=unzip.exe
REM GOTO %PROG%

:CHECKJAVA
REM Check to see that we have Java, and what version it is
where java >nul 2>&1
IF not errorlevel 1 GOTO CHECKJAVA64
echo No Java installed. Please install Java first
GOTO END
:CHECKJAVA64
java -d64 -version >nul 2>&1
IF errorlevel 1 SET WIN=32
GOTO CHECKUNZIP

:CHECKECLIPSEDIR
REM Check to see that we have eclipse in the designated directory or its eclipse subdirectory
IF "%DIRECTORY%"=="" SET DIRECTORY=.
IF exist %DIRECTORY%\eclipse.exe GOTO %PROG%OK
SET DIRECTORY=%DIRECTORY%\eclipse
IF exist %DIRECTORY%\eclipse.exe GOTO %PROG%OK
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
