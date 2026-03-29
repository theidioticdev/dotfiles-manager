# dotfiles-manager

a dmenu-based dotfiles launcher that drops you into a tmux session or neovim, cd'd into whichever dotfiles subdir you pick.

forget stow. forget chezmoi. forget manually navigating your dotfiles.

## how it works

- opens a dmenu picker with your configured dotfiles subdirs
- opens your selection in **tmux** (single shared `dots` session) or **neovim + telescope**, depending on the configured mode
- if a `dots` tmux session is already running, attaches to it instead of creating a new one
- mode can be set globally or per-entry
- logs everything to `~/.local/share/dotfiles-manager/log.txt`

## dependencies

- `dmenu`
- `tmux`
- `rsync`
- a terminal emulator (see [setup](#setup))
- `nvim` or `vim` — only needed if you use vim mode
- [`telescope.nvim`](https://github.com/nvim-telescope/telescope.nvim) — optional, falls back to netrw if not installed

## install

```bash
curl -fsSL https://raw.githubusercontent.com/theidioticdev/dotfiles-manager/main/install.sh | bash
```

make sure `~/.local/bin` is in your `$PATH`.

a manpage is installed to `~/.local/share/man/man1/dotfiles-manager.1`. read it with:

```bash
man dotfiles-manager
```

## setup

### 1. set your terminal

dotfiles-manager needs to know which terminal to spawn. export `$TERMINAL` in your shell config:

```bash
# bash / zsh
export TERMINAL=alacritty

# fish
set -gx TERMINAL alacritty
```

if `$TERMINAL` is unset, it auto-detects from: `alacritty → kitty → foot → st`

### 2. configure your dotfiles dir

by default dotfiles-manager looks for subdirs in `~/dotfiles`.

you can override this in the settings file (`~/.config/dotfiles-manager/settings`):

```
dotfiles_dir = ~/path/to/your/dotfiles
```

or with an environment variable (takes priority over the settings file):

```bash
export DOTFILES_DIR=~/path/to/your/dotfiles
```

### 3. edit your repo list

on first run, a config file is created at `~/.config/dotfiles-manager/repos`. edit it with:

```bash
dotfiles-manager edit
```

one subdir name per line. each entry can carry an optional `mode=` tag:

```
# dotfiles-manager repo list
dwm-btw
nvim mode=vim
hypr mode=tmux
zsh
```

lines starting with `#` and blank lines are ignored.

### 4. set your default mode (optional)

edit the settings file:

```bash
dotfiles-manager settings
```

```
# tmux (default) or vim
mode = tmux
```

mode resolution order (highest → lowest priority):

1. per-entry override in repos (`nvim mode=vim`)
2. global `mode` in settings file
3. hardcoded fallback: `tmux`

## session modes

### tmux (default)

creates a tmux session named `dots` with its working directory set to the selected subdir. if `dots` already exists, attaches to it.

### vim

launches neovim with `telescope.nvim` opened via `find_files`, rooted at the selected subdir. falls back to netrw if telescope is not installed.

## usage

```
dotfiles-manager                        open dmenu picker
dotfiles-manager list                   list entries, modes, targets + session status
dotfiles-manager kill                   kill the dots tmux session (with confirmation)
dotfiles-manager edit                   edit the repos config file
dotfiles-manager settings               edit the global settings file
dotfiles-manager add <name> [mode]      add an entry (mode: vim or tmux, optional)
dotfiles-manager remove <name>          remove an entry
dotfiles-manager mode <name> <mode>     set per-entry mode (vim, tmux, or clear)
dotfiles-manager cd <name>              print path to a subdir
dotfiles-manager apply <name>           copy dotfiles/<name> → target (backs up first)
dotfiles-manager apply-all              apply every configured entry
dotfiles-manager map <name> <path>      set a custom target path for an entry
dotfiles-manager -h|--help              show help
dotfiles-manager --version              show version
```

### cd into a subdir from your shell

```bash
cd "$(dotfiles-manager cd nvim)"
```

### apply dotfiles to their target

`apply` copies a subdir to its resolved target (default: `~/.config/<name>`), backing up the existing target first. up to 10 timestamped backups are kept per target.

```bash
dotfiles-manager apply nvim
# or to apply everything at once if you edited multiple-files 
dotfiles-manager apply-all
```

### custom target paths

override the default `~/.config/<name>` target for any entry:

```bash
dotfiles-manager map zsh ~/.config/zsh
dotfiles-manager map bash ~
```

mappings are stored in `~/.config/dotfiles-manager/mappings`.

## config files

| file | purpose |
|---|---|
| `~/.config/dotfiles-manager/repos` | list of dotfiles subdirs + per-entry mode overrides |
| `~/.config/dotfiles-manager/settings` | global settings (`mode`, `dotfiles_dir`) |
| `~/.config/dotfiles-manager/mappings` | custom target path overrides |
| `~/.local/share/dotfiles-manager/log.txt` | operation log |
| `~/.local/share/dotfiles-manager/backups/` | timestamped backups from `apply` |

## environment variables

| variable | default | description |
|---|---|---|
| `DOTFILES_DIR` | `~/dotfiles` | dotfiles root dir — overrides `dotfiles_dir` in settings |
| `TERMINAL` | auto-detect | terminal emulator to spawn |
| `EDITOR` | `vi` | editor for `edit` and `settings` subcommands |
| `DOTFILES_DMENU_NB` | `#1a1b26` | dmenu normal background |
| `DOTFILES_DMENU_NF` | `#c0caf5` | dmenu normal foreground |
| `DOTFILES_DMENU_SB` | `#7aa2f7` | dmenu selected background |
| `DOTFILES_DMENU_SF` | `#1a1b26` | dmenu selected foreground |

## license

MIT
