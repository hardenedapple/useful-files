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
remote: Counting objects:   1% (1/57)        remote: Counting objects:   3% (2/57)        remote: Counting objects:   5% (3/57)        remote: Counting objects:   7% (4/57)        remote: Counting objects:   8% (5/57)        remote: Counting objects:  10% (6/57)        remote: Counting objects:  12% (7/57)        remote: Counting objects:  14% (8/57)        remote: Counting objects:  15% (9/57)        remote: Counting objects:  17% (10/57)        remote: Counting objects:  19% (11/57)        remote: Counting objects:  21% (12/57)        remote: Counting objects:  22% (13/57)        remote: Counting objects:  24% (14/57)        remote: Counting objects:  26% (15/57)        remote: Counting objects:  28% (16/57)        remote: Counting objects:  29% (17/57)        remote: Counting objects:  31% (18/57)        remote: Counting objects:  33% (19/57)        remote: Counting objects:  35% (20/57)        remote: Counting objects:  36% (21/57)        remote: Counting objects:  38% (22/57)        remote: Counting objects:  40% (23/57)        remote: Counting objects:  42% (24/57)        remote: Counting objects:  43% (25/57)        remote: Counting objects:  45% (26/57)        remote: Counting objects:  47% (27/57)        remote: Counting objects:  49% (28/57)        remote: Counting objects:  50% (29/57)        remote: Counting objects:  52% (30/57)        remote: Counting objects:  54% (31/57)        remote: Counting objects:  56% (32/57)        remote: Counting objects:  57% (33/57)        remote: Counting objects:  59% (34/57)        remote: Counting objects:  61% (35/57)        remote: Counting objects:  63% (36/57)        remote: Counting objects:  64% (37/57)        remote: Counting objects:  66% (38/57)        remote: Counting objects:  68% (39/57)        remote: Counting objects:  70% (40/57)        remote: Counting objects:  71% (41/57)        remote: Counting objects:  73% (42/57)        remote: Counting objects:  75% (43/57)        remote: Counting objects:  77% (44/57)        remote: Counting objects:  78% (45/57)        remote: Counting objects:  80% (46/57)        remote: Counting objects:  82% (47/57)        remote: Counting objects:  84% (48/57)        remote: Counting objects:  85% (49/57)        remote: Counting objects:  87% (50/57)        remote: Counting objects:  89% (51/57)        remote: Counting objects:  91% (52/57)        remote: Counting objects:  92% (53/57)        remote: Counting objects:  94% (54/57)        remote: Counting objects:  96% (55/57)        remote: Counting objects:  98% (56/57)        remote: Counting objects: 100% (57/57)        remote: Counting objects: 100% (57/57), done.        
remote: Compressing objects:   2% (1/35)        remote: Compressing objects:   5% (2/35)        remote: Compressing objects:   8% (3/35)        remote: Compressing objects:  11% (4/35)        remote: Compressing objects:  14% (5/35)        remote: Compressing objects:  17% (6/35)        remote: Compressing objects:  20% (7/35)        remote: Compressing objects:  22% (8/35)        remote: Compressing objects:  25% (9/35)        remote: Compressing objects:  28% (10/35)        remote: Compressing objects:  31% (11/35)        remote: Compressing objects:  34% (12/35)        remote: Compressing objects:  37% (13/35)        remote: Compressing objects:  40% (14/35)        remote: Compressing objects:  42% (15/35)        remote: Compressing objects:  45% (16/35)        remote: Compressing objects:  48% (17/35)        remote: Compressing objects:  51% (18/35)        remote: Compressing objects:  54% (19/35)        remote: Compressing objects:  57% (20/35)        remote: Compressing objects:  60% (21/35)        remote: Compressing objects:  62% (22/35)        remote: Compressing objects:  65% (23/35)        remote: Compressing objects:  68% (24/35)        remote: Compressing objects:  71% (25/35)        remote: Compressing objects:  74% (26/35)        remote: Compressing objects:  77% (27/35)        remote: Compressing objects:  80% (28/35)        remote: Compressing objects:  82% (29/35)        remote: Compressing objects:  85% (30/35)        remote: Compressing objects:  88% (31/35)        remote: Compressing objects:  91% (32/35)        remote: Compressing objects:  94% (33/35)        remote: Compressing objects:  97% (34/35)        remote: Compressing objects: 100% (35/35)        remote: Compressing objects: 100% (35/35), done.        
Receiving objects:   0% (1/1058)Receiving objects:   1% (11/1058)Receiving objects:   2% (22/1058)Receiving objects:   3% (32/1058)Receiving objects:   4% (43/1058)Receiving objects:   5% (53/1058)Receiving objects:   6% (64/1058)Receiving objects:   7% (75/1058)Receiving objects:   8% (85/1058)Receiving objects:   9% (96/1058)Receiving objects:  10% (106/1058)Receiving objects:  11% (117/1058)Receiving objects:  12% (127/1058)Receiving objects:  13% (138/1058)Receiving objects:  14% (149/1058)Receiving objects:  15% (159/1058)Receiving objects:  16% (170/1058)Receiving objects:  17% (180/1058)Receiving objects:  18% (191/1058)Receiving objects:  19% (202/1058)Receiving objects:  20% (212/1058)Receiving objects:  21% (223/1058)Receiving objects:  22% (233/1058)Receiving objects:  23% (244/1058)Receiving objects:  24% (254/1058)Receiving objects:  25% (265/1058)Receiving objects:  26% (276/1058)Receiving objects:  27% (286/1058)Receiving objects:  28% (297/1058)Receiving objects:  29% (307/1058)Receiving objects:  30% (318/1058)Receiving objects:  31% (328/1058)Receiving objects:  32% (339/1058)Receiving objects:  33% (350/1058)Receiving objects:  34% (360/1058)Receiving objects:  35% (371/1058)Receiving objects:  36% (381/1058)Receiving objects:  37% (392/1058)Receiving objects:  38% (403/1058)Receiving objects:  39% (413/1058)Receiving objects:  40% (424/1058)Receiving objects:  41% (434/1058)Receiving objects:  42% (445/1058)Receiving objects:  43% (455/1058)Receiving objects:  44% (466/1058)Receiving objects:  45% (477/1058)Receiving objects:  46% (487/1058)Receiving objects:  47% (498/1058)Receiving objects:  48% (508/1058)Receiving objects:  49% (519/1058)Receiving objects:  50% (529/1058)Receiving objects:  51% (540/1058)Receiving objects:  52% (551/1058)Receiving objects:  53% (561/1058)Receiving objects:  54% (572/1058)Receiving objects:  55% (582/1058)Receiving objects:  56% (593/1058)Receiving objects:  57% (604/1058)Receiving objects:  58% (614/1058)Receiving objects:  59% (625/1058)Receiving objects:  60% (635/1058)Receiving objects:  61% (646/1058)Receiving objects:  62% (656/1058)Receiving objects:  63% (667/1058)Receiving objects:  64% (678/1058), 292.01 KiB | 546.00 KiB/sReceiving objects:  65% (688/1058), 292.01 KiB | 546.00 KiB/sReceiving objects:  66% (699/1058), 292.01 KiB | 546.00 KiB/sReceiving objects:  67% (709/1058), 292.01 KiB | 546.00 KiB/sReceiving objects:  68% (720/1058), 292.01 KiB | 546.00 KiB/sReceiving objects:  69% (731/1058), 292.01 KiB | 546.00 KiB/sReceiving objects:  70% (741/1058), 292.01 KiB | 546.00 KiB/sReceiving objects:  71% (752/1058), 292.01 KiB | 546.00 KiB/sReceiving objects:  72% (762/1058), 292.01 KiB | 546.00 KiB/sReceiving objects:  73% (773/1058), 292.01 KiB | 546.00 KiB/sReceiving objects:  74% (783/1058), 292.01 KiB | 546.00 KiB/sReceiving objects:  75% (794/1058), 292.01 KiB | 546.00 KiB/sReceiving objects:  76% (805/1058), 292.01 KiB | 546.00 KiB/sReceiving objects:  77% (815/1058), 292.01 KiB | 546.00 KiB/sReceiving objects:  78% (826/1058), 292.01 KiB | 546.00 KiB/sReceiving objects:  79% (836/1058), 292.01 KiB | 546.00 KiB/sReceiving objects:  80% (847/1058), 292.01 KiB | 546.00 KiB/sReceiving objects:  81% (857/1058), 292.01 KiB | 546.00 KiB/sReceiving objects:  82% (868/1058), 292.01 KiB | 546.00 KiB/sReceiving objects:  83% (879/1058), 292.01 KiB | 546.00 KiB/sReceiving objects:  84% (889/1058), 292.01 KiB | 546.00 KiB/sReceiving objects:  85% (900/1058), 292.01 KiB | 546.00 KiB/sReceiving objects:  86% (910/1058), 292.01 KiB | 546.00 KiB/sReceiving objects:  87% (921/1058), 292.01 KiB | 546.00 KiB/sReceiving objects:  88% (932/1058), 292.01 KiB | 546.00 KiB/sReceiving objects:  89% (942/1058), 292.01 KiB | 546.00 KiB/sReceiving objects:  90% (953/1058), 292.01 KiB | 546.00 KiB/sReceiving objects:  91% (963/1058), 292.01 KiB | 546.00 KiB/sReceiving objects:  92% (974/1058), 292.01 KiB | 546.00 KiB/sReceiving objects:  93% (984/1058), 292.01 KiB | 546.00 KiB/sReceiving objects:  94% (995/1058), 292.01 KiB | 546.00 KiB/sReceiving objects:  95% (1006/1058), 292.01 KiB | 546.00 KiB/sReceiving objects:  96% (1016/1058), 292.01 KiB | 546.00 KiB/sReceiving objects:  97% (1027/1058), 292.01 KiB | 546.00 KiB/sremote: Total 1058 (delta 31), reused 44 (delta 22), pack-reused 1001        
Receiving objects:  98% (1037/1058), 292.01 KiB | 546.00 KiB/sReceiving objects:  99% (1048/1058), 292.01 KiB | 546.00 KiB/sReceiving objects: 100% (1058/1058), 292.01 KiB | 546.00 KiB/sReceiving objects: 100% (1058/1058), 428.94 KiB | 774.00 KiB/s, done.
Resolving deltas:   0% (0/684)Resolving deltas:   1% (7/684)Resolving deltas:   2% (14/684)Resolving deltas:   3% (21/684)Resolving deltas:   4% (28/684)Resolving deltas:   5% (36/684)Resolving deltas:   6% (42/684)Resolving deltas:   7% (49/684)Resolving deltas:   8% (56/684)Resolving deltas:   9% (62/684)Resolving deltas:  10% (69/684)Resolving deltas:  11% (78/684)Resolving deltas:  12% (85/684)Resolving deltas:  13% (89/684)Resolving deltas:  14% (101/684)Resolving deltas:  15% (105/684)Resolving deltas:  16% (116/684)Resolving deltas:  17% (118/684)Resolving deltas:  18% (125/684)Resolving deltas:  19% (130/684)Resolving deltas:  20% (137/684)Resolving deltas:  21% (147/684)Resolving deltas:  22% (151/684)Resolving deltas:  23% (158/684)Resolving deltas:  24% (166/684)Resolving deltas:  25% (171/684)Resolving deltas:  26% (178/684)Resolving deltas:  27% (185/684)Resolving deltas:  28% (192/684)Resolving deltas:  29% (199/684)Resolving deltas:  30% (206/684)Resolving deltas:  31% (213/684)Resolving deltas:  32% (221/684)Resolving deltas:  33% (227/684)Resolving deltas:  34% (233/684)Resolving deltas:  35% (242/684)Resolving deltas:  36% (247/684)Resolving deltas:  37% (254/684)Resolving deltas:  38% (260/684)Resolving deltas:  39% (271/684)Resolving deltas:  40% (274/684)Resolving deltas:  41% (281/684)Resolving deltas:  42% (288/684)Resolving deltas:  43% (295/684)Resolving deltas:  44% (301/684)Resolving deltas:  45% (308/684)Resolving deltas:  46% (319/684)Resolving deltas:  47% (325/684)Resolving deltas:  48% (329/684)Resolving deltas:  49% (336/684)Resolving deltas:  50% (342/684)Resolving deltas:  51% (350/684)Resolving deltas:  52% (356/684)Resolving deltas:  53% (363/684)Resolving deltas:  54% (371/684)Resolving deltas:  55% (377/684)Resolving deltas:  56% (386/684)Resolving deltas:  57% (391/684)Resolving deltas:  58% (397/684)Resolving deltas:  59% (404/684)Resolving deltas:  60% (413/684)Resolving deltas:  61% (419/684)Resolving deltas:  62% (425/684)Resolving deltas:  63% (432/684)Resolving deltas:  64% (438/684)Resolving deltas:  65% (447/684)Resolving deltas:  66% (452/684)Resolving deltas:  67% (462/684)Resolving deltas:  68% (466/684)Resolving deltas:  69% (472/684)Resolving deltas:  70% (479/684)Resolving deltas:  71% (487/684)Resolving deltas:  72% (493/684)Resolving deltas:  73% (500/684)Resolving deltas:  74% (507/684)Resolving deltas:  75% (513/684)Resolving deltas:  76% (520/684)Resolving deltas:  77% (529/684)Resolving deltas:  78% (534/684)Resolving deltas:  79% (541/684)Resolving deltas:  80% (549/684)Resolving deltas:  81% (555/684)Resolving deltas:  82% (562/684)Resolving deltas:  83% (569/684)Resolving deltas:  84% (575/684)Resolving deltas:  85% (582/684)Resolving deltas:  86% (591/684)Resolving deltas:  87% (596/684)Resolving deltas:  88% (602/684)Resolving deltas:  89% (609/684)Resolving deltas:  90% (616/684)Resolving deltas:  91% (625/684)Resolving deltas:  92% (631/684)Resolving deltas:  93% (637/684)Resolving deltas:  94% (643/684)Resolving deltas:  95% (650/684)Resolving deltas:  96% (657/684)Resolving deltas:  97% (667/684)Resolving deltas:  98% (671/684)Resolving deltas:  99% (678/684)Resolving deltas: 100% (684/684)Resolving deltas: 100% (684/684), done.
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

tamsyn-font-1.11.ta   0%[                    ]       0  --.-KB/s               tamsyn-font-1.11.ta  11%[=>                  ]   6.28K  18.8KB/s               tamsyn-font-1.11.ta  27%[====>               ]  15.50K  23.1KB/s               tamsyn-font-1.11.ta  43%[=======>            ]  24.71K  24.4KB/s               tamsyn-font-1.11.ta  68%[============>       ]  39.19K  29.0KB/s               tamsyn-font-1.11.ta  89%[================>   ]  51.04K  31.0KB/s               tamsyn-font-1.11.ta 100%[===================>]  57.02K  33.6KB/s    in 1.7s    

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
Reading package lists... 0%Reading package lists... 100%Reading package lists... Done
Building dependency tree... 0%Building dependency tree... 0%Building dependency tree... 50%Building dependency tree... 50%Building dependency tree... Done
Reading state information... 0% Reading state information... 0%Reading state information... Done
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
Reading package lists... 0%Reading package lists... 100%Reading package lists... Done
Building dependency tree... 0%Building dependency tree... 0%Building dependency tree... 50%Building dependency tree... 50%Building dependency tree... Done
Reading state information... 0% Reading state information... 0%Reading state information... Done
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
