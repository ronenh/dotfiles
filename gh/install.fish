#!/usr/bin/env fish
if command -qs gh
	gh config set git_protocol ssh

	for ext in mislav/gh-branch vilmibm/gh-user-status dlvhdr/gh-prs
		gh extension install $ext || true
	end
end
