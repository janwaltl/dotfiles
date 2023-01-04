alias a='. venv/bin/activate'

alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'

alias gs='git status'
alias ga='git add'
alias gc='git commit -vv'
alias gl='git llog'

alias l='ls -CF'
alias la='ls -lAh'
alias ll='ls -lh'
alias ls='ls --color=auto'

alias reload='source ~/.bashrc'

function fn_dotupdate() {
	pushd ~/.dotfiles
	git pull
	popd
}
function fn_tmux_fzf(){
	if [[ $# -eq 1 ]]; then
	    selected=$1
	else
	    selected=$(find ~/ -mindepth 1 -maxdepth 3 -type d | fzf)
	fi

	if [[ -z $selected ]]; then
	    exit 0
	fi

	selected_name=$(basename "$selected" | tr . _ | tr [:lower:] [:upper:])
	echo "Selected: ${selected_name}"
	tmux_running=$(pgrep tmux)

	if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
	    tmux new-session -s $selected_name -c $selected
	    exit 0
	fi

	if ! tmux has-session -t=$selected_name 2> /dev/null; then
	    tmux new-session -ds $selected_name -c $selected
	fi

	tmux attach -t $selected_name
}

alias dotvim='vim ~/.config/nvim/'
alias dotbash='vim ~/.bashrc'
alias dotalias='vim ~/.bash_aliases'
alias dotupdate='fn_dotupdate'

alias makecdb='compiledb -n make'
alias ff='vim $(fzf)'
alias tff='fn_tmux_fzf'
