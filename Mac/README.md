# Mac Scripts
### By the SwingJS Team

----------
## To Install

The installation command is as follows:

```
./install-mac [REQUIRED ARGUMENT 1] [REQUIRED ARGUMENT 2] [OPTIONAL ARGUMENT 3]
```

| 	ARGUMENT   | OPTIONS                                   				| DESCRIPTION |
| ------------- | ------------------------------------------------------ | ------------ |
| ARGUMENT 1  | [`swingjs`]/[`no-swingjs`] | If `swingjs` is selected, the script will install the relevant Java2Script plugins compatible with SwingJS. If `no-swing` is selected, the script will ignore compatibility with the SwingJS runtime and will instead rely on the values supplied in ARGUMENT 2 for the correct version |
| ARGUMENT 2  | [`latest`]/[`version#`] | `latest` will install the latest version of the Java2Script plugin. However, if the user specifies a specific version number, the install script will install that specific version of the J2S plugin. |
| ARGUMENT 3 | [/Users/username/.../desired_install_path] | The user can specify where they want to install Eclipse and the relevant plugins. If left blank, the script will assume the user wants to install Eclipse in the same directory as the script, or that Eclipse already exists in the same directory **Note: if you are just updating the plugins, then you must specify where the root of the Eclipse installation is (i.e. the level in which the Eclipse.app directory is visible)** |

This script acts as both an installer for the correct Eclipse versions as well as the Java2Script plugins. However, if Eclipse is already installed in the directory specified (or unspecified), the install script will check to see if the Java2Script plugins in the dropins folder need to be updated or not (Either if the latest version has been updated on Github, or if the user specifies a version they want)


----------
## Clean Install

```
./clean-unix [OPTIONAL] location/of/Eclipse.app [REQUIRED] location/of/eclipse/workspace [REQUIRED] location/of/SwingJS/ant/build.xml
```

If no path is supplied, the script will assume location of the eclipse installation is in the same directory as the clean script. 
