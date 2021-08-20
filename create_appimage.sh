#!/bin/sh

sudo chmod +x appimagetool-x86_64.AppImage
cp -r build/linux/x64/release/bundle/* AppDir
mkdir -p AppDir/usr/share/icons/hicolor/256x256/apps/
cp assets/fludm.png AppDir/usr/share/icons/hicolor/256x256/apps/
cp assets/fludm.png AppDir/fludm.png
mkdir -p AppDir/usr/share/applications
cp assets/fludm.desktop AppDir/usr/share/applications/fludm.desktop
cp assets/fludm.desktop AppDir/fludm.desktop
sudo chmod +x appimagetool-x86_64.AppImage
ARCH=x86_64 ./appimagetool-x86_64.AppImage AppDir/ fludm-x86_64.AppImage
