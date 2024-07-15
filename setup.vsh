vshcmd: > for i in ~/repos/useful-files/rcfiles/{zshrc,zshenv,bashrc,inputrc,infokey,gitconfig,tmux.conf};
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
cmake -S /home/mmalcomson/repos/neovim//cmake.deps -B .deps -G 'Ninja' \
	  
-- Found GNU Make at /usr/bin/gmake
-- CMAKE_BUILD_TYPE=RelWithDebInfo
-- Configuring done (0.1s)
-- Generating done (0.0s)
-- Build files have been written to: /home/mmalcomson/repos/neovim/.deps
mkdir -p build
touch build/.ran-deps-cmake
ninja -C .deps
ninja: Entering directory `.deps'
ninja: no work to do.
cmake -B build -G 'Ninja' -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=/home/mmalcomson/bin/neovim /home/mmalcomson/repos/neovim/
-- Found GNU Make at /usr/bin/gmake
-- CMAKE_INSTALL_PREFIX=/home/mmalcomson/bin/neovim
-- CMAKE_BUILD_TYPE=RelWithDebInfo
-- Using Lua interpreter: /home/mmalcomson/repos/neovim/.deps/usr/bin/luajit
-- Using Lua interpreter for code generation: /home/mmalcomson/repos/neovim/.deps/usr/bin/luajit
-- Using Lua compiler: /home/mmalcomson/repos/neovim/.deps/usr/bin/luajit -b -s %s -
-- main_lib props '/home/mmalcomson/repos/neovim/.deps/usr/include/luajit-2.1;/home/mmalcomson/repos/neovim/.deps/usr/include;/home/mmalcomson/repos/neovim/build/src/nvim/auto;/home/mmalcomson/repos/neovim/build/include;/home/mmalcomson/repos/neovim/build/cmake.config;/home/mmalcomson/repos/neovim/src'
-- nlua0 props '/home/mmalcomson/repos/neovim/.deps/usr/include/luajit-2.1;/home/mmalcomson/repos/neovim/src;/home/mmalcomson/repos/neovim/build/cmake.config;/home/mmalcomson/repos/neovim/build/include'
-- iconv props '/usr/include'
-- libuv props '/home/mmalcomson/repos/neovim/.deps/usr/include'
-- libvterm props '/home/mmalcomson/repos/neovim/.deps/usr/include'
-- msgpack props '/home/mmalcomson/repos/neovim/.deps/usr/include'
-- treesitter props '/home/mmalcomson/repos/neovim/.deps/usr/include'
-- unibilium props '/home/mmalcomson/repos/neovim/.deps/usr/include'
-- utf8proc props '/home/mmalcomson/repos/neovim/.deps/usr/include'
-- libintl props '/usr/include'
-- Found Gettext: /usr/bin/msgmerge (found version "0.21") 
-- Performing Test HAVE_EXECINFO_BACKTRACE
-- Performing Test HAVE_EXECINFO_BACKTRACE - Success
-- Performing Test HAVE_BUILTIN_ADD_OVERFLOW
-- Performing Test HAVE_BUILTIN_ADD_OVERFLOW - Success
-- Looking for sys/types.h
-- Looking for sys/types.h - found
-- Looking for stdint.h
-- Looking for stdint.h - found
-- Looking for stddef.h
-- Looking for stddef.h - found
-- Check size of int
-- Check size of int - done
-- Check size of long
-- Check size of long - done
-- Check size of intmax_t
-- Check size of intmax_t - done
-- Check size of size_t
-- Check size of size_t - done
-- Check size of void *
-- Check size of void * - done
-- Looking for _NSGetEnviron
-- Looking for _NSGetEnviron - not found
-- Looking for include file langinfo.h
-- Looking for include file langinfo.h - found
-- Looking for include file strings.h
-- Looking for include file strings.h - found
-- Looking for include file sys/utsname.h
-- Looking for include file sys/utsname.h - found
-- Looking for include file termios.h
-- Looking for include file termios.h - found
-- Looking for include file sys/uio.h
-- Looking for include file sys/uio.h - found
-- Looking for include file sys/sdt.h
-- Looking for include file sys/sdt.h - not found
-- Looking for include file sys/xattr.h
-- Looking for include file sys/xattr.h - found
-- Looking for fseeko
-- Looking for fseeko - found
-- Looking for readv
-- Looking for readv - found
-- Looking for readlink
-- Looking for readlink - found
-- Looking for strnlen
-- Looking for strnlen - found
-- Looking for strcasecmp
-- Looking for strcasecmp - found
-- Looking for strncasecmp
-- Looking for strncasecmp - found
-- Looking for strptime
-- Looking for strptime - found
-- Performing Test HAVE_DIRFD_AND_FLOCK
-- Performing Test HAVE_DIRFD_AND_FLOCK - Success
-- Performing Test HAVE_PWD_FUNCS
-- Performing Test HAVE_PWD_FUNCS - Success
-- Performing Test HAVE_BITSCANFORWARD64
-- Performing Test HAVE_BITSCANFORWARD64 - Failed
-- Looking for FD_CLOEXEC
-- Looking for FD_CLOEXEC - found
-- Looking for CODESET
-- Looking for CODESET - found
-- Looking for include file endian.h
-- Looking for include file endian.h - found
-- Performing Test HAVE_BE64TOH_MACROS
-- Performing Test HAVE_BE64TOH_MACROS - Success
-- Configuring done (1.7s)
-- Generating done (0.1s)
-- Build files have been written to: /home/mmalcomson/repos/neovim/build
touch build/.ran-cmake
ninja -C build
ninja: Entering directory `build'
[0/2] Re-checking globbed directories...
[1/647] Running utility command for nvim_runtime_deps
[2/647] Building C object src/nvim/CMakeFiles/nlua0.dir/__/nlua0.c.o
[3/647] Building C object src/nvim/CMakeFiles/nlua0.dir/__/mpack/object.c.o
[4/647] Building C object src/nvim/CMakeFiles/nlua0.dir/__/mpack/conv.c.o
[5/647] Building C object src/nvim/CMakeFiles/nlua0.dir/__/mpack/rpc.c.o
[6/647] Building C object src/nvim/CMakeFiles/nlua0.dir/__/mpack/mpack_core.c.o
[7/647] Building C object src/nvim/CMakeFiles/nlua0.dir/__/mpack/lmpack.c.o
[8/647] Linking C shared module lib/libnlua0.so
[9/647] cd /home/mmalcomson/repos/neovim/build/src/nvim && /usr/bin/cmake -D NVIM_VERSION_MAJOR=0 -D NVIM_VERSION_MINOR=11 -D NVIM_VERSION_PATCH=0 -D NVIM_VERSION_PRERELEASE=-dev -D OUTPUT=/home/mmalcomson/repos/neovim/build/cmake.config/auto/versiondef_git.h -D NVIM_SOURCE_DIR=/home/mmalcomson/repos/neovim -P /home/mmalcomson/repos/neovim/cmake/GenerateVersion.cmake
-- Using NVIM_VERSION: v0.11.0-dev-422+g3c803483a
[10/647] Generating auto/arabic.c.generated.h, ../../include/arabic.h.generated.h
[11/647] Generating auto/base64.c.generated.h, ../../include/base64.h.generated.h
[12/647] Generating auto/api/private/dispatch.c.generated.h, ../../include/api/private/dispatch.h.generated.h
[13/647] Generating auto/api/command.c.generated.h, ../../include/api/command.h.generated.h
[14/647] Generating auto/api/options.c.generated.h, ../../include/api/options.h.generated.h
[15/647] Generating auto/api/win_config.c.generated.h, ../../include/api/win_config.h.generated.h
[16/647] Generating auto/api/buffer.c.generated.h, ../../include/api/buffer.h.generated.h
[17/647] Generating auto/api/window.c.generated.h, ../../include/api/window.h.generated.h
[18/647] Generating auto/api/autocmd.c.generated.h, ../../include/api/autocmd.h.generated.h
[19/647] Generating auto/api/extmark.c.generated.h, ../../include/api/extmark.h.generated.h
[20/647] Generating auto/api/private/converter.c.generated.h, ../../include/api/private/converter.h.generated.h
[21/647] Generating auto/arglist.c.generated.h, ../../include/arglist.h.generated.h
[22/647] Generating auto/api/private/helpers.c.generated.h, ../../include/api/private/helpers.h.generated.h
[23/647] Generating auto/api/tabpage.c.generated.h, ../../include/api/tabpage.h.generated.h
[24/647] Generating auto/buffer_updates.c.generated.h, ../../include/buffer_updates.h.generated.h
[25/647] Generating auto/api/private/validate.c.generated.h, ../../include/api/private/validate.h.generated.h
[26/647] Generating auto/api/ui.c.generated.h, ../../include/api/ui.h.generated.h
[27/647] Generating auto/api/vimscript.c.generated.h, ../../include/api/vimscript.h.generated.h
[28/647] Generating auto/bufwrite.c.generated.h, ../../include/bufwrite.h.generated.h
[29/647] Generating auto/api/deprecated.c.generated.h, ../../include/api/deprecated.h.generated.h
[30/647] Generating auto/autocmd.c.generated.h, ../../include/autocmd.h.generated.h
[31/647] Generating auto/api/vim.c.generated.h, ../../include/api/vim.h.generated.h
[32/647] Generating auto/charset.c.generated.h, ../../include/charset.h.generated.h
[33/647] Generating auto/change.c.generated.h, ../../include/change.h.generated.h
[34/647] Generating auto/channel.c.generated.h, ../../include/channel.h.generated.h
[35/647] Generating auto/buffer.c.generated.h, ../../include/buffer.h.generated.h
[36/647] Generating auto/eval/gc.c.generated.h, ../../include/eval/gc.h.generated.h
[37/647] Generating auto/context.c.generated.h, ../../include/context.h.generated.h
[38/647] Generating auto/decoration_provider.c.generated.h, ../../include/decoration_provider.h.generated.h
[39/647] Generating auto/cursor_shape.c.generated.h, ../../include/cursor_shape.h.generated.h
[40/647] Generating auto/cursor.c.generated.h, ../../include/cursor.h.generated.h
[41/647] Generating auto/decoration.c.generated.h, ../../include/decoration.h.generated.h
[42/647] Generating auto/eval/buffer.c.generated.h, ../../include/eval/buffer.h.generated.h
[43/647] Generating auto/cmdhist.c.generated.h, ../../include/cmdhist.h.generated.h
[44/647] Generating auto/debugger.c.generated.h, ../../include/debugger.h.generated.h
[45/647] Generating auto/digraph.c.generated.h, ../../include/digraph.h.generated.h
[46/647] Generating auto/eval/decode.c.generated.h, ../../include/eval/decode.h.generated.h
[47/647] Generating auto/cmdexpand.c.generated.h, ../../include/cmdexpand.h.generated.h
[48/647] Generating auto/eval/window.c.generated.h, ../../include/eval/window.h.generated.h
[49/647] Generating auto/event/loop.c.generated.h, ../../include/event/loop.h.generated.h
[50/647] Generating auto/event/multiqueue.c.generated.h, ../../include/event/multiqueue.h.generated.h
[51/647] Generating auto/eval/executor.c.generated.h, ../../include/eval/executor.h.generated.h
[52/647] Generating auto/drawline.c.generated.h, ../../include/drawline.h.generated.h
[53/647] Generating auto/diff.c.generated.h, ../../include/diff.h.generated.h
[54/647] Generating auto/eval/userfunc.c.generated.h, ../../include/eval/userfunc.h.generated.h
[55/647] Generating auto/event/signal.c.generated.h, ../../include/event/signal.h.generated.h
[56/647] Generating auto/edit.c.generated.h, ../../include/edit.h.generated.h
[57/647] Generating auto/eval/typval.c.generated.h, ../../include/eval/typval.h.generated.h
[58/647] Generating auto/event/libuv_process.c.generated.h, ../../include/event/libuv_process.h.generated.h
[59/647] Generating auto/eval/vars.c.generated.h, ../../include/eval/vars.h.generated.h
[60/647] Generating auto/eval/encode.c.generated.h, ../../include/eval/encode.h.generated.h
[61/647] Generating auto/event/socket.c.generated.h, ../../include/event/socket.h.generated.h
[62/647] Generating auto/event/stream.c.generated.h, ../../include/event/stream.h.generated.h
[63/647] Generating auto/event/process.c.generated.h, ../../include/event/process.h.generated.h
[64/647] Generating auto/event/wstream.c.generated.h, ../../include/event/wstream.h.generated.h
[65/647] Generating auto/event/rstream.c.generated.h, ../../include/event/rstream.h.generated.h
[66/647] Generating auto/event/time.c.generated.h, ../../include/event/time.h.generated.h
[67/647] Generating auto/drawscreen.c.generated.h, ../../include/drawscreen.h.generated.h
[68/647] Generating auto/eval.c.generated.h, ../../include/eval.h.generated.h
[69/647] Generating auto/extmark.c.generated.h, ../../include/extmark.h.generated.h
[70/647] Generating auto/garray.c.generated.h, ../../include/garray.h.generated.h
[71/647] Generating auto/hashtab.c.generated.h, ../../include/hashtab.h.generated.h
[72/647] Generating auto/ex_eval.c.generated.h, ../../include/ex_eval.h.generated.h
[73/647] Generating auto/ex_cmds2.c.generated.h, ../../include/ex_cmds2.h.generated.h
[74/647] Generating auto/ex_session.c.generated.h, ../../include/ex_session.h.generated.h
[75/647] Generating auto/eval/funcs.c.generated.h, ../../include/eval/funcs.h.generated.h
[76/647] Generating auto/ex_cmds.c.generated.h, ../../include/ex_cmds.h.generated.h
[77/647] Generating auto/ex_docmd.c.generated.h, ../../include/ex_docmd.h.generated.h
[78/647] Generating auto/input.c.generated.h, ../../include/input.h.generated.h
[79/647] Generating auto/fold.c.generated.h, ../../include/fold.h.generated.h
[80/647] Generating auto/highlight.c.generated.h, ../../include/highlight.h.generated.h
[81/647] Generating auto/file_search.c.generated.h, ../../include/file_search.h.generated.h
[82/647] Generating auto/lua/base64.c.generated.h, ../../include/lua/base64.h.generated.h
[83/647] Generating auto/keycodes.c.generated.h, ../../include/keycodes.h.generated.h
[84/647] Generating auto/indent.c.generated.h, ../../include/indent.h.generated.h
[85/647] Generating auto/grid.c.generated.h, ../../include/grid.h.generated.h
[86/647] Generating auto/linematch.c.generated.h, ../../include/linematch.h.generated.h
[87/647] Generating auto/ex_getln.c.generated.h, ../../include/ex_getln.h.generated.h
[88/647] Generating auto/fileio.c.generated.h, ../../include/fileio.h.generated.h
[89/647] Generating auto/getchar.c.generated.h, ../../include/getchar.h.generated.h
[90/647] Generating auto/help.c.generated.h, ../../include/help.h.generated.h
[91/647] Generating auto/highlight_group.c.generated.h, ../../include/highlight_group.h.generated.h
[92/647] Generating auto/math.c.generated.h, ../../include/math.h.generated.h
[93/647] Generating auto/indent_c.c.generated.h, ../../include/indent_c.h.generated.h
[94/647] Generating auto/lua/secure.c.generated.h, ../../include/lua/secure.h.generated.h
[95/647] Generating auto/map.c.generated.h, ../../include/map.h.generated.h
[96/647] Generating auto/lua/api_wrappers.c.generated.h, ../../include/lua/api_wrappers.h.generated.h
[97/647] Generating auto/log.c.generated.h, ../../include/log.h.generated.h
[98/647] Generating auto/lua/stdlib.c.generated.h, ../../include/lua/stdlib.h.generated.h
[99/647] Generating auto/lua/spell.c.generated.h, ../../include/lua/spell.h.generated.h
[100/647] Generating auto/lua/xdiff.c.generated.h, ../../include/lua/xdiff.h.generated.h
[101/647] Generating auto/insexpand.c.generated.h, ../../include/insexpand.h.generated.h
[102/647] Generating auto/lua/treesitter.c.generated.h, ../../include/lua/treesitter.h.generated.h
[103/647] Generating auto/lua/converter.c.generated.h, ../../include/lua/converter.h.generated.h
[104/647] Generating auto/match.c.generated.h, ../../include/match.h.generated.h
[105/647] Generating auto/marktree.c.generated.h, ../../include/marktree.h.generated.h
[106/647] Generating auto/map_glyph_cache.c.generated.h, ../../include/map_glyph_cache.h.generated.h
[107/647] Generating auto/lua/executor.c.generated.h, ../../include/lua/executor.h.generated.h
[108/647] Generating auto/memfile.c.generated.h, ../../include/memfile.h.generated.h
[109/647] Generating auto/main.c.generated.h, ../../include/main.h.generated.h
[110/647] Generating auto/mark.c.generated.h, ../../include/mark.h.generated.h
[111/647] Generating auto/msgpack_rpc/packer.c.generated.h, ../../include/msgpack_rpc/packer.h.generated.h
[112/647] Generating auto/mbyte.c.generated.h, ../../include/mbyte.h.generated.h
[113/647] Generating auto/msgpack_rpc/unpacker.c.generated.h, ../../include/msgpack_rpc/unpacker.h.generated.h
[114/647] Generating auto/os/dl.c.generated.h, ../../include/os/dl.h.generated.h
[115/647] Generating auto/menu.c.generated.h, ../../include/menu.h.generated.h
[116/647] Generating auto/mapping.c.generated.h, ../../include/mapping.h.generated.h
[117/647] Generating auto/move.c.generated.h, ../../include/move.h.generated.h
[118/647] Generating auto/os/mem.c.generated.h, ../../include/os/mem.h.generated.h
[119/647] Generating auto/mouse.c.generated.h, ../../include/mouse.h.generated.h
[120/647] Generating auto/memline.c.generated.h, ../../include/memline.h.generated.h
[121/647] Generating auto/message.c.generated.h, ../../include/message.h.generated.h
[122/647] Generating auto/memory.c.generated.h, ../../include/memory.h.generated.h
[123/647] Generating auto/msgpack_rpc/server.c.generated.h, ../../include/msgpack_rpc/server.h.generated.h
[124/647] Generating auto/msgpack_rpc/channel.c.generated.h, ../../include/msgpack_rpc/channel.h.generated.h
[125/647] Generating auto/os/input.c.generated.h, ../../include/os/input.h.generated.h
[126/647] Generating auto/optionstr.c.generated.h, ../../include/optionstr.h.generated.h
[127/647] Generating auto/os/fileio.c.generated.h, ../../include/os/fileio.h.generated.h
[128/647] Generating auto/os/process.c.generated.h, ../../include/os/process.h.generated.h
[129/647] Generating auto/normal.c.generated.h, ../../include/normal.h.generated.h
[130/647] Generating auto/os/env.c.generated.h, ../../include/os/env.h.generated.h
[131/647] Generating auto/os/fs.c.generated.h, ../../include/os/fs.h.generated.h
[132/647] Generating auto/os/lang.c.generated.h, ../../include/os/lang.h.generated.h
[133/647] Generating auto/os/pty_process_unix.c.generated.h, ../../include/os/pty_process_unix.h.generated.h
[134/647] Generating auto/ops.c.generated.h, ../../include/ops.h.generated.h
[135/647] Generating auto/sha256.c.generated.h, ../../include/sha256.h.generated.h
[136/647] Generating auto/os/stdpaths.c.generated.h, ../../include/os/stdpaths.h.generated.h
[137/647] Generating auto/option.c.generated.h, ../../include/option.h.generated.h
[138/647] Generating auto/os/time.c.generated.h, ../../include/os/time.h.generated.h
[139/647] Generating auto/os/users.c.generated.h, ../../include/os/users.h.generated.h
[140/647] Generating auto/os/signal.c.generated.h, ../../include/os/signal.h.generated.h
[141/647] Generating auto/plines.c.generated.h, ../../include/plines.h.generated.h
[142/647] Generating auto/popupmenu.c.generated.h, ../../include/popupmenu.h.generated.h
[143/647] Generating auto/path.c.generated.h, ../../include/path.h.generated.h
[144/647] Generating auto/profile.c.generated.h, ../../include/profile.h.generated.h
[145/647] Generating auto/ugrid.c.generated.h, ../../include/ugrid.h.generated.h
[146/647] Generating auto/runtime.c.generated.h, ../../include/runtime.h.generated.h
[147/647] Generating auto/os/shell.c.generated.h, ../../include/os/shell.h.generated.h
[148/647] Generating auto/statusline.c.generated.h, ../../include/statusline.h.generated.h
[149/647] Generating auto/spell.c.generated.h, ../../include/spell.h.generated.h
[150/647] Generating auto/sign.c.generated.h, ../../include/sign.h.generated.h
[151/647] Generating auto/search.c.generated.h, ../../include/search.h.generated.h
[152/647] Generating auto/spellsuggest.c.generated.h, ../../include/spellsuggest.h.generated.h
[153/647] Generating auto/quickfix.c.generated.h, ../../include/quickfix.h.generated.h
[154/647] Generating auto/state.c.generated.h, ../../include/state.h.generated.h
[155/647] Generating auto/shada.c.generated.h, ../../include/shada.h.generated.h
[156/647] Generating auto/testing.c.generated.h, ../../include/testing.h.generated.h
[157/647] Generating auto/syntax.c.generated.h, ../../include/syntax.h.generated.h
[158/647] Generating auto/textobject.c.generated.h, ../../include/textobject.h.generated.h
[159/647] Generating auto/regexp.c.generated.h, ../../include/regexp.h.generated.h
[160/647] Generating auto/tui/terminfo.c.generated.h, ../../include/tui/terminfo.h.generated.h
[161/647] Generating auto/strings.c.generated.h, ../../include/strings.h.generated.h
[162/647] Generating auto/tag.c.generated.h, ../../include/tag.h.generated.h
[163/647] Generating auto/spellfile.c.generated.h, ../../include/spellfile.h.generated.h
[164/647] Generating auto/terminal.c.generated.h, ../../include/terminal.h.generated.h
[165/647] Generating auto/ui.c.generated.h, ../../include/ui.h.generated.h
[166/647] Generating auto/viml/parser/parser.c.generated.h, ../../include/viml/parser/parser.h.generated.h
[167/647] Generating ../../include/api/autocmd.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/api/autocmd.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[168/647] Generating auto/tui/input.c.generated.h, ../../include/tui/input.h.generated.h
[169/647] Generating ../../include/api/command.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/api/command.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[170/647] Generating ../../include/api/buffer.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/api/buffer.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[171/647] Generating ../../include/api/deprecated.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/api/deprecated.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[172/647] Generating auto/tui/tui.c.generated.h, ../../include/tui/tui.h.generated.h
[173/647] Generating auto/ui_client.c.generated.h, ../../include/ui_client.h.generated.h
[174/647] Generating ../../include/api/private/converter.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/api/private/converter.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[175/647] Generating ../../include/api/keysets_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/api/keysets_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[176/647] Generating auto/textformat.c.generated.h, ../../include/textformat.h.generated.h
[177/647] Generating ../../include/api/private/dispatch.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/api/private/dispatch.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[178/647] Generating ../../include/arabic.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/arabic.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[179/647] Generating ../../include/api/tabpage.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/api/tabpage.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[180/647] Generating ../../include/arglist_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/arglist_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[181/647] Generating auto/ui_compositor.c.generated.h, ../../include/ui_compositor.h.generated.h
[182/647] Generating auto/winfloat.c.generated.h, ../../include/winfloat.h.generated.h
[183/647] Generating ../../include/api/private/defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/api/private/defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[184/647] Generating ../../include/api/options.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/api/options.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[185/647] Generating ../../include/api/ui.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/api/ui.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[186/647] Generating ../../include/arglist.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/arglist.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[187/647] Generating ../../include/assert_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/assert_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[188/647] Generating auto/undo.c.generated.h, ../../include/undo.h.generated.h
[189/647] Generating auto/viml/parser/expressions.c.generated.h, ../../include/viml/parser/expressions.h.generated.h
[190/647] Generating ../../include/api/private/helpers.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/api/private/helpers.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[191/647] Generating ../../include/api/vim.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/api/vim.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[192/647] Generating ../../include/api/vimscript.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/api/vimscript.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[193/647] Generating auto/usercmd.c.generated.h, ../../include/usercmd.h.generated.h
[194/647] Generating ../../include/api/extmark.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/api/extmark.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[195/647] Generating ../../include/base64.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/base64.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[196/647] Generating ../../include/change.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/change.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[197/647] Generating ../../include/bufwrite.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/bufwrite.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[198/647] Generating ../../include/api/private/validate.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/api/private/validate.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[199/647] Generating ../../include/api/win_config.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/api/win_config.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[200/647] Generating ../../include/api/window.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/api/window.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[201/647] Generating ../../include/api/ui_events.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/api/ui_events.in.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[202/647] Generating ../../include/ascii_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/ascii_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[203/647] Generating ../../include/cursor.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/cursor.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[204/647] Generating ../../include/cmdexpand_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/cmdexpand_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[205/647] Generating ../../include/digraph.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/digraph.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[206/647] Generating ../../include/cmdhist.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/cmdhist.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[207/647] Generating ../../include/debugger.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/debugger.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[208/647] Generating ../../include/errors.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/errors.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[209/647] Generating ../../include/channel_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/channel_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[210/647] Generating ../../include/cmdexpand.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/cmdexpand.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[211/647] Generating ../../include/context.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/context.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[212/647] Generating ../../include/cursor_shape.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/cursor_shape.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[213/647] Generating ../../include/decoration_provider.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/decoration_provider.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[214/647] Generating ../../include/buffer_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/buffer_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[215/647] Generating ../../include/decoration_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/decoration_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[216/647] Generating ../../include/buffer_updates.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/buffer_updates.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[217/647] Generating ../../include/charset.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/charset.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[218/647] Generating ../../include/autocmd.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/autocmd.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[219/647] Generating ../../include/autocmd_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/autocmd_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[220/647] Generating ../../include/drawline.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/drawline.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[221/647] Generating ../../include/eval/funcs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/eval/funcs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[222/647] Generating ../../include/eval/gc.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/eval/gc.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[223/647] Generating ../../include/buffer.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/buffer.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[224/647] Generating ../../include/eval/executor.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/eval/executor.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[225/647] Generating ../../include/eval/decode.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/eval/decode.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[226/647] Generating auto/window.c.generated.h, ../../include/window.h.generated.h
[227/647] Generating ../../include/edit.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/edit.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[228/647] Generating ../../include/eval/typval_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/eval/typval_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[229/647] Generating ../../include/eval/userfunc.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/eval/userfunc.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[230/647] Generating ../../include/drawscreen.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/drawscreen.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[231/647] Generating ../../include/eval_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/eval_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[232/647] Generating ../../include/channel.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/channel.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[233/647] Generating ../../include/decoration.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/decoration.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[234/647] Generating ../../include/eval/encode.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/eval/encode.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[235/647] Generating ../../include/ex_cmds2.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/ex_cmds2.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[236/647] Generating ../../include/diff.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/diff.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[237/647] Generating ../../include/ex_cmds.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/ex_cmds.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[238/647] Generating ../../include/ex_cmds_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/ex_cmds_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[239/647] Generating ../../include/ex_eval_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/ex_eval_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[240/647] Generating ../../include/eval/vars.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/eval/vars.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[241/647] Generating ../../include/ex_eval.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/ex_eval.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[242/647] Generating ../../include/eval/buffer.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/eval/buffer.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[243/647] Generating ../../include/eval/typval.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/eval/typval.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[244/647] Generating ../../include/eval/typval_encode.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/eval/typval_encode.h:5:9: warning: #pragma once in main file
    5 | #pragma once
      |         ^~~~
[245/647] Generating ../../include/event/libuv_process.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/event/libuv_process.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[246/647] Generating ../../include/event/process.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/event/process.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[247/647] Generating ../../include/eval/window.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/eval/window.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[248/647] Generating ../../include/ex_session.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/ex_session.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[249/647] Generating ../../include/file_search.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/file_search.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[250/647] Generating ../../include/event/loop.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/event/loop.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[251/647] Generating ../../include/event/socket.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/event/socket.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[252/647] Generating ../../include/event/multiqueue.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/event/multiqueue.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[253/647] Generating ../../include/eval.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/eval.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[254/647] Generating ../../include/event/stream.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/event/stream.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[255/647] Generating ../../include/func_attr.h.inline.generated.h
[256/647] Generating ../../include/event/defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/event/defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[257/647] Generating ../../include/event/signal.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/event/signal.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[258/647] Generating ../../include/event/rstream.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/event/rstream.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[259/647] Generating ../../include/fold_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/fold_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[260/647] Generating ../../include/garray.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/garray.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[261/647] Generating ../../include/garray_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/garray_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[262/647] Generating ../../include/hashtab.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/hashtab.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[263/647] Generating ../../include/event/time.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/event/time.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[264/647] Generating ../../include/ex_docmd.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/ex_docmd.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[265/647] Generating ../../include/gettext_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/gettext_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[266/647] Generating ../../include/event/wstream.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/event/wstream.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[267/647] Generating ../../include/ex_getln.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/ex_getln.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[268/647] Generating ../../include/fold.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/fold.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[269/647] Generating ../../include/grid.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/grid.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[270/647] Generating ../../include/hashtab_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/hashtab_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[271/647] Generating ../../include/help.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/help.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[272/647] Generating ../../include/ex_getln_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/ex_getln_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[273/647] Generating ../../include/fileio.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/fileio.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[274/647] Generating ../../include/grid_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/grid_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[275/647] Generating ../../include/iconv_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/iconv_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[276/647] Generating ../../include/indent.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/indent.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[277/647] Generating ../../include/extmark.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/extmark.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[278/647] Generating ../../include/extmark_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/extmark_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[279/647] Generating ../../include/getchar.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/getchar.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[280/647] Generating ../../include/getchar_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/getchar_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[281/647] Generating ../../include/indent_c.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/indent_c.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[282/647] Generating ../../include/lib/queue_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/lib/queue_defs.h:20:9: warning: #pragma once in main file
   20 | #pragma once
      |         ^~~~
[283/647] Generating ../../include/linematch.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/linematch.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[284/647] Generating ../../include/log.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/log.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[285/647] Generating ../../include/lua/base64.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/lua/base64.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[286/647] Generating ../../include/highlight_group.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/highlight_group.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[287/647] Generating ../../include/lua/spell.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/lua/spell.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[288/647] Generating ../../include/lua/stdlib.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/lua/stdlib.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[289/647] Generating ../../include/highlight_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/highlight_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[290/647] Generating ../../include/lua/secure.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/lua/secure.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[291/647] Generating ../../include/lua/treesitter.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/lua/treesitter.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[292/647] Generating ../../include/insexpand.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/insexpand.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[293/647] Generating ../../include/lua/xdiff.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/lua/xdiff.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[294/647] Generating ../../include/macros_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/macros_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[295/647] Generating ../../include/mapping_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/mapping_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[296/647] Generating ../../include/highlight.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/highlight.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[297/647] Generating ../../include/input.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/input.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[298/647] Generating ../../include/lua/converter.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/lua/converter.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[299/647] Generating ../../include/keycodes.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/keycodes.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[300/647] Generating ../../include/mark_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/mark_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[301/647] Generating ../../include/math.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/math.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[302/647] Generating ../../include/menu_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/menu_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[303/647] Generating ../../include/mbyte_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/mbyte_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[304/647] Generating ../../include/globals.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/globals.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[305/647] Generating ../../include/memory_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/memory_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[306/647] Generating ../../include/memory.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/memory.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[307/647] Generating ../../include/mapping.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/mapping.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[308/647] Generating ../../include/map_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/map_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[309/647] Generating ../../include/mark.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/mark.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[310/647] Generating ../../include/mouse.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/mouse.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[311/647] Generating ../../include/move.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/move.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[312/647] Generating ../../include/memfile_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/memfile_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[313/647] Generating ../../include/normal.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/normal.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[314/647] Generating ../../include/marktree_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/marktree_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[315/647] Generating ../../include/main.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/main.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[316/647] Generating ../../include/menu.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/menu.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[317/647] Generating ../../include/msgpack_rpc/server.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/msgpack_rpc/server.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[318/647] Generating ../../include/memfile.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/memfile.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[319/647] Generating ../../include/msgpack_rpc/packer_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/msgpack_rpc/packer_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[320/647] Generating ../../include/lua/executor.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/lua/executor.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[321/647] Generating ../../include/message_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/message_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[322/647] Generating ../../include/normal_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/normal_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[323/647] Generating ../../include/mbyte.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/mbyte.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[324/647] Generating ../../include/message.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/message.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[325/647] Generating ../../include/marktree.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/marktree.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[326/647] Generating ../../include/memline.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/memline.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[327/647] Generating ../../include/os/dl.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/os/dl.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[328/647] Generating ../../include/os/fileio_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/os/fileio_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[329/647] Generating ../../include/memline_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/memline_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[330/647] Generating ../../include/msgpack_rpc/packer.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/msgpack_rpc/packer.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[331/647] Generating ../../include/os/fileio.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/os/fileio.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[332/647] Generating ../../include/os/os_win_console.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/os/os_win_console.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[333/647] Generating ../../include/os/lang.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/os/lang.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[334/647] Generating ../../include/os/process.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/os/process.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[335/647] Generating ../../include/match.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/match.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[336/647] Generating ../../include/msgpack_rpc/channel.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/msgpack_rpc/channel.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[337/647] Generating ../../include/os/shell.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/os/shell.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[338/647] Generating ../../include/option_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/option_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[339/647] Generating ../../include/option_vars.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/option_vars.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[340/647] Generating ../../include/ops.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/ops.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[341/647] Generating ../../include/os/signal.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/os/signal.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[342/647] Generating ../../include/os/fs_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/os/fs_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[343/647] Generating ../../include/os/time_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/os/time_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[344/647] Generating ../../include/os/time.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/os/time.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[345/647] Generating ../../include/msgpack_rpc/channel_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/msgpack_rpc/channel_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[346/647] Generating ../../include/os/stdpaths_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/os/stdpaths_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[347/647] Generating ../../include/optionstr.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/optionstr.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[348/647] Generating ../../include/os/input.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/os/input.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[349/647] Generating ../../include/popupmenu.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/popupmenu.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[350/647] Generating ../../include/pos_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/pos_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[351/647] Generating ../../include/msgpack_rpc/unpacker.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/msgpack_rpc/unpacker.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[352/647] Generating ../../include/os/os.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/os/os.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[353/647] Generating ../../include/os/os_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/os/os_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[354/647] Generating ../../include/path.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/path.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[355/647] Generating ../../include/os/pty_process_unix.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/os/pty_process_unix.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[356/647] Generating ../../include/regexp.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/regexp.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[357/647] Generating ../../include/sha256.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/sha256.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[358/647] Generating ../../include/option.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/option.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[359/647] Generating ../../include/regexp_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/regexp_defs.h:10:9: warning: #pragma once in main file
   10 | #pragma once
      |         ^~~~
[360/647] Generating ../../include/search.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/search.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[361/647] Generating ../../include/os/pty_process.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/os/pty_process.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[362/647] Generating ../../include/os/pty_process_win.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/os/pty_process_win.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[363/647] Generating ../../include/os/fs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/os/fs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[364/647] Generating ../../include/os/unix_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/os/unix_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[365/647] Generating ../../include/spellsuggest.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/spellsuggest.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[366/647] Generating ../../include/os/pty_conpty_win.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/os/pty_conpty_win.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[367/647] Generating ../../include/state_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/state_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[368/647] Generating ../../include/state.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/state.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[369/647] Generating ../../include/plines.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/plines.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[370/647] Generating ../../include/textformat.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/textformat.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[371/647] Generating ../../include/sign.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/sign.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[372/647] Generating ../../include/testing.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/testing.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[373/647] Generating ../../include/sign_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/sign_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[374/647] Generating ../../include/textobject.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/textobject.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[375/647] Generating ../../include/tui/input_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/tui/input_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[376/647] Generating ../../include/profile.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/profile.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[377/647] Generating ../../include/quickfix.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/quickfix.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[378/647] Generating ../../include/runtime.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/runtime.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[379/647] Generating ../../include/strings.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/strings.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[380/647] Generating ../../include/runtime_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/runtime_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[381/647] Generating ../../include/terminal.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/terminal.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[382/647] Generating ../../include/tui/terminfo_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/tui/terminfo_defs.h:5:9: warning: #pragma once in main file
    5 | #pragma once
      |         ^~~~
[383/647] Generating ../../include/shada.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/shada.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[384/647] Generating ../../include/tui/tui_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/tui/tui_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[385/647] Generating ../../include/types_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/types_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[386/647] Generating ../../include/statusline_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/statusline_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[387/647] Generating ../../include/vim_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/vim_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[388/647] Generating ../../include/statusline.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/statusline.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[389/647] Generating ../../include/spellfile.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/spellfile.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[390/647] Generating ../../include/ugrid.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/ugrid.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[391/647] Generating ../../include/syntax_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/syntax_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[392/647] Generating ../../include/syntax.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/syntax.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[393/647] Generating ../../include/ex_cmds_enum.generated.h, auto/ex_cmds_defs.generated.h
[394/647] Generating ../../include/tui/terminfo.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/tui/terminfo.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[395/647] Generating ../../include/auevents_enum.generated.h, auto/auevents_name_map.generated.h
[396/647] Generating ../../include/tui/tui.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/tui/tui.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[397/647] Generating ../../include/tui/input.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/tui/input.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[398/647] Generating ../../include/ui_client.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/ui_client.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[399/647] Generating ../../include/spell.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/spell.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[400/647] Generating auto/options_enum.generated.h, auto/options_map.generated.h
[401/647] Generating ../../include/undo_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/undo_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[402/647] Generating ../../cmake.config/auto/versiondef.h
[403/647] Generating ../../include/spell_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/spell_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[404/647] Generating ../../include/usercmd.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/usercmd.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[405/647] Generating ../../include/undo.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/undo.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[406/647] Generating auto/ui_events_call.generated.h, auto/ui_events_remote.generated.h, ../../ui_metadata.mpack, auto/ui_events_client.generated.h
[407/647] Generating ../../include/ui_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/ui_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[408/647] Generating ../../include/tag.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/tag.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[409/647] Generating auto/options.generated.h
[410/647] Generating ../../include/version.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/version.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[411/647] Generating ../../include/ui.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/ui.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[412/647] Generating ../../include/viml/parser/parser.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/viml/parser/parser.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[413/647] Generating ../../include/viml/parser/expressions.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/viml/parser/expressions.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[414/647] Generating auto/ui_events_client.c.generated.h, ../../include/ui_events_client.h.generated.h
[415/647] Generating auto/ui_events_call.c.generated.h, ../../include/ui_events_call.h.generated.h
[416/647] Generating auto/ui_events_remote.c.generated.h, ../../include/ui_events_remote.h.generated.h
[417/647] Generating ../../include/ui_compositor.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/ui_compositor.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[418/647] Generating ../../include/viml/parser/parser_defs.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/viml/parser/parser_defs.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[419/647] Generating auto/api/private/dispatch_wrappers.generated.h, auto/api/private/api_metadata.generated.h, ../../funcs_metadata.mpack, auto/lua_api_c_bindings.generated.h, auto/keysets_defs.generated.h
[420/647] Generating auto/lua/vim_module.generated.h
[421/647] Generating ../../include/winfloat.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/winfloat.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[422/647] Generating auto/funcs.generated.h, ../../funcs_data.mpack
[423/647] Generating ../../include/window.h.inline.generated.h
/home/mmalcomson/repos/neovim/src/nvim/window.h:1:9: warning: #pragma once in main file
    1 | #pragma once
      |         ^~~~
[424/647] Generating auto/version.c.generated.h, ../../include/version.h.generated.h
[425/647] Generating auto/api/private/dispatch_wrappers.c.generated.h, ../../include/api/private/dispatch_wrappers.h.generated.h
[426/647] Generating auto/unicode_tables.generated.h
[427/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/arabic.c.o
[428/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/base64.c.o
[429/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/__/__/test/unit/fixtures/multiqueue.c.o
[430/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/api/private/validate.c.o
[431/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/api/tabpage.c.o
[432/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/api/command.c.o
[433/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/api/buffer.c.o
[434/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/api/extmark.c.o
[435/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/api/deprecated.c.o
[436/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/api/private/converter.c.o
[437/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/api/vimscript.c.o
[438/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/api/ui.c.o
[439/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/api/window.c.o
[440/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/api/options.c.o
[441/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/buffer_updates.c.o
[442/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/api/autocmd.c.o
[443/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/api/private/helpers.c.o
[444/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/arglist.c.o
[445/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/api/win_config.c.o
[446/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/bufwrite.c.o
[447/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/autocmd.c.o
[448/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/cmdhist.c.o
[449/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/api/vim.c.o
[450/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/buffer.c.o
[451/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/charset.c.o
[452/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/cursor.c.o
[453/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/api/private/dispatch.c.o
[454/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/channel.c.o
[455/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/decoration_provider.c.o
[456/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/cursor_shape.c.o
[457/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/context.c.o
[458/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/change.c.o
[459/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/eval/gc.c.o
[460/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/decoration.c.o
[461/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/digraph.c.o
[462/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/debugger.c.o
[463/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/eval/buffer.c.o
[464/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/cmdexpand.c.o
[465/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/eval/decode.c.o
[466/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/drawline.c.o
[467/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/event/loop.c.o
[468/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/drawscreen.c.o
[469/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/event/multiqueue.c.o
[470/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/event/libuv_process.c.o
[471/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/eval/executor.c.o
[472/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/diff.c.o
[473/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/event/signal.c.o
[474/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/event/rstream.c.o
[475/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/edit.c.o
[476/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/event/time.c.o
[477/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/event/socket.c.o
[478/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/event/stream.c.o
[479/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/eval/window.c.o
[480/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/event/process.c.o
[481/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/event/wstream.c.o
[482/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/eval/vars.c.o
[483/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/eval/userfunc.c.o
[484/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/garray.c.o
[485/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/eval/encode.c.o
[486/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/ex_cmds2.c.o
[487/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/eval/typval.c.o
[488/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/hashtab.c.o
[489/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/extmark.c.o
[490/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/ex_eval.c.o
[491/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/help.c.o
[492/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/file_search.c.o
[493/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/fold.c.o
[494/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/ex_session.c.o
[495/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/highlight.c.o
[496/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/eval.c.o
[497/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/lua/base64.c.o
[498/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/grid.c.o
[499/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/fileio.c.o
[500/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/input.c.o
[501/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/indent.c.o
[502/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/getchar.c.o
[503/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/linematch.c.o
[504/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/ex_cmds.c.o
[505/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/eval/funcs.c.o
[506/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/log.c.o
[507/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/ex_getln.c.o
[508/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/keycodes.c.o
[509/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/indent_c.c.o
[510/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/highlight_group.c.o
[511/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/lua/xdiff.c.o
[512/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/lua/secure.c.o
[513/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/math.c.o
[514/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/lua/stdlib.c.o
[515/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/lua/converter.c.o
[516/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/map_glyph_cache.c.o
[517/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/lua/spell.c.o
[518/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/map.c.o
[519/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/lua/treesitter.c.o
[520/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/ex_docmd.c.o
[521/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/insexpand.c.o
[522/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/match.c.o
[523/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/memfile.c.o
[524/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/mark.c.o
[525/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/lua/api_wrappers.c.o
[526/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/marktree.c.o
[527/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/mapping.c.o
[528/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/mbyte.c.o
[529/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/memory.c.o
[530/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/main.c.o
[531/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/msgpack_rpc/packer.c.o
[532/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/msgpack_rpc/channel.c.o
[533/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/os/dl.c.o
[534/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/mouse.c.o
[535/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/move.c.o
[536/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/menu.c.o
[537/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/msgpack_rpc/unpacker.c.o
[538/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/msgpack_rpc/server.c.o
[539/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/lua/executor.c.o
[540/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/memline.c.o
[541/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/message.c.o
[542/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/os/process.c.o
[543/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/os/mem.c.o
[544/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/os/env.c.o
[545/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/os/fileio.c.o
[546/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/os/fs.c.o
[547/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/os/time.c.o
[548/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/os/input.c.o
[549/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/optionstr.c.o
[550/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/os/lang.c.o
[551/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/os/stdpaths.c.o
[552/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/os/pty_process_unix.c.o
[553/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/os/users.c.o
[554/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/os/signal.c.o
[555/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/normal.c.o
[556/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/os/shell.c.o
[557/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/ops.c.o
[558/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/plines.c.o
[559/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/path.c.o
[560/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/sha256.c.o
[561/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/option.c.o
[562/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/popupmenu.c.o
[563/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/profile.c.o
[564/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/state.c.o
[565/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/ugrid.c.o
[566/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/spell.c.o
[567/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/runtime.c.o
[568/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/testing.c.o
[569/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/spellfile.c.o
[570/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/sign.c.o
[571/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/spellsuggest.c.o
[572/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/statusline.c.o
[573/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/strings.c.o
[574/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/textobject.c.o
[575/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/shada.c.o
[576/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/search.c.o
[577/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/syntax.c.o
[578/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/tui/input.c.o
[579/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/textformat.c.o
[580/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/tui/terminfo.c.o
[581/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/__/cjson/fpconv.c.o
[582/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/quickfix.c.o
[583/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/__/mpack/conv.c.o
[584/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/__/mpack/rpc.c.o
[585/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/__/mpack/object.c.o
[586/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/__/cjson/strbuf.c.o
[587/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/terminal.c.o
[588/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/tag.c.o
[589/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/__/mpack/mpack_core.c.o
[590/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/ui_client.c.o
[591/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/viml/parser/parser.c.o
[592/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/__/mpack/lmpack.c.o
[593/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/__/termkey/driver-csi.c.o
[594/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/ui_compositor.c.o
[595/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/__/xdiff/xemit.c.o
[596/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/__/termkey/driver-ti.c.o
[597/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/version.c.o
[598/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/__/termkey/termkey.c.o
[599/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/__/xdiff/xdiffi.c.o
[600/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/__/xdiff/xpatience.c.o
[601/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/__/xdiff/xhistogram.c.o
[602/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/tui/tui.c.o
[603/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/ui.c.o
[604/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/__/xdiff/xutils.c.o
[605/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/__/xdiff/xprepare.c.o
[606/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/winfloat.c.o
[607/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/undo.c.o
[608/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/__/cjson/lua_cjson.c.o
[609/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/regexp.c.o
[610/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/usercmd.c.o
[611/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/viml/parser/expressions.c.o
[612/647] Building C object src/nvim/CMakeFiles/nvim_bin.dir/window.c.o
[613/647] Linking C executable bin/nvim
[614/647] Generating syntax/vim/generated.vim
[615/647] Generating pack/dist/opt/matchit/doc/tags
[616/647] Generating doc/tags
[617/647] Generating nvim.pot
48 substitutions on 48 lines"optwin.js" "optwin.js" [New] 1299L, 57582B written385 substitutions on 385 lines"nvim.pot" "nvim.pot" 9337L, 180509B written[618/647] Generating en_GB.mo
[619/647] Generating cs.cp1250.mo
[620/647] Generating af.mo
[621/647] Generating nl.mo
[622/647] Generating cs.mo
[623/647] Generating eo.mo
[624/647] Generating es.mo
[625/647] Generating da.mo
[626/647] Generating fi.mo
[627/647] Generating ja.euc-jp.mo
[628/647] Generating ru.mo
[629/647] Generating nb.mo
[630/647] Generating de.mo
[631/647] Generating ga.mo
[632/647] Generating ko.UTF-8.mo
[633/647] Generating no.mo
[634/647] Generating ja.mo
[635/647] Generating fr.mo
[636/647] Generating pl.UTF-8.mo
[637/647] Generating ca.mo
[638/647] Generating it.mo
[639/647] Generating pt_BR.mo
[640/647] Generating sv.mo
[641/647] Generating sk.cp1250.mo
[642/647] Generating tr.mo
[643/647] Generating sk.mo
[644/647] Generating zh_TW.UTF-8.mo
[645/647] Generating uk.mo
[646/647] Generating vi.mo
[647/647] Generating zh_CN.UTF-8.mo

mkdir -p build
touch build/.ran-deps-cmake
ninja -C .deps
ninja: Entering directory `.deps'
ninja: no work to do.
ninja -C build
ninja: Entering directory `build'
[0/2] Re-checking globbed directories...
[1/137] Running utility command for nvim_runtime_deps
[2/137] cd /home/mmalcomson/repos/neovim/build/src/nvim && /usr/bin/cmake -D NVIM_VERSION_MAJOR=0 -D NVIM_VERSION_MINOR=11 -D NVIM_VERSION_PATCH=0 -D NVIM_VERSION_PRERELEASE=-dev -D OUTPUT=/home/mmalcomson/repos/neovim/build/cmake.config/auto/versiondef_git.h -D NVIM_SOURCE_DIR=/home/mmalcomson/repos/neovim -P /home/mmalcomson/repos/neovim/cmake/GenerateVersion.cmake
ninja -C build install
ninja: Entering directory `build'
[0/2] Re-checking globbed directories...
[1/138] Running utility command for nvim_runtime_deps
[2/138] cd /home/mmalcomson/repos/neovim/build/src/nvim && /usr/bin/cmake -D NVIM_VERSION_MAJOR=0 -D NVIM_VERSION_MINOR=11 -D NVIM_VERSION_PATCH=0 -D NVIM_VERSION_PRERELEASE=-dev -D OUTPUT=/home/mmalcomson/repos/neovim/build/cmake.config/auto/versiondef_git.h -D NVIM_SOURCE_DIR=/home/mmalcomson/repos/neovim -P /home/mmalcomson/repos/neovim/cmake/GenerateVersion.cmake
[2/3] Install the project...
-- Install configuration: "RelWithDebInfo"
repos [14:58:37] $ 
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
