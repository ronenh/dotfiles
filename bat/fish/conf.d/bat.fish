#!/usr/bin/env fish
if command -qa bat
	abbr -a cat 'bat'
end

if command -qa batcat
	abbr -a cat 'batcat'
end
