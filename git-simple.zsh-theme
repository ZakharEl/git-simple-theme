#!/bin/zsh
build_prompt() {
	local RETVAL=$? branch="$(git branch --show-current 2>/dev/null)" 
	printf '\n%s' '%{%f%b%k%u%}'
	[ $RETVAL -eq 0 ] && printf '%s' '%F{green}' || printf '%s' "$RETVAL %F{red}"
	printf '%s' '%n%f %U%~%u '
	if [ "$branch" ]
	then
		local statar=($(git status -s | awk 'BEGIN{u=0;s=0}END{print u, s}$0~/^\w. /{s++}$0~/^(\?|.\w )/{u++}'))
		if [ $statar[1] -ne 0 ]
		then
			printf '%s' '%F{red}'
		elif [ $statar[2] -ne 0 ]
		then
			printf '%s' '%F{yellow}'
		else
			printf '%s' '%F{green}'
		fi
		printf '%s' "${branch}%f "
		[ $statar[1] -ne 0 ] && printf '%s' "$statar[1] "
		[ $statar[2] -ne 0 ] && printf '%s' "$statar[2] "
		printf '%s' "%F{yellow}%B$(git rev-parse HEAD 2>/dev/null)%f%b"
	fi
}
PROMPT='$(build_prompt)
'
