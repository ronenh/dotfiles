#!/usr/bin/env fish
mkdir -p $HOME/.config/kitty/
curl -sL https://raw.githubusercontent.com/trygveaa/kitty-kitten-search/master/search.py -o $HOME/.config/kitty/search.py
curl -sL https://raw.githubusercontent.com/trygveaa/kitty-kitten-search/master/scroll_mark.py -o $HOME/.config/kitty/scroll_mark.py

if not test -d $XDG_DATA_HOME/base16-kitty
	git clone --depth 1 git@github.com:kdrag0n/base16-kitty.git $XDG_DATA_HOME/base16-kitty
end
