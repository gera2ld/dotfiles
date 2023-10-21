# Gerald's vimfiles

## Prerequisites

- [fzf][fzf] - for fuzzy searching
- [ripgrep][ripgrep] - for content searching
- Node.js - for coc.nvim and powerful LSP support
- Python 3 and [Poetry](https://python-poetry.org/)

  Note: tools like `pylint` needs to be installed per project because they may depend on the version of Python and dependencies of the project.

The following can be installed only if you need them:

- OCaml

  ```bash
  $ opam install ocaml-lsp-server ocamlformat
  ```

## Installation

```ps
$ git clone git@github.com:gera2ld/vimfiles.git
$ cd vimfiles
$ npm install
```

## Features

- Split windows
  - `<Leader>w{kjhlt}` -> Split window and open the new window above (k) / below (j) / left to (h) / right to (l) the current window, or in a new tab (t)
- Open a file browser ([vim-dirvish][vim-dirvish])
  - `<Leader>e{kjhlwt}` -> Open directory of current file above (k) / below (j) / left to (h) / right to (l) / in (w) the current window, or in a new tab (t)
  - `<Leader>e{KJHLWT}` -> Same as `<Leader>e{kjhlwt}` but open current working directory
- Open a terminal / shell
  - `<Leader>t{kjhlwt}` -> Open a terminal above (k) / below (j) / left to (h) / right to (l) / in (w) the current window, or in a new tab (t)
- JSON ([coc-format-json][coc-format-json])
  - `:CocCommand formatJson --preset-json`
- Searching
  - `<Space>f` -> `:CocList files`, Search files in current directory by name ([coc.nvim][coc.nvim])
  - `<Leader>ff` -> `:FZF`, Search files in current directory by name ([fzf][fzf])
  - `<Leader>sf` -> `:CtrlSF `, Search file content in current directory ([ripgrep][ripgrep])
  - `g*` -> Search whole words matching the word under cursor ([ctrlsf.vim][ctrlsf.vim])
  - `gF` -> Open file under cursor and jump to specified line and column ([vim-fetch][vim-fetch])
- Buffer
  - `<Space>b` -> `:CocList buffers`
- Diagnostics
  - `<Space>d` -> `:CocList diagnostics`
- Git
  - `<Space>gc` -> Show commit that changed current line
  - `<Space>gb` -> Show commits that changed current file
- and more...

[coc-format-json]: https://github.com/gera2ld/coc-format-json
[coc.nvim]: https://github.com/neoclide/coc.nvim
[ctrlsf.vim]: https://github.com/dyng/ctrlsf.vim
[fzf]: https://github.com/junegunn/fzf
[ripgrep]: https://github.com/BurntSushi/ripgrep
[vim-dirvish]: https://github.com/justinmk/vim-dirvish
[vim-fetch]: https://github.com/wsdjeg/vim-fetch
