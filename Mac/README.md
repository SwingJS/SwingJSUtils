# Mac Scripts
### By the SwingJS Team

----------
## To Install

The installation command is as follows:

```
./install-mac [ARGUMENT 1] -version [ARGUMENT 2] [OPTIONAL PATH]
```

| 	ARGUMENT   | OPTIONS                                   				| DESCRIPTION |
| ------------- | ------------------------------------------------------ | ------------ |
| ARGUMENT 1  | [`eclipse`]/[`j2s`]/[`swingjs`] | All the potential software components this script can install/check. `eclipse` will install Eclipse IDE, `j2s` will install the Java2Script plugins (.jar files) into the dropins and `swingjs` install just net.sf.j2s.core.jar into dropins as well as copy the SwingJS ZIP files for new or existing projects in a folder called SwingJS in the dropins folder. |
| ARGUMENT 2  | [`latest`]/[`version#`] | `latest` will install the latest version of whatever the user picked in ARGUMENT 1. The user can also specify a specific version of ARGUMENT 1 they want to install. Leave this blank to see the version of ARGUMENT 1 that is installed.
| OPTIONAL PATH | [/Users/username/.../desired/install/path] | The user can specify where they want to install ARGUMENT 1. If left blank, the script will assume all operations in the directory where this script is stored.

This script acts as both an installer for the correct Eclipse versions as well as the Java2Script plugins. However, if Eclipse is already installed in the directory specified (or unspecified), the install script will check to see if the Java2Script plugins in the dropins folder need to be updated or not (Either if the latest version has been updated on Github, or if the user specifies a version they want)


### Use cases

> I just want to install the latest -version of Eclipse in the same directory as this script.

```
$ ./install-mac eclipse -version latest
```
---

> I just want to see what version of Eclipse I am running, but my Eclipse directory is in another location

```
$ ./install-mac eclipse -version ~/path/to/parent/of/Eclipse.app
```
**Note, on older versions, Eclipse might get packaged as eclipse/ rather than Eclipse.app/Contents/Eclipse/**

---
> I just want to see what version of Eclipse I am running that I installed in this directory using this script.

```
$ ./install-mac eclipse -version ~/path/to/parent/of/Eclipse.app
```
---


> I just want to install Java2Script plugins version 3.1.1 after I installed Eclipse using this script in this directory (i.e. I never provided a path to another directory when installing Eclipse)
```
$ ./install-mac j2s -version 3.1.1
```
---



> I want to see what version of the Java2Script Plugins I am running, but I have a really customized location on my computer.
```
$ ./install-mac j2s -version /path/to/eclipse/dropins/
```
---

> I want to install the latest SwingJS runtime and the Eclipse.app directory not in the same directory as the install-mac script.
```
$ ./install-mac swingjs -version latest /path/to/eclipse/dropins/
```
---

> I want to see what version of SwingJS I am running and I see that Eclipse.app is in the same directory as the install script.
```
$ ./install-mac swingjs -version
```
---

----------
## Clean Install

```
./clean-unix [OPTIONAL] location/of/Eclipse.app [REQUIRED] location/of/eclipse/workspace [REQUIRED] location/of/SwingJS/ant/build.xml
```

If no path is supplied, the script will assume location of the eclipse installation is in the same directory as the clean script. 
