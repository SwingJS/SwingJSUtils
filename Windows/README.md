# Windows Scripts
### By the SwingJS Team

----------
## To Install

The installation command is as follows:

```
installSwingjs.bat [ARGUMENT 1] -ver [ARGUMENT 2] [OPTIONAL PATH]
```

| 	ARGUMENT   | OPTIONS                                   				| DESCRIPTION |
| ------------- | ------------------------------------------------------ | ------------ |
| ARGUMENT 1  | [`eclipse`]/[`swingjs`] | All the potential software components this script can install/check. `eclipse` will install Eclipse IDE, And `swingjs` install just net.sf.j2s.core.jar into dropins as well as copy the SwingJS ZIP files for new or existing projects in a folder called SwingJS in the dropins folder. |
| ARGUMENT 2  | [`latest`]/[`version#`] | `latest` will install the latest version of whatever the user picked in ARGUMENT 1. The user can also specify a specific version of ARGUMENT 1 they want to install. Leave this blank to see the version of ARGUMENT 1 that is installed. |
| OPTIONAL PATH | [C:\Users\username/...\desired\install\path] | The user can specify where they want to install ARGUMENT 1. If left blank, the script will assume all operations in the directory where this script is stored. Please not for the swingjs option for ARGUMENT 1, you must specify the dropins folder rather than the root of Eclipse. |

This script acts as both an installer for the correct Eclipse versions as well as the Java2Script transpiler plugin. However, if Eclipse is already installed in the directory specified (or unspecified), the install script will check to see if the Java2Script plugins in the dropins folder need to be updated or not (Either if the latest version has been updated on Github, or if the user specifies a version they want). For unzipping files we suggest installing GNU Unzip (the script will take you to the installer if you do not already have it installed). However, if you do not have admin rights on your current machine, you can specify the `-stahl` flag as the second argument in order to utilize Stahl Work's Unzip program which, although similar in function as GNU Unzip, will not require an shared installation (which is required by GNU Unzip).


### Use cases

> I just want to install the latest version of Eclipse in the same directory as this script.

```
$ installSwingjs.bat eclipse -ver latest
```
---

> I just want to see what ver of Eclipse I am running, but my Eclipse directory is in another location

```
$ installSwingjs.bat eclipse -ver C:\path\to\parent\of\eclipse_root
```

---
> I just want to see what ver of Eclipse I am running that I installed in this directory using this script.

```
$ installSwingjs.bat eclipse -ver C:\path\to\parent\of\eclipse_root
```
---


> I just want to install Java2Script plugins version 3.1.1 after I installed Eclipse using this script in this directory (i.e. I never provided a path to another directory when installing Eclipse)
```
$ installSwingjs.bat j2s -ver 3.1.1
```
---



> I want to see what version of the Java2Script Plugins I am running, but I have a really customized location on my computer.
```
$ installSwingjs.bat j2s -ver C:\path\to\eclipse\dropins\
```
---

> I want to install the latest SwingJS runtime and the eclipse root directory not in the same directory as the install-linux script.
```
$ installSwingjs.bat swingjs -ver latest C:\path\to\eclipse\dropins\
```
---

> I want to see what version of SwingJS I am running and I see that eclipse root directory is in the same directory as the install script.
```
$ installSwingjs.bat swingjs -ver
```
---

----------
## Clean Install

```
clean.bat [OPTIONAL] C:\location\of\eclipse\root\directory [REQUIRED] location\of\eclipse\workspace [REQUIRED] location\of\SwingJS\ant\build.xml
```

If no path is supplied, the script will assume location of the eclipse installation is in the same directory as the clean script. 
