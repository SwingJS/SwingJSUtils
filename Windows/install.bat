powershell -Command "& {new-object System.Net.WebClient; $client.DownloadFile("https://hithub.com/BobHanson/java2script/releases/downloadv3.1.1/3.1.1.zip", "3.1.1.zip"); $client.DownloadFile("https://mirror.csclub.uwaterloo.ca./eclipse/technology/epp/downloads/release/neon/R/eclipse-jee-R-win32-x86_64.zip", "oxygen".zip"); $client.DownloadFile("http://stahlworks.com/dev/unzip.exe", "unzip.exe"); $client.DownloadFile("https://raw.githubusercontent.com/SwingJS/SwingJSUtils/master/Windows/Unzip_License", "Unzip_License");}"
start notepad "Unzip_License"
unzip 3.1.1.zip
unzip neon.zip
move net.j2s.core_3.1.1.jar eclipse\dropins\net.j2s.core_3.1.1.jar
del *.jar
rmdir net.sf.j2s.ajax_3.1.1
rmdir net.sf.j2s.lib_3.1.1
del 3.1.1.zip
del neon.zip
del unzip.exe
