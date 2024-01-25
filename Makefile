ifeq ($(OS),Windows_NT)
PYTHON:=py -3
BEEBASM:=beebasm
TASS:=64tass
else
PYTHON:=/usr/bin/python3
BEEBASM:=beebasm
TASS:=64tass
endif

ifeq ($(VERBOSE),1)
_V:=
_TASSQ:=
else
_V:=@
_TASSQ:=-q
endif

SHELLCMD:=$(PYTHON) "submodules/shellcmd.py/shellcmd.py"

##########################################################################
##########################################################################

BUILD:=build

##########################################################################
##########################################################################

.PHONY:all
all:
	$(_V)$(SHELLCMD) mkdir "$(BUILD)"
	$(_V)$(TASS) -Dtruncated=false --m65c02 --nostart -Wall $(_TASSQ) --case-sensitive --line-numbers --verbose-list -o "build/dfs245.rom" -Lbuild/dfs245.lst dfs245.s65
	$(_V)$(TASS) -Dtruncated=true --m65c02 --nostart -Wall $(_TASSQ) --case-sensitive --line-numbers --verbose-list -o "build/dfs245_truncated.rom" -Lbuild/dfs245_truncated.lst dfs245.s65

	$(_V)$(PYTHON) "bin/romdiffs.py" -a "$(BUILD)" -b "orig" dfs245.rom dfs245_truncated.rom

##########################################################################
##########################################################################

.PHONY:clean
clean:
	$(_V)$(SHELLCMD) rm-tree "$(BUILD)"
