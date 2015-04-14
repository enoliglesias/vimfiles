Somebody told me that "vim is all you need". This is my very hard try to become a VIMer ;)
# Vimfiles
My .vim directory and .vimrc file

# Installation
Clone the repo:
`git clone https://github.com/enoliglesias/vimfiles.git ~/.vim`

Add a symlink to the vimrc file inside (In order to keep your real and updated file in the repo. Otherwise you'll need to copy and paste every time you modify something, etc):
`ln -s ~/.vim/vimrc ~/.vimrc`

Now create the matcher for the Ctrl+P plugin. Go to .vim/bin/matcher and do `make`

Clone Vundle to your .vim folder. See instructions here: `https://github.com/gmarik/Vundle.vim`

Last step is to install plugins in vim: `:PluginInstall!`

And here starts the adventure!



