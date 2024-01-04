if [ -f /usr/lib/git-core/git-sh-prompt ]; then
	. /usr/lib/git-core/git-sh-prompt
	export GIT_PS1_SHOWDIRTYSTATE=1
	export PS1='\w$(__git_ps1 " (%s)")\$ '
fi

alias ls='ls --group-directories-first --time-style=+\"%Y-%m-%d %H:%M\" --color=auto --classify'
alias ll='ls -lh'
alias la='ls -lah'
alias lh=la

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias g=git
alias ga='git add'
alias gs='git status'
alias gd='git diff'
alias gdc='git diff --cached'
