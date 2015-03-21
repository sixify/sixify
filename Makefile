SHELL=/bin/bash


all:
		@echo "Maybe you want to do: make update ?"

init:
		git submodule update --init --recursive && git submodule foreach --recursive git checkout master

update:
		git pull && git submodule foreach --recursive git pull

datajson:
		python list_data.py sixify_highfreq.json

deploy:
		rm -rf ../sixify.github.io/demo
		mkdir ../sixify.github.io/demo
		mkdir ../sixify.github.io/demo/css
		mkdir ../sixify.github.io/demo/scripts
		mkdir ../sixify.github.io/demo/data
		cp -R visualize/css/* ../sixify.github.io/demo/css/
		cp -R visualize/scripts/* ../sixify.github.io/demo/scripts/
		cp -R visualize/data/* ../sixify.github.io/demo/data/
		mkdir -p ../sixify.github.io/demo/assets/sixify
		cp -R visualize/assets/sixify/* ../sixify.github.io/demo/assets/sixify
		cp visualize/index.html ../sixify.github.io/demo/
