# Neovim

## [junegunn/vim-plug](https://github.com/junegunn/vim-plug)

Minimalist Vim Plugin Manager

### Usage

```sh
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

| Command                             | Description                                                        |
| ----------------------------------- | ------------------------------------------------------------------ |
| `PlugInstall [name ...] [#threads]` | Install plugins                                                    |
| `PlugUpdate [name ...] [#threads]`  | Install or update plugins                                          |
| `PlugClean[!]`                      | Remove unused directories (bang version will clean without prompt) |
| `PlugUpgrade`                       | Upgrade vim-plug itself                                            |
| `PlugStatus`                        | Check the status of plugins                                        |
| `PlugDiff`                          | Examine changes from the previous update and the pending changes   |
| `PlugSnapshot[!] [output path]`     | Generate script for restoring the current snapshot of the plugins  |

## [joshdick/onedark.vim](https://github.com/joshdick/onedark.vim)

A dark Vim/Neovim color scheme inspired by Atom's One Dark syntax theme.

## [itchyny/lightline.vim](https://github.com/itchyny/lightline.vim)

A light and configurable statusline/tabline plugin for Vim

## [scrooloose/nerdtree](https://github.com/scrooloose/nerdtree)

A tree explorer plugin for vim.

### Usage

* `Ctrl-e` : `:NERDTreeToggle`

## [majutsushi/tagbar](https://github.com/majutsushi/tagbar)

Vim plugin that displays tags in a window, ordered by scope

### Usage

* `F8` : `:TagbarToggle`
