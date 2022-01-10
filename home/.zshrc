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

setopt interactive_comments

# zsh-autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

autoload -Uz compinit && compinit
bindkey '^I' complete-word
zstyle -e ':completion:*' command-path 'reply=( "$PWD/bin" "${(@)path}" )'

eval $(thefuck --alias)


# fix right prompt indent
ZLE_RPROMPT_INDENT=0

# load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

setopt PROMPT_SUBST

# if tty
if [[ $TERM == "linux" ]]; then
	# Format the vcs_info_msg_0_ variable
	zstyle ':vcs_info:git*' formats $' %F{green}%s:%.32b%f'
	PROMPT='%(?..%3? )%D{%I:%M:%S%p} %F{blue}%n@%m%f:%F{cyan}%$(($COLUMNS - 40))<..<%~%f${vcs_info_msg_0_} %# '
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
typeset -g -A key

key[Backspace]="^?"
key[Insert]="^[[2~"
key[Home]="^[[H"
key[PageUp]="^[[5~"
key[Delete]="^[[3~"
key[End]="^[[F"
key[PageDown]="^[[6~"
key[Up]="^[[A"
key[Left]="^[[D"
key[Down]="^[[B"
key[Right]="^[[C"

key[Shift-Tab]="${terminfo[kcbt]}"
key[Control-Left]="${terminfo[kLFT5]}"
key[Control-Right]="${terminfo[kRIT5]}"
key[Control-Backspace]="^H"
key[Control-Delete]="${terminfo[kDC5]}"
key[Control-R]="^R"

# setup key accordingly
[[ -n "${key[Home]}"              ]]\
	&& bindkey          "${key[Home]}"              beginning-of-line\
	&& bindkey -M vicmd "${key[Home]}"              beginning-of-line
[[ -n "${key[End]}"               ]]\
	&& bindkey          "${key[End]}"               end-of-line\
	&& bindkey -M vicmd "${key[End]}"               end-of-line
[[ -n "${key[Insert]}"            ]]\
	&& bindkey          "${key[Insert]}"            overwrite-mode\
	&& bindkey -M vicmd "${key[Insert]}"            overwrite-mode
[[ -n "${key[Backspace]}"         ]]\
	&& bindkey          "${key[Backspace]}"         backward-delete-char\
	&& bindkey -M vicmd "${key[Backspace]}"         backward-delete-char
[[ -n "${key[Delete]}"            ]]\
	&& bindkey          "${key[Delete]}"            delete-char\
	&& bindkey -M vicmd "${key[Delete]}"            delete-char
[[ -n "${key[Up]}"                ]]\
	&& bindkey          "${key[Up]}"                up-line-or-beginning-search\
	&& bindkey -M vicmd "${key[Up]}"                up-line-or-beginning-search
[[ -n "${key[Down]}"              ]]\
	&& bindkey          "${key[Down]}"              down-line-or-beginning-search\
	&& bindkey -M vicmd "${key[Down]}"              down-line-or-beginning-search
[[ -n "${key[Left]}"              ]]\
	&& bindkey          "${key[Left]}"              backward-char\
	&& bindkey -M vicmd "${key[Left]}"              backward-char
[[ -n "${key[Right]}"             ]]\
	&& bindkey          "${key[Right]}"             forward-char\
	&& bindkey -M vicmd "${key[Right]}"             forward-char
[[ -n "${key[PageUp]}"            ]]\
	&& bindkey          "${key[PageUp]}"            beginning-of-buffer-or-history\
	&& bindkey -M vicmd "${key[PageUp]}"            beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"          ]]\
	&& bindkey          "${key[PageDown]}"          end-of-buffer-or-history\
	&& bindkey -M vicmd "${key[PageDown]}"          end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}"         ]]\
	&& bindkey          "${key[Shift-Tab]}"         reverse-menu-complete\
	&& bindkey -M vicmd "${key[Shift-Tab]}"         reverse-menu-complete
[[ -n "${key[Control-Left]}"      ]]\
	&& bindkey          "${key[Control-Left]}"      backward-word\
	&& bindkey -M vicmd "${key[Control-Left]}"      backward-word
[[ -n "${key[Control-Right]}"     ]]\
	&& bindkey          "${key[Control-Right]}"     forward-word\
	&& bindkey -M vicmd "${key[Control-Right]}"     forward-word
[[ -n "${key[Control-Backspace]}" ]]\
	&& bindkey          "${key[Control-Backspace]}" backward-kill-word\
	&& bindkey -M vicmd "${key[Control-Backspace]}" backward-kill-word
[[ -n "${key[Control-Delete]}"    ]]\
	&& bindkey          "${key[Control-Delete]}"    kill-word\
	&& bindkey -M vicmd "${key[Control-Delete]}"    kill-word
[[ -n "${key[Control-R]}"         ]]\
	&& bindkey          "${key[Control-R]}"         history-incremental-search-backward\
	&& bindkey -M vicmd "${key[Control-R]}"         history-incremental-search-backward

