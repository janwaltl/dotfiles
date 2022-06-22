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
alias dotvim='vim ~/.config/nvim/'
alias dotbash='vim ~/.bashrc'
alias dotalias='vim ~/.bash_aliases'
alias dotupdate='fn_dotupdate'

alias makecdb='compiledb -n make'
alias ff='vim $(fzf)'
