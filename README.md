Extremely barebones disassembly of Acorn DFS 2.45.

Main goal of this mini project: get some confidence about how the ROM
is laid out, as this has some relevance to my
[Master MOS disassembly](https://github.com/tom-seddon/acorn_mos_disassembly).

The results:

| Region | Purpose |
| --- | --- |
| $8000-$aeff | DFS 2.45 |
| $af00-$b7ff | MOS 3.50 |
| $b800-$bfff | ADFS 2.03 disk code |

Significant debt due to Greg Cook's disassembly of DFS 2.24:
http://regregex.bbcmicro.net/dfs224.asm.txt - the two ROMs are very
similar and this saved a good bit of time when it came to identifying
the tables.

(Unfortunately, they're not similar enough to build both from a single
readable source file.)

# build

Prerequisites:

- Python 3.x
- [`64tass`](http://tass64.sourceforge.net/) (I use r3120)
- GNU Make

## git clone

This repo has submodules. Clone it with `--recursive`:

    git clone --recursive https://github.com/tom-seddon/acorn_dfs_2.45_disassembly
	
Alternatively, if you already cloned it non-recursively, you can do
the following from inside the working copy:

    git submodule init
	git submodule update

(The code won't build without fiddling around if you download one of
the archive files from GitHub - a GitHub limitation. It's easiest to
clone it as above.)

## build steps

Run GNU Make from the root of the working copy.

The build process is supposed to be silent when there are no errors
and when the output matches the original ROMs. Some versions of make
might print a load of stuff about entering and leaving the directory.

## build output

The build output is two ROMs:

- `build/dfs245.rom` - DFS 2.45 ROM, identical to MOS 3.50 ROM bank 9
- `build/dfs245_truncated.rom` - just the DFS 2.45 code, $8000-$aeff,
  to ensure it assembles standalone

The corresponding original ROMs can be found in the `orig` folder.

