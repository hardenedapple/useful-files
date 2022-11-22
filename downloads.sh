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

install-packages () {
    # Attempt to install everything I want.
    if command -v apt; then
        sudo apt install gcc g++ clang gdb make git mercurial zsh emacs vim neovim i3 i3status ranger cmake pkg-config ninja-build autoconf automake cscope exuberant-ctags python3-neovim xsel weechat
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
# Have to do this other `cask-initialize` doesn't set the `load-path` correctly.
# This is because the newer versions of `cask-initialize` tests whether it's
# already done its work with
# `(f-same? (epl-package-dir) (epl-default-package-dir))`
# while older versions tested with
# `(equal (epl-package-dir) (epl-default-package-dir))`
# since f-same? returns `nil` if either of the two files don't exist, this
# returns `nil` despite the two strings being identical.
touch ~/.emacs.d/elpa
cask/bin/cask
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
cd bundle/python-mode
git checkout develop
popd

# Neovim
ln -sf ~/.vim ~/.config/nvim

# Neovim full
git clone https://github.com/hardenedapple/neovim ~/repos/neovim
(cd ~/repos/neovim && git checkout local-head && make)
# Get helptags up
VIMRUNTIME=~/repos/neovim/runtime ~/repos/neovim/build/bin/nvim --cmd 'helptags ~/repos/neovim/runtime/doc/' --cmd 'q'

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
for i in ~/repos/useful-files/general/{asbytes,disasbytes,dis,grep_column,searchPATH,see_mem.py,show_column,swap,xxdreverse,grep-man,get-section};
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
	Identifier		"Erg keyboard"
	MatchIsKeyboard		"Yes"
    MatchProduct    "Truly Ergonomic"
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
