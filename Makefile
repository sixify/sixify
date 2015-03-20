SHELL=/bin/bash


all:
		@echo "Maybe you want to do: make update ?"

init:
		git submodule update --init --recursive && git submodule foreach --recursive git checkout master

update:
		git pull && git submodule foreach --recursive git pull
