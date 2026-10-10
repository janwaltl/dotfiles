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

function exec_with_history() {
	local history_entry
	printf -v history_entry '%q ' "$@"
	history -s "${history_entry% }"
	"$@"
}

# Start new tmux session from a folder
function tff(){
	local selected selected_name
	if [[ $# -eq 1 ]]; then
		selected=$1
	else
		selected=$(find "$HOME" -mindepth 1 -maxdepth 3 -type d | fzf)
	fi

	[[ -n $selected ]] || return 0

	selected_name=$(basename "$selected" | tr '.' '_' | tr '[:lower:]' '[:upper:]')

	tmux new-session -A -s "$selected_name" -c "$selected"
}

# Open file with editor
function ff() {
  local file
  local -a files=()
  while IFS= read -r file; do
    files+=("$file")
  done < <(FZF_DEFAULT_COMMAND='rg --files --hidden -L' fzf-tmux \
    --query="${1-}" --multi --select-1 --exit-0)

  ((${#files[@]})) || return 0
  exec_with_history ${EDITOR:-vim} "${files[@]}"
}

# Cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf-tmux +m) &&

  exec_with_history cd "$dir"
}

# Find in files, open in VIM
fif() {
	local file
	local -a files=()
	while IFS= read -r file; do
		files+=("$file")
	done < <(
	FZF_DEFAULT_COMMAND='rg --files --hidden' fzf-tmux \
	  -m \
	  -e \
	  --ansi \
	  --disabled \
	  --reverse \
	  --bind "ctrl-a:select-all" \
	  --bind "f12:execute-silent:(subl -b {})" \
	  --bind 'change:reload:if [[ -n {q} ]]; then rg -i -l --hidden {q} || true; else rg --files --hidden; fi' \
	  --preview 'rg -i --pretty --context 2 -- {q} {}'
	)

	((${#files[@]})) || return 0
	exec_with_history ${EDITOR:-vim} "${files[@]}"
}

# fbr - checkout local or remote branches, most recently committed first
fbr() {
  local branches branch ref
  branches=$(git for-each-ref --sort=-committerdate \
    --format='%(if)%(symref)%(then)%(else)%(refname:short)%09%(refname)%(end)' \
    refs/heads/ refs/remotes/ | sed '/^$/d') || return
  branch=$(printf '%s\n' "$branches" | fzf-tmux -d 40% --with-nth=1 +m) || return
  [[ -n $branch ]] || return 0

  ref=${branch#*$'\t'}
  case $ref in
    refs/heads/*)
      exec_with_history git checkout "${ref#refs/heads/}"
      ;;
    refs/remotes/*)
      exec_with_history git checkout --track "${ref#refs/remotes/}"
      ;;
  esac
}

alias dotvim='vim ~/.config/nvim/'
alias dotbash='vim ~/.bashrc'
alias dotalias='vim ~/.bash_aliases'
alias dotupdate='fn_dotupdate'
# Copy current hash to clipboard and print to stderr.
alias gh='git rev-parse HEAD | tr -d '[:space:]' | tee /dev/fd/2 | xclip -selection c'
