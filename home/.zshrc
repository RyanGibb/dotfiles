# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
setopt autocd nomatch notify
unsetopt beep extendedglob
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/ryan/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd V edit-command-line

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

alias ls='ls -p --color=auto'
alias pls='sudo $(fc -ln -1)'
alias o='xdg-open'
alias se='sudoedit'
alias su='su -p'
alias ssh='TERM=xterm ssh'
 
# fix right prompt indent
ZLE_RPROMPT_INDENT=0

# load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

setopt PROMPT_SUBST

# zsh-autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

autoload -Uz compinit && compinit
bindkey '^I' complete-word
zstyle -e ':completion:*' command-path 'reply=( "$PWD/bin" "${(@)path}" )'


eval $(thefuck --alias)

# if tty
if [[ $TERM == "linux" ]]; then
	# Format the vcs_info_msg_0_ variable
	zstyle ':vcs_info:git*' formats $' %F{green}%s:%.32b%f '
	PROMPT='%F{blue}%n@%m%f:%F{cyan}%$(($COLUMNS - 40))<..<%~%f${vcs_info_msg_0_}%# '
	RPROMPT=$'%D{%I:%M:%S%p} %3?'
	ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=fg=5
# if pty
else
	ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=fg=4
	zstyle ':vcs_info:git*' formats $'%K{cyan}%F{green}%k %.32b'
	PROMPT=${(j::Q)${(Z:Cn:):-$'
		%(?..%S%F{red}%3?%s%K{white})
		%S%f%k%F{white}
		" "%D{%I:%M:%S%p}
		%s%K{blue}%S%f%k%F{blue}
		%n@%m:
		%s%K{cyan}%S%f%k%F{cyan}
		%$(($COLUMNS - 40))<..<%~
		%F{cyan}
		${vcs_info_msg_0_}
		%s%f
		" "%#" "
	'}}
fi


# set window title
# https://wiki.archlinux.org/title/zsh#xterm_title
autoload -Uz add-zsh-hook

function xterm_title_precmd () {
	print -Pn -- '\e]2;zsh %n@%m:%~\a'
}

function xterm_title_preexec () {
	print -Pn -- '\e]2;zsh %n@%m:%~ %# ' && print -n -- "${(q)1}\a"
}

if [[ "$TERM" != "linux" ]]; then
	add-zsh-hook -Uz precmd xterm_title_precmd
	add-zsh-hook -Uz preexec xterm_title_preexec
fi



# set keybindings
# https://wiki.archlinux.org/index.php/zsh#Key_bindings

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"
key[Control-Left]="${terminfo[kLFT5]}"
key[Control-Right]="${terminfo[kRIT5]}"
key[Control-Backspace]="^H"
key[Control-Delete]="^[[3;5~"
key[Control-R]="^R"

# setup key accordingly
[[ -n "${key[Home]}"              ]] && bindkey -- "${key[Home]}"              beginning-of-line
[[ -n "${key[End]}"               ]] && bindkey -- "${key[End]}"               end-of-line
[[ -n "${key[Insert]}"            ]] && bindkey -- "${key[Insert]}"            overwrite-mode
[[ -n "${key[Backspace]}"         ]] && bindkey -- "${key[Backspace]}"         backward-delete-char
[[ -n "${key[Delete]}"            ]] && bindkey -- "${key[Delete]}"            delete-char
[[ -n "${key[Up]}"                ]] && bindkey -- "${key[Up]}"                up-line-or-beginning-search
[[ -n "${key[Down]}"              ]] && bindkey -- "${key[Down]}"              down-line-or-beginning-search
[[ -n "${key[Left]}"              ]] && bindkey -- "${key[Left]}"              backward-char
[[ -n "${key[Right]}"             ]] && bindkey -- "${key[Right]}"             forward-char
[[ -n "${key[PageUp]}"            ]] && bindkey -- "${key[PageUp]}"            beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"          ]] && bindkey -- "${key[PageDown]}"          end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}"         ]] && bindkey -- "${key[Shift-Tab]}"         reverse-menu-complete
[[ -n "${key[Control-Left]}"      ]] && bindkey -- "${key[Control-Left]}"      backward-word
[[ -n "${key[Control-Right]}"     ]] && bindkey -- "${key[Control-Right]}"     forward-word
[[ -n "${key[Control-Backspace]}" ]] && bindkey -- "${key[Control-Backspace]}" backward-kill-word
[[ -n "${key[Control-Delete]}"    ]] && bindkey -- "${key[Control-Delete]}"    kill-word
[[ -n "${key[Control-R]}"         ]] && bindkey -- "${key[Control-R]}"         history-incremental-search-backward

export LD_LIBRARY_PATH=/usr/lib

fortune | cowsay
