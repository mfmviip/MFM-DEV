#!/usr/bin/env bash
cd $HOME/TOKYO
rm -rf $HOME/.telegram-cli
install() {
rm -rf $HOME/.telegram-cli
sudo chmod +x tg
chmod +x Run
chmod +x TK
./TK
}
if [ "$1" = "ins" ]; then
install
fi
chmod +x install.sh
lua start.lua