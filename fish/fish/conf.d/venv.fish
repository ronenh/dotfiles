# Automatically activate virtualenvs

# function __auto_source_venv --on-variable PWD --description "Activate/Deactivate virtualenv on directory change"
# 	status --is-command-substitution; and return
#
# 	# Check if we are inside a git repository
# 	if git rev-parse --show-toplevel &>/dev/null
# 		set dir (realpath (git rev-parse --show-toplevel))
# 	else
# 		set dir (pwd)
# 	end
#
# 	if test -e "$dir/.venv/bin/activate.fish"
# 		set venv_dir "$dir/.venv"
# 	else if test -e "$dir/.venv-path"
# 		set venv_dir (cat "$dir/.venv-path")
# 	end
#
# 	# Activate venv if it was found and not activated before
# 	if test "$VIRTUAL_ENV" != "$venv_dir" -a -e "$venv_dir/bin/activate.fish"
# 		source $venv_dir/bin/activate.fish > /dev/null
# 	# Deactivate venv if it is activated but the directory doesn't exist
# 	else if not test -z "$VIRTUAL_ENV" -o -e "$venv_dir"
# 		deactivate
# 	end
# end
#
# __auto_source_venv
