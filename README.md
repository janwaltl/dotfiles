These are my dotfiles that I am using. Mainly bash, neovim, c++, python related.

Feel free to use them.

Do not hesitate to ask me if something is not clear or does not work for you.

# Installation

You might be interest in [devenvsetup repo](https://github.com/janwaltl/devenvsetup).

1. Clone to somewhere
2. symlink the appropriate dotfiles to your home directory.
3. Perform the steps below on your first run.

**Versions**:
- Tmux around 3.2a
- Neovim 0.8+

Both are automatically installed through the devenvsetup too.

# First run
Both Tmux and Neovim need to manually install the plugins on first startup.
## Tmux
1. Press "(CTRL-A)+I" to install plugins, give it a second, it does not print progress, the lower status bar should become much nicer.
1. Restart tmux.

## Neovim
1. Run `:PackerInstall`, wait for all plugins to be installed in the popup window.
1. Also wait for tree-siter compilation, only shown on the status line at the bottom.

# Plugins & Keybindings
The lists below might not be always up-to-date, see the scripts themselves
**Terminology:**
- "-" = press together
- "+" = consecutive
- "[]" = alternatives, i.e. press one of them

## Tmux

- tmux prefix - `CTRL-a`
- split panel horizontally - `prefix + -` (minus)
- split current panel vertically `prefix + |`
- switch between panels = `ALT-[hjkl]`
- switch to next window - `prefix-n`
- switch to previous window - `prefix+p`
- create a new window - `prefix+c`
- rename a window - `prefix + ,` (comma)
- kill a panel - `prefix + x`.
- move current window left (in the list of windows) - `ATL + p`
- move current window right (in the list of windows) - `ATL + n`
- select text with mouse and press "y" to store it in clipboard, requires `xclip` or similar.

Newly created window inherits `${CWD}` from the active window where `prefix+c` was pressed.

## Vim

Configuration located in `./.config/nvim/lua`, slightly disorganized at the moment.
- `options.lua` 
  - baseline reasonable options
  - Global persistent `${HOME}/undodir` - one can revert changes on re-opened files, clean from time to time.
  - `80,120` visual guidelines
  - no `.swap` files
- `colorscheme.lua` - gruvbox settings
- `mappings.lua` - majority of Keybindings but not all of them.
- `plugins.lua` - list of all plugins, loaded with `packer`. Saving this file updates the plugins.
- `config/` - plugin-specific configs, more keymappings.

### Generic
- Make `;` as as `:` - no shift needed for writing commands.
- `jk` to quit insert mode.
- `<leader>` se to spacebar.
- Move between panes with `<leader>+[hjkl]`
- Move between tabs with `g+t` and `g+b`.
- Move between buffers with `<leader>+[` and `<leader>+]`.
- Switch the current line with the one up/down with `CTRL-k`/`CTRL-j`.

### Snippets - Ultisnips
Autocomplete snippets for various languages, one can create custom ones and place them into `Ultisnips/` directory.

### Formatting
Language files are autoformatted on save (`:w`).

Respects `.clang-format` for C/C++, Python uses black, yaml and other have standard format too.

### Git integration

[vim-fugitive](https://github.com/tpope/vim-fugitive) for git commands, [vim-gitgutter](https://github.com/airblade/vim-gitgutter) for hunk manipulation.

- `:Git <cmd>` for basically any git command.
- Hunks are shown with signs in the left sidebar.
- `<leader>+h+s` - stage the current hunk.
- `<leader>+h+r` - review the current hunk - see diff.
- `<leader>+h+u` - undo (restore) the current hunk.
- `<leader>+h+n` - jump to the next hunk in the current file (does not wrap around).
- `<leader>+h+p` - jump to the previous hunk in the current file (does not wrap around).

### File navigation

**File search:**
Pretty fast fuzzy search for files (or words in them) in the current subtree. 

My main method of opening new files.

[fzf.vim](https://github.com/junegunn/fzf.vim), requires fzf, ripgrep.
In general:
1. press keybind
1. popup window opens with the list of files
1. enter your search query, files are searched on the fly
1. use arrows to find your file (or type more until it is the only one left...)
1. open with `enter` or `CTRL-t`, `CTRL-v` for dedicated new tab or vertical split.


- `<leader>+f+f` Search for all files matching the name.
- `<leader>+f+g` Search for all files tracked by current git repository.
- `<leader>+f+w` Search for all git files containing the given word.
- `<leader>+f+c` Search git log history.
- `<leader>+f+h` Search git log history, only commits relevant to the current file.

**File browser:**
[nvim-tree](https://github.com/nvim-tree/nvim-tree.lua).

- Open/close with `<leader>+t`.
- open/close folders with `enter`.
- Create new files in the "current" folder with `a`, trailing `/` create a directory.
- eename file/dir with `r`.
- Remove file/dir with `d`.
- Cut file/dir with `x`.
- Copy file/dir with `c`.
- Paste file/dir into the "current" folder with `p`.
- Open the file with `enter`.
- Open the file in vertical pane `CTRL-v`.
- Open the file in new tab `CTRL-t`.

### Jumping inside current file/tab
Standard vim commands + [easymotion](https://github.com/easymotion/vim-easymotion).

- Search by pressing `/` and writing the search query. Enter jumps to the first result.
- `CTRL-L` clears the highlights.
- Move between search results with `n` and `N`.
- Move between jump lists with `CTRL-o` or `CTRL-i`, also works for jump between files opened from the file browser.

**Easymotion workflow:**
1. Look at the place you want to jump, can be in another pane.
1. Press `f`, `s`, followed by a single char, two chars, respectively. `<leader>+w` marks all words.
1. All matches are highlighted, press the key(s) for the place you want to jump to. 
  Do not use uppercase, they are that way just for better readability.


### Autocompletion, linters, LSP

Based on installed LSPs.

Call `:LspInstallInfo` and install any LSPs you want (select via arrows, press `i`).


- C++ requires `compile_commands.json` present, I use [compiledb](https://github.com/nickdiego/compiledb) for make-based projects, CMake can generate it too.
- Autocomplete with `<Enter>`.
- `CTRL+n`, `CTRL+p` moves between the autocomplete suggestions.
- `<Tab>` also moves forward but in case of snippets it just to the next placeholder.
- `<SHIFT-Tab>` tab but backwards.
- `CTRL+e` closes the autocomplete suggestion window.

There is also linting via clang-tidy, `pylint` and others.
- Python should respect `venv` but it's not 100% in my experience.
- Do NOT run vim itself within activated `venv`.


Navigation:
- `gD` - go to declaration.
- `gd` - go to definition.
- `gi` - go to implementation.
- `gk` - show hover information about the symbol under cursor.
- `gr` - find all symbol references.
- `<leader>rn` - rename symbol under the cursor.
- `ge` - show all diagnostics on the current line.
- `g[` - jump to next diagnostic.
- `g]` - jump to prev diagnostic.

### Others

- `K` opens man page for the word under the cursor in the current pane.
- `<leader>+K` opens man page for the word under the cursor in a new tab.
- `<leader>+c` close quickfix window.
- Very handy motions with [vim-surround](https://github.com/tpope/vim-surround).
- `cs"'` - changes `"hello"` to `'hello'` when cursor is somewhere between. Works with brackets too.
- [vim-commentary](https://github.com/tpope/vim-commentary) for commenting,uncommenting for multiple languages
  - e.g. `gcc` comments current line.


# LICENSE
Public Domain in general, some snippets were made by others, do respect the mentioned source and its license.

