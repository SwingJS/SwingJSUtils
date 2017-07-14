bitsadmin /transfer unziplicense /priority high https://raw.githubusercontent.com/SwingJS/SwingJSUtils/master/Windows/Unzip_License %USERPROFILE%\Unzip_License
bitsadmin /transfer unzip /priority high http://stahlworks.com/dev/unzip.exe %USERPROFILE%\unzip.exe
start notepad "Unzip_License"

:CheckOS
java -d64 -version 2>&1
IF errorlevel 1 GOTO 32BIT

bitsadmin /transfer eclipse /priority high http://eclipse.mirror.rafal.ca/technology/epp/downloads/release/neon/3/eclipse-java-neon-3-win32-x86_64.zip %USERPROFILE%\neon.zip
unzip neon.zip
del neon.zip
bitsadmin /transfer j2s /priority high https://github.com/SwingJS/SwingJSUtils/raw/master/3.1.1.zip %USERPROFILE%\eclipse\dropins\3.1.1.zip
unzip %USERPROFILE%\eclipse\dropins\3.1.1.zip -d %USERPROFILE%\eclipse\dropins\
del %USERPROFILE%\eclipse\dropins\3.1.1.zip
del %USERPROFILE%\unzip.exe
GOTO END

:32BIT
where java >nul 2>&1
IF errorlevel 1 GOTO  NOJAVA

bitsadmin /transfer eclipse /priority high http://eclipse.mirror.rafal.ca/technology/epp/downloads/release/neon/R/eclipse-jee-neon-R-win32.zip %USERPROFILE%\neon.zip
unzip neon.zip

del neon.zip

bitsadmin /transfer j2s /priority high https://github.com/SwingJS/SwingJSUtils/raw/master/3.1.1.zip %USERPROFILE%\eclipse\dropins\3.1.1.zip
unzip %USERPROFILE%\eclipse\dropins\3.1.1.zip -d %USERPROFILE%\eclipse\dropins\
del %USERPROFILE%\eclipse\dropins\3.1.1.zip
del %USERPROFILE%\unzip.exe
GOTO END

:NOJAVA

echo No Java Installed. Please install Java first
GOTO END
:END
