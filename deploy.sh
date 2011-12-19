#!/bin/bash

rm -f ~/.vimrc
rm -rf ~/.vim
mkdir ~/.vim

cp vimrc ~/.vimrc
cp -R autoload ~/.vim
cp -R doc ~/.vim
cp -R plugin ~/.vim
