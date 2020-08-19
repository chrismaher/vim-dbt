# vim-dbt

This plugin adds simple functionality for working within a [dbt](https://docs.getdbt.com/docs/introduction/) project. Features include:
* A `dbt` filetype, and filetype detection when within a dbt project.
* Syntax highlighting, adapted from the [Jinja2 syntax file](https://github.com/pallets/jinja/blob/master/ext/Vim/jinja.vim).
* Commands `:Run` and `:Test` for building and testing dbt models, with output written asynchronously to a terminal buffer.

## Installation
**[Vim-Plug](https://github.com/tpope/vim-pathogen)**
Add the following to `~/.vimrc`:

    Plug 'chrismaher/vim-dbt'

Call `PlugInstall vim-lookml`.

**[Pathogen](https://github.com/tpope/vim-pathogen)**

    git clone https://github.com/chrismaher/vim-dbt.git ~/.vim/bundle/vim-dbt

**[Vundle](https://github.com/VundleVim/Vundle.vim)**
Add the following to `~/.vimrc`:

    Plugin 'chrismaher/vim-dbt'

Call `:PluginInstall`.
