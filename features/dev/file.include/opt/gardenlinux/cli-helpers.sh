if [ -f /usr/lib/git-core/git-sh-prompt ]; then
	. /usr/lib/git-core/git-sh-prompt
	export GIT_PS1_SHOWDIRTYSTATE=1
	export PS1='\w$(__git_ps1 " (%s)")\$ '
fi

# As described here https://github.com/gardenlinux/gardenlinux/blob/169f15c70afbae7b578839520eeedb9ed2619c02/docs/02_operators/deployment/aws-secureboot.md?plain=1#L107
if [ -d /opt/gardenlinux/python-uefivars ]; then
	export PATH=/opt/gardenlinux/third_party/python-uefivars:$PATH
fi

alias ls='ls --group-directories-first --time-style=long-iso --color=auto --classify'
alias ll='ls -lh'
alias la='ls -lah'
alias lh=la

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias g=git
alias gcl='git clone'
alias ga='git add'
alias gs='git status'
alias gd='git diff'
alias gdc='git diff --cached'
