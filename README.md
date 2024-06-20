**This repo is redundant**

For general DFS stuff, please see Greg Cook's disassembly of DFS 2.24,
which has comments and labels and bug fixes and everything:
http://regregex.bbcmicro.net/dfs224.asm.txt

For DFS 2.45 specifically, my modification of Greg's disassembly may
be of interest:
https://github.com/tom-seddon/acorn_1770_dfs_disassembly - builds
2.24, 2.25, 2.26, 2.29 and 2.45 from one source file. There's no
useful commentary that isn't already in Greg's version though!

----

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

Builds on Windows, macOS and Linux.

Prerequisites (Windows/macOS/Linux):

- Python 3.x

For Windows, prebuilt binaries of the additional prerequisites are
supplied in the repo; for macOS and Linux, you'll need to install them
yourself:

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

Run `make` from the root of the working copy.

The build process is supposed to be silent when there are no errors
and when the output matches the original ROMs. Some versions of make
might print a load of stuff about entering and leaving the directory.

## build output

The build output is four ROMs:

- `build/dfs245.rom` - DFS 2.45 ROM, identical to MOS 3.50 ROM bank 9
- `build/dfs245.truncated.rom` - just the DFS 2.45 code, $8000-$aeff,
  to ensure it assembles standalone
- `build/dfs245.rev1191.rom` DFS 2.45 ROM with later copyright date,
  as discussed in this thread:
  https://stardot.org.uk/forums/viewtopic.php?t=19103 (search for
  `rev1191` in the source to see the differences)
- `build/dfs245.rev1191.truncated.rom` - just the DFS 2.45 rev 1191
  code, $8000-$aeff, to ensure it assembles standalone

The corresponding original ROMs can be found in the `orig` folder.
