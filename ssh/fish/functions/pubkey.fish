function pubkey
	more ~/.ssh/id_ed25519.pub | pbcopy
		and echo (set_color brblue)'-> Public key copied to clipboard'
end
