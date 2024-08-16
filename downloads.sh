# NOT CURRENTLY READY FOR RUNNING AS A SCRIPT
#!/usr/bin/env bash
#
#
# Automate setting up a new machine
# Some defaults may be in the way, we'll have to figure that out in the future.
#
# While this is formatted as a script, it isn't yet doen self-contained and
# requires manually changing some lines.
# In the future it should become a fully automated script, but for now read
# carefully, and maybe even just copy the commands into your terminal.
#
# I'm keeping it around as more of a reference for what I need to do when
# setting up a new machine.

# NOTE:
#   When installing in a VM under virtualbox, I've noticed that the guest
#   additions 5.2.0 don't work, you can get the guest additions 5.1.30 from
#   http://download.virtualbox.org/virtualbox/5.1.30/
#
#   If you're reading this after an update has been made, then you may be able
#   to use some version after 5.2.0

# For first time around this is somewhat necessary.
sed -i 's/^# //' ~/repos/useful-files/rcfiles/gitconfig

install-packages () {
    # Attempt to install everything I want.
    if command -v apt; then
	sudo apt install gcc g++ clang gdb make git zsh emacs vim pwgen \
	  neovim ripgrep fd-find i3 i3status ranger cmake pkg-config ninja-build \
	  autoconf automake cscope exuberant-ctags python3-neovim xsel weechat \
	  gettext tree-sitter-cli tree-sitter-c-src libtree-sitter-dev fzy \
	  moreutils bear clang-tools clangd python3-pylsp texinfo libxaw7-dev \
	  libgtx-4-dev libgif-dev libgnutls28-dev flex bison dejagnu notmuch \
        ruby-dev ruby-notmuch
    # N.b. also need to look into libgccjit.
    # In a previous install I needed specifically to install libgccjit-13-dev
    # because the default version of gcc that was run was gcc-13.
    # Ubuntu didn't seem to have any generic libgccjit-dev package that would
    # give the default version according to whatever the default gcc version
    # is.
    elif command -v pacman; then
        sudo pacman -S base base-devel cmake unzip zsh emacs gvim i3-wm i3status ranger ninja git gdb cscope ctags python-neovim xsel weechat
    fi
}

run-install () {
    # Run the install section relevant to the argument.
    # i.e. run install part of vim
}

# TODO Remove the `share` parts of the vim alias in zshrc.
# (will have to change my local setup to fit this).
install-packages
mkdir ~/repos

# Rc Files
# basic-rc-files
git clone https://github.com/hardenedapple/useful-files ~/repos
for i in ~/repos/useful-files/rcfiles/{zshrc,zshenv,bashrc,inputrc,infokey,gitconfig,hgrc,tmux.conf};
do
    ln -fs $i ~/.${i##*/};
done
echo "Watch out for .profile, .bash_profile, and any other dotfiles that we haven't overwritten."


# GDB walkers
git clone https://github.com/hardenedapple/gdb-walkers ~/.config/gdb
ln -sf ~/repos/useful-files/rcfiles/gdbinit ~/.gdbinit

# Emacs
git clone --recurse-submodules https://github.com/hardenedapple/emacs_config ~/.emacs.d
pushd ~/.emacs.d
git submodule foreach "(git checkout master && git pull)"
cd vsh
./emacs-tar.sh
popd
echo "NOTE: It's likely that the Tamsyn font isn't installed on this system."
echo "If this is the case, then emacs will load without the majority of your config."
echo -n "Simply comment out the lines setting the font in"
echo " config/01_general_settings.el to get past that"

# Emacs extra if needed/wanted
# Follow instructions from below link to install more up-to-date version.
# Configure with `--prefix=$HOME/bin/emacs` and install, PATH from zshenv
# should include installed binaries.
# https://www.gnu.org/software/emacs/manual/html_node/efaq/Installing-Emacs.html

# i3
# Just ensure the config file is there ... I expect it gets installed with the
# i3 package, but it's easier to debug the first error than the second
# "mkdir: cannot create directory '...': File exists"
# "ln: failed to create symbolic link '...': No such file or directory"
mkdir -p ~/.config/i3 ~/.config/i3status
ln -sf ~/repos/useful-files/rcfiles/i3config ~/.config/i3/
ln -sf ~/repos/useful-files/rcfiles/i3status.conf ~/.config/i3/
echo "i3 has been installed and configured."
echo "You will need to tell your Distro to start it when logging in."

# Default xresources
# TODO Will have to check whether this works with all Desktop environments and
# window managers.
cat ~/repos/useful-files/xresources/base_resources ~/repos/useful-files/xresources/own_colors > ~/.Xresources

# vim config
git clone --recurse-submodules https://github.com/hardenedapple/vim_repo ~/.vim
pushd ~/.vim
git submodule foreach "(git checkout master && git pull)"
popd

# Neovim
ln -sf ~/.vim ~/.config/nvim

# Neovim full
git clone https://github.com/hardenedapple/neovim ~/repos/neovim
(cd ~/repos/neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX=${HOME}/bin/neovim && make install)
# Get helptags up
VIMRUNTIME=~/repos/neovim/runtime ~/repos/neovim/build/bin/nvim --cmd 'helptags ~/repos/neovim/runtime/doc/' --cmd 'q'
# Install neovim ruby provider
sudo gem install neovim

# Ranger
mkdir ~/.config/ranger
ln -sf ~/repos/rcfiles/ranger.conf ~/.config/ranger/rc.conf

# ZSH
# Warn rather than remove anything found, we can't be certain the global config
# files don't have anything important.
sudo usermod -s $(which zsh) $(whoami)
echo "ZSH: Watch out for global zsh config files."
echo "Check in /etc/zsh for anything that you don't want (e.g. /etc/zsh/zshrc)."
echo "e.g. Ubuntu will probably have something annoying there."

# Scripts
# assume whatever settings are on the machine, if ~/bin exists then PATH will
# include it.
mkdir ~/bin 2>/dev/null
for i in ~/repos/useful-files/general/{allow-ptrace,asbytes,disasbytes,dis,grep_column,searchPATH,see_mem.py,show_column,swap,xxdreverse,grep-man,get-section,search-block-c-comments,differences-between-lines};
do
    ln -sf $i ~/bin/${i##*/};
done

# Keyboard
# What I have on my machine is these two files in xorg.conf.d
# TODO Check what should happen with Ubuntu and other managed distros.

cat <<EOF > /etc/X11/xorg.conf.d/10-keyboard.conf
Section "InputClass"
	Identifier		"Keyboard Defaults"
	MatchIsKeyboard		"Yes"
	Option			"XkbLayout" "gb"
EndSection
EOF

cat <<EOF > /etc/X11/xorg.conf.d/11-usb-keyboard.conf
Section "InputClass"
	Identifier		"Keyboardio"
	MatchIsKeyboard		"Yes"
	MatchProduct		"Keyboardio"
	Option			"XkbLayout" "us"
EndSection
EOF

# Tamsyn font
# TODO Would like to use wget to find the latest from the original authors website.
# TODO Make this more robust against name clashes (unlikely there's a
# tamsyn-... directory, but possible).
#   Put fonts in a local directory and add that to the list instead of global
#   one.
wget http://www.fial.com/~scott/tamsyn-font/download/tamsyn-font-1.11.tar.gz
tar -xzf tamsyn-font-1.11.tar.gz
sudo cp tamsyn-font-1.11/* /usr/local/share/fonts
sudo mkfontdir /usr/local/share/fonts

# These are for the current session
xset +fp /usr/local/share/fonts
fc-cache /usr/local/share/fonts

# This is for future logins.
cat <<EOF > /usr/share/X11/xorg.conf.d/99-extra-font-dir.conf
Section "Files"
    FontPath "/usr/local/share/fonts"
EndSection
EOF

# Installing emacs.
# Build from source because that gives much better ability to search for things 
cd ~/repos/
git clone git://git.sv.gnu.org/emacs.git
cd emacs
git checkout emacs-30
make configure="--prefix=${HOME}/bin/emacs CFLAGS='-O3 -g3'"
make install

mkdir -p ~/repos/binutils/build
cd ~/repos/binutils
git clone git://sourceware.org/git/binutils-gdb.git source
cd build
../source/configure --prefix=${HOME}/repos/binutils/install
make install

# Weechat commands to get it set up:
# /server add oftc irc.oftc.net -autoconnect
# /server add libera irc.libera.chat -autoconnect

# Use package source https://apt.llvm.org/ to install most recent clang
# - Install clangd from here, plus clang-tools as a whole.
#
# work [17:31:39] % apt list --installed | grep clang | grep 18
#
# WARNING: apt does not have a stable CLI interface. Use with caution in scripts.
#
# clang-18/unknown,now 1:18.1.6~++20240518023231+1118c2e05e67-1~exp1~20240518143320.131 amd64 [installed]
# clang-tools-18/unknown,now 1:18.1.6~++20240518023231+1118c2e05e67-1~exp1~20240518143320.131 amd64 [installed]
# libclang-18-dev/unknown,now 1:18.1.6~++20240518023231+1118c2e05e67-1~exp1~20240518143320.131 amd64 [installed,automatic]

# *OR* build llvm from source (with debug info) for better debugging of clang
# tools I write.

# Install `bear'

# Run `bear' on binutils, gdb, gcc, builds and copy compile_commands.json to the
# relevant directories.

# Run ctags on each directory that I care about (both emacs and vim tag style).
#   - ctags-exuberant -e -R --fields=+iaS --extra=+qf .
#   - ctags-exuberant -R --fields=+iaS --extra=+qf .

# Installing lua LSP manually from source.
# Download the binary -- description of how to proceed is given in the below
# link.
#     https://luals.github.io/#neovim-install
