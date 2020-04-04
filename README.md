# bash--deb-pkg-builder-installer
This script will build, package and install any of your .sh scripts
---
Sample:
```
./installer.sh somescript.sh
./installer.sh somescript
```

Installer will create a debian package from your `somescript.sh` and install it as `somescript`.
A directory with the name `somescript` will be created, in which you'll find all the source, tar archives and deb package.

Sample of manually installing your package:
```
sudo dpkg -i somescript_0.1-1_all.deb
```

Todos:
Provide option to parse a directory along with a simple shell script, and install everything.
