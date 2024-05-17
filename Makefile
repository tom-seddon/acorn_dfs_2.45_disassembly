ifeq ($(OS),Windows_NT)
PYTHON:=py -3
TASS:=bin\64tass
else
PYTHON:=/usr/bin/python3
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
	$(_V)$(MAKE) _dfs STEM=dfs245 EXTRA=
	$(_V)$(MAKE) _dfs STEM=dfs245.rev1191 EXTRA=-Drev1191=true
	$(_V)$(PYTHON) "bin/romdiffs.py" -a "$(BUILD)" -b "orig" dfs245.rom dfs245.truncated.rom dfs245.rev1191.rom dfs245.rev1191.truncated.rom

.PHONY:_dfs
_dfs: STEM=$(error Must specify STEM)
_dfs: _TASSOPTS:=--m65c02 --nostart -Wall --case-sensitive --line-numbers --verbose-list $(_TASSQ) $(EXTRA)
_dfs:
	$(_V)$(TASS) -Dtruncated=false $(_TASSOPTS) -o "build/$(STEM).rom" "-Lbuild/$(STEM).lst" dfs245.s65
	$(_V)$(TASS) -Dtruncated=true $(_TASSOPTS) -o "build/$(STEM).truncated.rom" -Lbuild/$(STEM).truncated.lst dfs245.s65


##########################################################################
##########################################################################

.PHONY:clean
clean:
	$(_V)$(SHELLCMD) rm-tree "$(BUILD)"
