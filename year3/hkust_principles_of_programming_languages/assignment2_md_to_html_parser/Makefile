# DO NOT modify this file!
CC = gcc
CXX = g++
LEX = flex
YACC = bison
RM = rm

.PHONY: clean

miniMD2html: miniMD2html.c miniMD2html.tab.c global.c
	$(CC) -o $@ $^

miniMD2html.c: miniMD2html.l
	$(LEX) -o $@ $<

miniMD2html.tab.c: miniMD2html.y
	$(YACC) -t -v -d $<

clean: 
	$(RM) -rf miniMD2html.c miniMD2html miniMD2html.tab.* miniMD2html.output
