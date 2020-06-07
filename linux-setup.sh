#!/bin/bash

cd ~
rm -rf .vim
rm .vimrc

git clone https://github.com/chrisgladd/vimsetup.git .vim
ln -s .vim/.vimrc .vimrc
cd .vim
git submodule init
git submodule update
