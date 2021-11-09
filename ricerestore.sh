#!/bin/bash

export PATH=$PATH:~/.local/bin
cp -r $HOME/zxarch/dotfiles/* $HOME/
pip install konsave
konsave -i $HOME/zxarch/kde.knsv
sleep 1
konsave -a kde
