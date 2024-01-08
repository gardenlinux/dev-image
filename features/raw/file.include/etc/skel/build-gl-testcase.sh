#!/usr/bin/bash

if [ ! -d ~/gardenlinux ]
then
    git clone https://github.com/gardenlinux/gardenlinux ~/gardenlinux
else
    echo Local checkout of Garden Linux already exists
fi

pushd ~/gardenlinux

./build kvm_dev

popd
