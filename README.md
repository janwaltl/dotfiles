These are my dotfiles that I am using. Mainly bash, neovim, c++, python related.

Feel free to use them.

Do not hesitate to ask me if something is not clear or does not work for you.

# Installation

You might be interest in
[devenvsetup repo](https://github.com/janwaltl/devenvsetup).

1. Clone this repository.
2. Symlink the appropriate files into your home directory, or use the
   [devenvsetup](https://github.com/janwaltl/devenvsetup) repository to install
   the listed dotfiles and their dependencies.
3. Complete the first-run steps below.

The companion devenvsetup currently pins:

- Neovim v0.12.6
- tmux 3.8

The pins live in `install_neovim.sh` and `install_tmux.sh`. Neovim plugin
versions are locked in `.config/nvim/lazy-lock.json`; check plugin compatibility
when bumping Neovim. The tmux configuration uses the `tmux-256color` terminfo
entry; the companion setup installs it via `ncurses-term`.

# First run

Neovim bootstraps Lazy.nvim and installs the plugins at the revisions in
`lazy-lock.json` on first startup. Mason also installs the configured language
servers and tools. These steps need network access and may take a while.

## Tmux

1. Press `Ctrl-a`, then `I`, to install TPM plugins. There is little progress
   feedback; wait for completion.
2. Restart tmux.

## Neovim

1. Start Neovim and wait for Lazy.nvim to install plugins.
2. Wait for Treesitter parsers to compile; progress appears in the status line.
3. Use `:Mason` to inspect language servers and tools. The configured packages
   are installed automatically; restart Neovim after installation if needed.

# Plugins & Keybindings

Keybindings below are based on the current configuration; plugin details are
in `.config/nvim/lua/plugins/`.

**Terminology:**

- "-" = press together
- "+" = consecutive
- "\[\]" = alternatives, i.e. press one of them

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
- move current window left/right - `Alt-p` / `Alt-n`
- in copy-mode (vi keys), `y` copies the selection to the tmux buffer. System
  clipboard integration depends on the terminal/client configuration.

Newly created window inherits `${CWD}` from the active window where `prefix+c`
was pressed.

## Vim

Configuration is under `.config/nvim/`:

- `lua/options.lua` - editor options, persistent undo files in `~/undodir`,
  and 80/120-column guides.
- `lua/colorscheme.lua` - Gruvbox settings.
- `lua/mappings.lua` - most keybindings.
- `lua/plugins/*.lua` - Lazy.nvim plugin specs and plugin configuration.
- `lazy-lock.json` - locked plugin revisions.

### Generic

- Map `;` to `:` - no shift needed for writing commands.
- `jk` to quit insert mode.
- `<leader>` is the spacebar.
- Move between panes with `<leader>+[hjkl]`
- Move between tabs with `gt` and `gb`.
- Move between buffers with `[b` and `]b`.
- Move the current line up/down with `CTRL-k`/`CTRL-j`.

### Snippets - LuaSnip

LuaSnip provides completion snippets. Snippet definitions are under
`.config/nvim/snippets/`.

### Formatting

Formatting runs on save when an attached LSP supports it. C/C++ style is
configured by `.clang-format`; Markdown formatting uses `mdformat`. Ruff and
BasedPyright provide Python diagnostics. `none-ls` also configures Ansible and
YAML linting and codespell diagnostics.

Inlay hints are enabled by default. Use `<leader>lh` to toggle them for the
current buffer.

### Git integration

[vim-fugitive](https://github.com/tpope/vim-fugitive) for git commands,
[vim-gitgutter](https://github.com/airblade/vim-gitgutter) for hunk
manipulation.

- `:Git <cmd>` for basically any git command.
- Hunks are shown with signs in the left sidebar.
- `<leader>gs` - Git status in a new tab; `<leader>gb` - Git blame.
- `[h` / `]h` - previous/next hunk.
- `<leader>hs` - stage the current hunk.
- `<leader>hr` - preview the current hunk.
- `<leader>hu` - undo the current hunk.
- `<leader>hl` - list hunks.

### File navigation

**File search:**

Pretty fast fuzzy search for files (or words in them) in the current subtree.

My main method of opening new files.

Uses `fzf-lua`, fzf, and ripgrep.

**In general:**

1. press keybind
1. popup window opens with the list of files
1. enter your search query, files are searched on the fly
1. use arrows to find your file (or type more until it is the only one left...)
1. open with `enter` or `CTRL-t`, `CTRL-v` for dedicated new tab or vertical
   split.

- `<leader>ff` search files.
- `<leader>fg` search files tracked by the current Git repository.
- `<leader>fw` search project contents.
- `<leader>fc` search Git commits.
- `<leader>fh` search recently opened files.
- `<leader>fb` list buffers; `<leader>ft` list tabs.

**File browser:**

[nvim-tree](https://github.com/nvim-tree/nvim-tree.lua).

- Open/close with `<leader>+t`.
- open/close folders with `enter`.
- Create new files in the "current" folder with `a`, trailing `/` create a
  directory.
- Rename file/dir with `r`.
- Remove file/dir with `d`.
- Cut file/dir with `x`.
- Copy file/dir with `c`.
- Paste file/dir into the "current" folder with `p`.
- Open the file with `enter`.
- Open the file in vertical pane `CTRL-v`.
- Open the file in new tab `CTRL-t`.

### Jumping inside current file/tab

Standard Vim search plus EasyMotion and Leap.

- Search by pressing `/` and writing the search query. Enter jumps to the first
  result.
- `CTRL-L` clears the highlights.
- Move between search results with `n` and `N`.
- Move between jump lists with `CTRL-o` or `CTRL-i`, also works for jump between
  files opened from the file browser.

**Jump mappings:**

- `,f` - EasyMotion jump by one character.
- `,s` - EasyMotion jump by two characters.
- `,w` - EasyMotion jump by word.
- `s` - Leap jump by two characters.

### Autocompletion, linters, LSP

Based on installed LSPs.

Mason automatically installs the configured servers and tools on first start;
use `:Mason` to inspect them. Mason-managed language servers are Clangd,
rust-analyzer, Lua LS, BasedPyright, and Ruff. A `gopls` config is present, but
Go is not currently in Mason's automatic-install list.
Mason's bin directory is prepended to Neovim's `PATH`, so Mason copies take
precedence there; system and uv-installed copies remain available to shells and
other programs.

- C++ requires `compile_commands.json` present, I use
  [compiledb](https://github.com/nickdiego/compiledb) for make-based projects,
  CMake can generate it too.
- Autocomplete with `<Enter>`.
- `CTRL+n`, `CTRL+p` moves between the autocomplete suggestions.
- `<Tab>` also moves forward but in case of snippets it just to the next
  placeholder.
- `<SHIFT-Tab>` tab but backwards.
- `CTRL+e` closes the autocomplete suggestion window.

Additional diagnostics come from clang-tidy, yamllint, ansible-lint, and
codespell. See `lua/plugins/mason.lua` and `lua/plugins/none-ls.lua` for the
configured tools.

- Python LSP setup prefers an activated environment (`VIRTUAL_ENV`), then a
  project `venv/` or `.venv/`, and finally Python from `PATH`.

**Navigation:**

- `gD` - go to declaration.
- `gd` - go to definition.
- `gi` - go to implementation.
- `gk` - show hover information about the symbol under cursor.
- `gr` - find all symbol references.
- `<leader>rn` - rename symbol under the cursor.
- `ge` - show the diagnostic under the cursor.
- `[g` - jump to the previous diagnostic; `]g` - jump to the next one.

### Others

- `K` opens man page for the word under the cursor in the current pane.
- `<leader>+K` opens man page for the word under the cursor in a new tab.
- `<leader>+c` close quickfix window.
- Very handy motions with [vim-surround](https://github.com/tpope/vim-surround).
- `cs"'` - changes `"hello"` to `'hello'` when cursor is somewhere between.
  Works with brackets too.
- [vim-commentary](https://github.com/tpope/vim-commentary) for
  commenting,uncommenting for multiple languages
  - e.g. `gcc` comments current line.

# LICENSE

Public Domain in general, some snippets were made by others, do respect the
mentioned source and its license.
