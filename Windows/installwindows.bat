echo off
set /P c=We utilize Stahl Work's Unzip.exe to unzip files. Install now? [Y/N]?
IF /I "%c%" EQU "N" GOTO END
bitsadmin /transfer unziplicense /priority high https://raw.githubusercontent.com/SwingJS/SwingJSUtils/master/Windows/Unzip_License %cd%\Unzip_License
bitsadmin /transfer unzip /priority high http://stahlworks.com/dev/unzip.exe %cd%\\unzip.exe
start notepad %cd%\Unzip_License

set arg1=%1
set arg2=%2

IF [%3]==[] GOTO EMPTYARG3 REM If argument 3 is empty, then user said ___ -version, and just wants to know the version of what they installed
IF EXIST %3\* GOTO PATHARG3 REM If argument 3 is a path, user said ___ -version path, and just wants to know the version of what they installed at "path"
GOTO ARG3VERSION REM SINCE argument 3 is neither empty nor a path, assume they want to install something with argument 3 as the version #

:EMPTYARG3
echo "EMPTY ARG 3"
set DIRECTORY %cd%
GOTO END

:PATHARG3
echo "PATH ARG 3"
set DIRECTORY %cd%
GOTO END

:ARG3VERSION
echo "ARG 3 VERSION"
IF [%4]==[] (
    set DIRECTORY %cd%
    GOTO PARSEARG1
)
IF EXIST %4\* (
        set DIRECTORY %4
        )
IF [%1]==[-eclipse] GOTO ECLIPSE
IF [%1]==[-j2s] GOTO J2S
IF [%1]==[-swingjs] GOTO SWINGJS
echo "Invalid argument. Please refer to "https://github.com/SwingJS/SwingJSUtils/tree/master/Windows/README.md" for more details on how to use the script."
GOTO END


:ECLIPSE
java -d64 -version 2>&1
IF errorlevel 1 GOTO GETLINK64BITECLIPSE
REM However, if there is no error for this command, it means there exists a 64-bit installation of JVM and we can proceed to install the 64 bit versions of eclipse
IF NOT [%2]==[-version] GOTO INVALIDARG2
GOTO GETLINK64BITECLIPSE
GOTO END

:GETLINK64BITECLIPSE
IF [%VERSION%]==[latest] GOTO ECLIPSE64OXYGEN
IF [%VERSION%]==[oxygen] GOTO ECLIPSE64OXYGEN
IF [%VERSION%]==[Oxygen] GOTO ECLIPSE64OXYGEN
IF [%VERSION%]==[4.7] GOTO ECLIPSE64OXYGEN
IF [%VERSION%]==[neon] GOTO ECLIPSE64NEON
IF [%VERSION%]==[Neon] GOTO ECLIPSE64NEON
IF [%VERSION%]==[4.6] GOTO ECLIPSE64NEON
IF [%VERSION%]==[mars] GOTO ECLIPSE64MARS
IF [%VERSION%]==[Mars] GOTO ECLIPSE64MARS
IF [%VERSION%]==[4.5] GOTO ECLIPSE64MARS
IF [%VERSION%]==[luna] GOTO ECLIPSE64LUNA
IF [%VERSION%]==[Luna] GOTO ECLIPSE64LUNA
IF [%VERSION%]==[4.4] GOTO ECLIPSE64LUNA
IF [%VERSION%]==[kepler] GOTO ECLIPSE64KEPLER
IF [%VERSION%]==[Kepler] GOTO ECLIPSE64KEPLER
IF [%VERSION%]==[4.3] GOTO ECLIPSE64KEPLER
IF [%VERSION%]==[juno] GOTO ECLIPSE64JUNO
IF [%VERSION%]==[Juno] GOTO ECLIPSE64JUNO
IF [%VERSION%]==[4.2] GOTO ECLIPSE64JUNO
echo "Invalid version number"
GOTO END
















IF [%VERSION%]==[latest] GOTO ECLIPSEOXYGEN
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



:ECLIPSEOXYGEN
IF WIN==64 SET BINARYLINK "http://mirror.csclub.uwaterloo.ca/eclipse/technology/epp/downloads/release/oxygen/R/eclipse-jee-oxygen-R-win32-x86_64.zip"
IF WIN==32 SET BINARYLINK "http://mirror.math.princeton.edu/pub/eclipse//technology/epp/downloads/release/oxygen/R/eclipse-jee-oxygen-R-win32.zip"
GOTO INSTALLECLIPSE

:ECLIPSENEON
IF WIN==64 SET BINARYLINK "http://eclipse.mirror.rafal.ca/technology/epp/downloads/release/neon/3/eclipse-jee-neon-3-win32-x86_64.zip"
IF WIN==32 SET BINARYLINK "http://eclipse.mirror.rafal.ca/technology/epp/downloads/release/neon/3/eclipse-jee-neon-3-win32.zip"
GOTO INSTALLECLIPSE

:ECLIPSEMARS
IF WIN==64 SET BINARYLINK "http://eclipse.mirror.rafal.ca/technology/epp/downloads/release/mars/2/eclipse-jee-mars-2-win32-x86_64.zip"
IF WIN==32 SET BINARYLINK "http://eclipse.mirror.rafal.ca/technology/epp/downloads/release/mars/2/eclipse-jee-mars-2-win32.zip"
GOTO INSTALLECLIPSE

:ECLIPSELUNA
IF WIN==64 SET BINARYLINK "http://eclipse.mirror.rafal.ca/technology/epp/downloads/release/luna/SR2/eclipse-jee-luna-SR2-win32-x86_64.zip"
IF WIN==32 SET BINARYLINK "http://mirror.csclub.uwaterloo.ca/eclipse/technology/epp/downloads/release/luna/SR2/eclipse-jee-luna-SR2-win32.zip"
GOTO INSTALLECLIPSE

:ECLIPSEKEPLER
IF WIN==64 SET BINARYLINK "http://mirror.csclub.uwaterloo.ca/eclipse/technology/epp/downloads/release/kepler/SR2/eclipse-jee-kepler-SR2-win32-x86_64.zip"
IF WIN==32 SET BINARYLINK "http://eclipse.mirror.rafal.ca/technology/epp/downloads/release/kepler/SR2/eclipse-jee-kepler-SR2-win32.zip"
GOTO INSTALLECLIPSE

:ECLIPSEJUNO
IF WIN==64 SET BINARYLINK "http://eclipse.mirror.rafal.ca/technology/epp/downloads/release/juno/SR2/eclipse-jee-juno-SR2-win32-x86_64.zip"
IF WIN==32

SET BINARYNAME "juno.zip"
GOTO INSTALLECLIPSE





















:ECLIPSE32OXYGEN
SET BINARYLINK 
SET BINARYNAME "oxygen.zip"
GOTO INSTALLECLIPSE

:ECLIPSE32NEON

SET BINARYNAME "neon.zip"
GOTO INSTALLECLIPSE

:ECLIPSE32MARS

SET BINARYNAME "mars.zip"
GOTO INSTALLECLIPSE

:ECLIPSE32LUNA

SET BINARYNAME "luna.zip"
GOTO INSTALLECLIPSE

:ECLIPSE32KEPLER

SET BINARYNAME "kepler.zip"
GOTO INSTALLECLIPSE

:ECLIPSE32JUNO
SET BINARYLINK "http://mirror.csclub.uwaterloo.ca/eclipse/technology/epp/downloads/release/juno/SR2/eclipse-jee-juno-SR2-win32.zip.zip"
SET BINARYNAME "juno.zip"
GOTO INSTALLECLIPSE



:INSTALLECLIPSE
bitsadmin /transfer eclipse /priority high %BINARYLINK% %DIRECTORY%\%BINARYNAME%
unzip %DIRECTORY%\%BINARYNAME% -d %DIRECTORY%
echo "ECLIPSE INSTALLED"
GOTO END

:J2S
echo "INSTALLING J2S"
GOTO END

:SWINGJS
echo "INSTALLING SWINGJS"
GOTO END


:INVALIDARG2
echo "INVALID ARUGUMENT FOR 2 (-version)"

:END
