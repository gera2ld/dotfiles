# Shell {{{
__add_path() {
	case ":$PATH:" in
		*":$1:"*) return ;;
	esac
	if [ -n "$2" ]; then
		PATH="$1:$PATH"
	else
		PATH="$PATH:$1"
	fi
	export PATH
}
__add_path "$HOME/.local/bin" 1
# }}}

# Locale {{{
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"
# }}}

# Editor {{{
export EDITOR="nvim"
# }}}

# Mise {{{
alias m=mise
alias mx='mise exec --'
eval "$(mise activate zsh --shims)"
# }}}

# Node {{{
export PNPM_HOME=~/.local/share/pnpm
__add_path "$PNPM_HOME/bin"
alias p='mise exec -- pnpm'
# }}}

# Python {{{
export PIPX_DEFAULT_PYTHON="$HOME/.local/share/mise/shims/python"
# }}}

# Go {{{
export GOPATH=~/go
export GOBIN=$GOPATH/bin
__add_path "$GOBIN"
# }}}
