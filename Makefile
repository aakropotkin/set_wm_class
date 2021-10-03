set_wm_class:
	gcc -Wall -g set_wm_class.c -lX11 -o set_wm_class

install: set_wm_class
