if [ -d ~/.bash_aliases.d ]; then
	for f in ~/.bash_aliases.d/*.alias ;do
		. "$f"
	done
fi

alias a='test -d venv && source venv/bin/activate  || source .venv/bin/activate'

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

alias vim='nvim'

function fn_dotupdate() {
	pushd ~/.dotfiles
	git pull
	popd
}

function exec_with_history(){
	history -s ${@}
	$@
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
  files=($(FZF_DEFAULT_COMMAND="rg --files --hidden -L" fzf-tmux --query="$1" --multi --select-1 --exit-0))

  if [[ -n "$files" ]]; then
	exec_with_history ${EDITOR:-vim} "${files[@]}"
  fi
}

# Cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&

  exec_with_history cd "$dir"
}

# Find in files, open in VIM
fif() {
	RG_DEFAULT_COMMAND="rg -i -l --hidden"
	selected=$(
	FZF_DEFAULT_COMMAND="rg --files" fzf \
	  -m \
	  -e \
	  --ansi \
	  --disabled \
	  --reverse \
	  --bind "ctrl-a:select-all" \
	  --bind "f12:execute-silent:(subl -b {})" \
	  --bind "change:reload:$RG_DEFAULT_COMMAND {q} || true" \
	  --preview "rg -i --pretty --context 2 {q} {}" | cut -d":" -f1,2
	)

	exec_with_history ${EDITOR:-vim} "${files[@]}"
}

# fbr - checkout git branch (including remote branches), sorted by most recent commit, limit 30 last branches
fbr() {
  local branches branch
  branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  exec_with_history git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

alias dotvim='vim ~/.config/nvim/'
alias dotbash='vim ~/.bashrc'
alias dotalias='vim ~/.bash_aliases'
alias dotupdate='fn_dotupdate'
# Copy current hash to clipboard and print to stderr.
alias gh='git rev-parse HEAD | tr -d '[:space:]' | tee /dev/fd/2 | xclip -selection c'

