#! /bin/bash
# Just a simple script for auto push aosp-clang since my network is limited


export EMOH="/drone/src"
export CLANG_VERSION="clang-r433403"  # https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86/+/refs/heads/master

mkdir ${EMOH}/tmp
cd ${EMOH}/tmp

wget https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86/+archive/refs/heads/master/${CLANG_VERSION}.tgz
tar -xvf ${CLANG_VERSION}.tgz
rm -rf ${CLANG_VERSION}.tgz

git clone https://Reinazhard:${GH_TOKEN}@github.com/pjorektneira/aosp-clang.git ${EMOH}/push
rm -rf ${EMOH}/push/*
cp -rf ${EMOH}/tmp/* ${EMOH}/push/

cd ${EMOH}/push/
git add .
git commit -s -m "Import AOSP Clang from https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86/+archive/refs/heads/master/${CLANG_VERSION}"
git lfs migrate import --include="lib64/liblldb.so.13.0.1git"
git push origin
