#include .envrc

home:
	guix home reconfigure home.scm

system:
	sudo guix system reconfigure system.scm

info:
	@echo "uname" = $(shell uname -n)
	guix describe
	guix home describe

update:
	guix pull

init:
	ln -sf $(shell pwd)/config/guix/cahnnels.scm ~/.config/guix/channels.scm

wsl:
	guix system image --image-type=wsl2 ./config/system/wsl.scm