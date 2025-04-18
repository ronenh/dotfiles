if command -qa lsd
	abbr -a ls 'lsd'
	abbr -a lg 'lsd -lA --git'
	abbr -a la 'lsd -A'
	abbr -a ll 'lsd -l'
	abbr -a lt 'lsd --tree'
else
	abbr -a la 'ls -A'
	abbr -a ll 'ls -l'
end
