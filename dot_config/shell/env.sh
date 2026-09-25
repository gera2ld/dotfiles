__SHELL="${ZSH_VERSION:+zsh}"
__SHELL="${__SHELL:-${BASH_VERSION:+bash}}"

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
set -o vi
# }}}

# Locale {{{
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"
# }}}

# Editor {{{
export EDITOR="nvim"
alias vi=nvim
# }}}

# Mise {{{
alias m=mise
alias mx='mise exec --'
[ -n "$__SHELL" ] && eval "$(mise activate $__SHELL --shims)"
# }}}

# Node {{{
export NODE_USE_ENV_PROXY=1
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

# tmux {{{
alias tmux='tmux -2'
# }}}

# FZF {{{
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow -g \"!.git\""
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
export FZF_CTRL_T_OPTS="--info=inline --preview='bat -r :100 {}'"
[ -n "$__SHELL" ] && eval "$(fzf --$__SHELL)"
# }}}

# Zoxide {{{
[ -n "$__SHELL" ] && eval "$(mise exec -- zoxide init $__SHELL)"
# }}}
