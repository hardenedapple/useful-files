vshcmd: > for i in ~/repos/useful-files/rcfiles/{zshrc,zshenv,bashrc,inputrc,infokey,gitconfig,tmux.conf};
useful-files [16:15:40] $ 
vshcmd: > do
vshcmd: >     ln -fs $i ~/.${i##*/};
vshcmd: > done
vshcmd: > echo "Watch out for .profile, .bash_profile, and any other dotfiles that we haven't overwritten."
> > > mmalcomson@f2784bb-lcelt:~$ Watch out for .profile, .bash_profile, and any other dotfiles that we haven't overwritten.
mmalcomson@f2784bb-lcelt:~$ 
vshcmd: > git clone https://github.com/hardenedapple/gdb-walkers ~/.config/gdb
Cloning into '/home/mmalcomson/.config/gdb'...
remote: Enumerating objects: 1058, done.        
remote: Counting objects:   1% (1/57)        
remote: Compressing objects:   2% (1/35)        
Receiving objects:   0% (1/1058)
Receiving objects:  98% (1037/1058), 292.01 KiB | 546.00 KiB/s
Resolving deltas:   0% (0/684)
mmalcomson@f2784bb-lcelt:~$ 
vshcmd: > cp ~/repos/useful-files/rcfiles/gdbinit ~/.gdbinit
~ [09:53:39] $ 
vshcmd: > cp 
vshcmd: > rm ~/.gdbinit 
~ [09:53:30] $ 
vshcmd: > help mark-this
Undefined command: "mark-this".  Try "help".
(gdb) 
vshcmd: > cd ~/.config/gdb
vshcmd: > git checkout personalised
>>> 
vshcmd: > 
vshcmd: > # Emacs
vshcmd: > pushd ~/.emacs.d
~/.emacs.d ~
.emacs.d [13:21:48] $ 
vshcmd: > cd vsh
vshcmd: > git status
vshcmd: > ls vsh-mode-1.0/
[0m[40;31;01mintegration_with_gdb.py[0m  [01;36mvsh_man_pager[0m    [01;36mvsh_shell_start[0m
[01;36mvsh_editor_prog[0m          vsh-mode.el      [01;36mvsh_tell_editor_bindings.py[0m
vsh-elisp-tests.el       vsh-mode-pkg.el  vsh-tests.erts
vsh [13:23:02] $ 
vshcmd: > rm vsh-mode-1.0.tar
vsh [13:24:24] $ 
vshcmd: > cd vsh-mode-1.0/
vshcmd: > ln -sf ../integration/with_gdb.py ./integration_with_gdb.py
vsh-mode-1.0 [13:25:09] $ 
vshcmd: > cat ~/repos/useful-files/xresources/base_resources ~/repos/useful-files/xresources/own_colors > ~/.Xresources
~ [13:26:04] $ 
vshcmd: > ln -sf ~/.vim ~/.config/nvim
~ [13:26:17] $ 
vshcmd: > cd repos
vshcmd: > git clone https://github.com/neovim/neovim ~/repos/neovim
vshcmd: > (cd ~/repos/neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX=${HOME}/bin/neovim && make install)

vshcmd: > mkdir -p ~/.config/i3 ~/.config/i3status
vshcmd: > ln -sf ~/repos/useful-files/rcfiles/i3config ~/.config/i3/
vshcmd: > ln -sf ~/repos/useful-files/rcfiles/i3status.conf ~/.config/i3/
vshcmd: > cat ~/repos/useful-files/xresources/base_resources ~/repos/useful-files/xresources/own_colors > ~/.Xresources
~ [15:17:04] $ 
vshcmd: > newdir temp
temp [15:18:08] $ 
vshcmd: > wget http://www.fial.com/~scott/tamsyn-font/download/tamsyn-font-1.11.tar.gz
vshcmd: > tar -xzf tamsyn-font-1.11.tar.gz
--2024-07-15 15:18:10--  http://www.fial.com/~scott/tamsyn-font/download/tamsyn-font-1.11.tar.gz
Resolving www.fial.com (www.fial.com)... 50.196.1.215
Connecting to www.fial.com (www.fial.com)|50.196.1.215|:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 58384 (57K) [application/x-gzip]
Saving to: ‘tamsyn-font-1.11.tar.gz’



2024-07-15 15:18:13 (33.6 KB/s) - ‘tamsyn-font-1.11.tar.gz’ saved [58384/58384]

temp [15:18:13] $ temp [15:18:13] $ 
vshcmd: > sudo cp tamsyn-font-1.11/* /usr/local/share/fonts
vshcmd: > sudo mkfontdir /usr/local/share/fonts
vshcmd: > xset +fp /usr/local/share/fonts
vshcmd: > fc-cache /usr/local/share/fonts
temp [15:19:03] $ temp [15:19:03] $ 
vshcmd: > ls ~/bin
vshcmd: > for i in ~/repos/useful-files/general/{allow-ptrace,asbytes,disasbytes,dis,grep_column,searchPATH,see_mem.py,show_column,swap,xxdreverse,grep-man,get-section,search-block-c-comments,differences-between-lines};
vshcmd: > do
vshcmd: >     ln -sf $i ~/bin/${i##*/};
vshcmd: > done
> > > temp [15:23:12] $ 
vshcmd: > ls /etc/X11/xorg.conf.d/

vshcmd: > sudo su
root@f2784bb-lcelt:/home/mmalcomson/temp# 
vshcmd: > cat <<EOF > /etc/X11/xorg.conf.d/10-keyboard.conf
vshcmd: > Section "InputClass"
vshcmd: >         Identifier		"Keyboard Defaults"
vshcmd: >         MatchIsKeyboard		"Yes"
vshcmd: >         Option			"XkbLayout" "gb"
vshcmd: > EndSection
vshcmd: > EOF
vshcmd: > 
vshcmd: > cat <<EOF > /etc/X11/xorg.conf.d/11-usb-keyboard.conf
vshcmd: > Section "InputClass"
vshcmd: >         Identifier		"Erg keyboard"
vshcmd: >         MatchIsKeyboard		"Yes"
vshcmd: >     MatchProduct    "Truly Ergonomic"
vshcmd: >         Option			"XkbLayout" "us"
vshcmd: > EndSection
vshcmd: > EOF
vshcmd: >
vshcmd: > cat <<EOF > /usr/share/X11/xorg.conf.d/99-extra-font-dir.conf
vshcmd: > Section "Files"
vshcmd: >     FontPath "/usr/local/share/fonts"
vshcmd: > EndSection
vshcmd: > EOF
> > > > root@f2784bb-lcelt:/home/mmalcomson/temp# exit
temp [15:24:51] $ 
vshcmd: > mkdir ~/.config/ranger
vshcmd: > ln -sf ~/repos/rcfiles/ranger.conf ~/.config/ranger/rc.conf

vshcmd: > cd ~/repos
repos [15:45:46] $ 
vshcmd: > git clone git://git.sv.gnu.org/emacs.git
vshcmd: > cd ~/repos/emacs
vshcmd: > make clean
vshcmd: > git checkout emacs-30
branch 'emacs-30' set up to track 'origin/emacs-30'.
Switched to a new branch 'emacs-30'
emacs [17:26:00] $ 
vshcmd: > sudo apt install libgcc-14-dev



libgcc-14-dev is already the newest version (14-20240412-0ubuntu1).
libgcc-14-dev set to manually installed.
The following packages were automatically installed and are no longer required:
  binaryen cuda-cccl-12-5 cuda-command-line-tools-12-5 cuda-cudart-12-5
  cuda-cudart-dev-12-5 cuda-cuobjdump-12-5 cuda-cupti-12-5 cuda-cupti-dev-12-5
  cuda-cuxxfilt-12-5 cuda-documentation-12-5 cuda-driver-dev-12-5
  cuda-gdb-12-5 cuda-libraries-12-5 cuda-libraries-dev-12-5 cuda-nsight-12-5
  cuda-nsight-compute-12-5 cuda-nsight-systems-12-5 cuda-nvdisasm-12-5
  cuda-nvml-dev-12-5 cuda-nvprof-12-5 cuda-nvprune-12-5 cuda-nvrtc-12-5
  cuda-nvrtc-dev-12-5 cuda-nvtx-12-5 cuda-nvvp-12-5 cuda-opencl-12-5
  cuda-opencl-dev-12-5 cuda-profiler-api-12-5 cuda-sanitizer-12-5
  cuda-toolkit-12-5-config-common cuda-toolkit-12-config-common
  cuda-toolkit-config-common cuda-tools-12-5 cuda-visual-tools-12-5
  gds-tools-12-5 libcc1-0 libclang-common-15-dev libclang-cpp15t64
  libclang-rt-15-dev libclang1-15t64 libcublas-12-5 libcublas-dev-12-5
  libcufft-12-5 libcufft-dev-12-5 libcufile-12-5 libcufile-dev-12-5
  libcurand-12-5 libcurand-dev-12-5 libcusolver-12-5 libcusolver-dev-12-5
  libcusparse-12-5 libcusparse-dev-12-5 libgfortran5 libjs-d3 liblapack3
  libllvm15t64 libnpp-12-5 libnpp-dev-12-5 libnvfatbin-12-5
  libnvfatbin-dev-12-5 libnvidia-cfg1-555 libnvidia-common-555
  libnvidia-decode-555 libnvidia-encode-555 libnvidia-extra-555
  libnvidia-fbc1-555 libnvidia-gl-555 libnvjitlink-12-5 libnvjitlink-dev-12-5
  libnvjpeg-12-5 libnvjpeg-dev-12-5 libobjc4 libpfm4 libxml2-dev libxnvctrl0
  libz3-4 libz3-dev lld-15 llvm-15 llvm-15-dev llvm-15-linker-tools
  llvm-15-runtime llvm-15-tools llvm-18 llvm-18-dev llvm-18-linker-tools
  llvm-18-runtime llvm-18-tools nsight-compute-2024.2.1
  nsight-systems-2024.2.3 nvidia-compute-utils-555
  nvidia-firmware-555-555.42.06 nvidia-kernel-common-555
  nvidia-kernel-source-555 nvidia-settings nvidia-utils-555 python3-numpy
  screen-resolution-extra xserver-xorg-video-nvidia-555
Use 'sudo apt autoremove' to remove them.
0 upgraded, 0 newly installed, 0 to remove and 20 not upgraded.
emacs [17:29:12] $ 
vshcmd: > sudo apt install libgccjit-dev



[1;31mE: [0mUnable to locate package libgccjit-dev[0m
emacs [17:27:55] $ 
vshcmd: > apt search libgcc | grep libgccjit.*dev

WARNING: apt does not have a stable CLI interface. Use with caution in scripts.

libgccjit-10-dev/noble 10.5.0-4ubuntu2 amd64
libgccjit-11-dev/noble 11.4.0-9ubuntu1 amd64
libgccjit-12-dev/noble 12.3.0-17ubuntu1 amd64
libgccjit-13-dev/noble 13.2.0-23ubuntu4 amd64
libgccjit-14-dev/noble,now 14-20240412-0ubuntu1 amd64 [installed]
libgccjit-9-dev/noble 9.5.0-6ubuntu2 amd64
emacs [17:29:04] $ 
vshcmd: > git clean -fdx
vshcmd: > make configure="--prefix=/home/mmalcomson/bin/emacs CFLAGS='-O3 -g3' CC=gcc-14"

vshcmd: > make install

vshcmd: > cd ~/Documents
vshcmd: > ls
Documents [18:23:52] $ 