# vim-ac

This vimrc profile is created for AtCoder.
You should create this command to checkout profile.

```
alias acvim='ln -nfs ~/git/vim-ac/.vimrc ~/.vimrc && cd ~/work/ac_js && vi -c "CocCommand explorer --width 30"'
```

And normal vim command is

```
alias v='ln -nfs ~/git/vim/.vimrc ~/.vimrc && vi -c "CocCommand explorer --width 30"'
```

And colorscheme onedark installation is here.

```
mkdir -p ~/.vim/colors/ && cp ~/git/vim-ac/colors/onedark.vim ~/.vim/colors/
mkdir -p ~/.vim/autoload/ && cp ~/git/vim-ac/autoload/onedark.vim ~/.vim/autoload/
```
