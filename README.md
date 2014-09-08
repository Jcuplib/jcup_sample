Sample code for Jcup.
=====================

There are two sample code for Jcup in this archive.

- `sample_simple` is the smallest one to check function of Jcup. This is
MPMD-type application and have two binaries, each of these do send/recv data.

- `sample` is an skelton of usual climate model, consists of three
binaries, each of these also just do send/recv data.

Usage.
======
0. First of all, download/compile/install Jcup.

For sample_simple/.
------------------
1. Check and edit src/Makefile.
   - You should set JCUPDIR as an environmental variable.
   - Define FC/LD and FFLAGS suitable for your compler.
2. Compile.
   - Just `% cd src; % make`.
3. Run.
   - `cd ../run` and `% make run` executes `mpich2_go` script.
   - Check output log files.


For sample/.
------------
1. Check and edit src/Mkinclude
   - You should set TOPDIR and JCUPDIR as an environmental variable.
   - Define FC/LD and OPTIMIZEFLAG, DEBUGFLAG, DIALECTFLAG, etc. to consist FFLAGS.
   - Check AR, CP etc. Check also TRASH.
2. Compile.
   - Just `% make`.
3. Run
   - `% cd ./run` and `% make run` executes `mpich2_go` script.
   - Check outputlog files. Compare them with org/*.


