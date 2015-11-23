#!/bin/bash

base_dir=`pwd`
tmp_dir=$base_dir/tmp


if [ ! -d $base_dir/../gflags ]
then
    echo -e "\033[31m glog: cant't find gflags\033[0m"
    exit 1
fi

rm -rf $tmp_dir 
mkdir -p $tmp_dir
git clone -b v0.3.3 https://github.com/google/glog.git $tmp_dir  
if [ $? -ne 0 ]
then
    echo -e "\033[31m glog: download from git error \033[0m"
    exit 1
fi

export LDFLAGS="${LDFLAGS} -lrt"

cd $tmp_dir
./configure --prefix=${base_dir} --enable-shared=no --with-gflags=$base_dir/../gflags && make && make install
if [ $? -ne 0 ]
then
    echo -e "\033[31m glog: make error \033[0m"
    exit 1
fi
rm -rf $tmp_dir


