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

# Start new tmux session from a folder
function tff(){
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

# Open file with editor
function ff() {
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

# Cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# using ripgrep combined with preview
# find-in-file - usage: fif <searchTerm>
fif() {
  if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
  rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}

# fbr - checkout git branch (including remote branches), sorted by most recent commit, limit 30 last branches
fbr() {
  local branches branch
  branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

alias dotvim='vim ~/.config/nvim/'
alias dotbash='vim ~/.bashrc'
alias dotalias='vim ~/.bash_aliases'
alias dotupdate='fn_dotupdate'

