# Linux Scripts
### By the SwingJS Team

------------
## To Install

```
./install-linux [OPTIONAL] desired/installation/path
```

If no path is supplied, the script will install Eclipse into the same directory as the location of the `install-linux` script.

------------
## Clean Install

```
./clean-unix [REQUIRED] location/of/eclipse/workspace [REQUIRED] location/of/SwingJS/ant/build.xml
```

Since there are multiple parameters that need to be specified, there are no optional parameters. The clean script will assume location of the eclipse installation is in the same directory as the clean script.

If SwingJS is installed using the normal method (via Git) and added using the Eclipse Project Import interface, the ant build file will be located in `~/git/SwingJS/____.xml.`

Here is a full clean-build/ant build SwingJS command for example.
```
./clean /home/leeas/workspace /home/leeas/git/SwingJS/buildSite.xml
```
