# dotfiles-manager

a dmenu-based dotfiles launcher that drops you into a single tmux session, cd'd into whichever dotfiles subdir you pick.

forget about stow. forget about manually navigating your dotfiles.
just pick and go.

## how it works

- opens a dmenu picker with your configured dotfiles subdirs
- creates a tmux session `dots` cd'd into your selection
- if `dots` is already running, attaches to it instead
- logs everything to `~/.local/share/dotfiles-manager/log.txt`

## dependencies

- `dmenu`
- `tmux`
- a terminal emulator (see [setup](#setup))

## setup

### 1. clone & install

```bash
git clone https://github.com/theidioticdev/dotfiles-manager
cd dotfiles-manager
chmod +x dotfiles-manager
cp dotfiles-manager ~/.local/bin/
```

make sure `~/.local/bin` is in your `$PATH`.

### 2. set your terminal

dotfiles-manager needs to know which terminal to spawn. export `$TERMINAL` in your shell config:

**bash / zsh:**
```bash
export TERMINAL=st
```

**fish:**
```fish
set -gx TERMINAL st
```

if `$TERMINAL` is not set, it will fall back to auto-detecting from: `alacritty → kitty → foot → st`

### 3. configure your dotfiles dir

by default dotfiles-manager looks in `~/dotfiles`. override it with:

```bash
export DOTFILES_DIR=~/path/to/your/dotfiles
```

### 4. edit your repo list

on first run, a config file is created at:

```
~/.config/dotfiles-manager/repos
```

edit it to match your dotfiles subdirs — one name per line:

```
# dotfiles-manager repo list
dwm
nvim
hypr
```

lines starting with `#` and blank lines are ignored.

## usage

```
dotfiles-manager                  open dmenu picker
dotfiles-manager list             list configured subdirs + session status
dotfiles-manager kill             kill the dots tmux session (with confirmation)
dotfiles-manager edit             edit the config file
dotfiles-manager add <name>       add an entry to the config
dotfiles-manager remove <name>    remove an entry from the config
dotfiles-manager cd <name>        print path to a subdir
dotfiles-manager -h|--help        show help
dotfiles-manager --version        show version
```

### cd into a subdir from your shell

```bash
cd "$(dotfiles-manager cd nvim)"
```

## environment variables

| variable | default | description |
|---|---|---|
| `DOTFILES_DIR` | `~/dotfiles` | base dotfiles directory |
| `TERMINAL` | auto-detect | terminal emulator to spawn |
| `EDITOR` | `vi` | editor for `edit` subcommand |
| `DOTFILES_DMENU_NB` | `#1a1b26` | dmenu normal background |
| `DOTFILES_DMENU_NF` | `#c0caf5` | dmenu normal foreground |
| `DOTFILES_DMENU_SB` | `#7aa2f7` | dmenu selected background |
| `DOTFILES_DMENU_SF` | `#1a1b26` | dmenu selected foreground |

## logs

all events are logged to:

```
~/.local/share/dotfiles-manager/log.txt
```

## license

MIT
