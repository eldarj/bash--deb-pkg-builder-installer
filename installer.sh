#!/bin/bash
# Installer :: (C) Eldar 2020
# Creates .deb package from .sh script and installs it
# Note: run me as sudo!

pkgname=
pkgdir=

if [ $# -gt 1 ]; then
    echo "ERROR: Multiple arguments received."
    echo "USAGE: installer myscript.sh"
    exit
elif [ $# -lt 1 ]; then
    echo "ERROR: Script name as arg required."
    echo "USAGE: installer myscript.sh"
    exit
fi

if [[ ! -f $1 ]]; then
    echo "ERROR: Can't find file '$1'."
    exit
fi

if [[ $1 == *".sh"* ]]; then
    pkgname=${1%".sh"}
else
    pkgname=$1
fi

echo "Found '$1'. Preparing to install as '$pkgname'..."

pkgdir="$pkgname-0.1"

if [[ -d $pkgname ]]; then
    rm -rf $pkgname
fi

mkdir -p $pkgname/$pkgdir
cp $1 $pkgname/$pkgdir/$pkgname

echo "Running dh_make..."
cd $pkgname/$pkgdir && dh_make --indep --createorig

echo "Moving some stuff..."
echo $pkgname usr/bin > debian/install
echo "1.0" > debian/source/format
rm debian/*.ex

echo "Debuilding..."
debuild -us -uc

echo "All built, installing..."
cd ..
sudo dpkg -i ${pkgname}_0.1-1_all.deb

echo "Successfully instaleld \`$pkgname\`! Try running it."
