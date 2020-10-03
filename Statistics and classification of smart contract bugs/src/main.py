#!/usr/bin/python
#-*- coding: utf-8 -*-

from layoutConfuse import layoutConfuse
from dataflowObfuscation import dataflowObfuscation
import os
import sys


def main():
	if len(sys.argv) != 3:
		print("wrong parameters.")
	else:	
		dfo = dataflowObfuscation(sys.argv[1], sys.argv[2])
		dfo.run()
		lc = layoutConfuse("temp.sol", "temp.sol_json.ast")
		lc.run()


colors = True # Output should be colored
machine = sys.platform # Detecting the os of current system
if machine.lower().startswith(('os', 'win', 'darwin', 'ios')):
    colors = False # Colors shouldn't be displayed in mac & windows
if not colors:
	end = green = bad = info = ''
	start = ' ['
	stop = ']'
else:
	end = '\033[1;m'
	green = '\033[1;32m'
	white = "\033[1;37m"
	blue = "\033[1;34m"
	yellow = "\033[1;33m"
	bad = '\033[1;31m[-]\033[1;m'
	info = '\033[1;33m[!]\033[1;m'
	start = ' \033[1;31m[\033[0m'
	stop = '\033[1;31m]\033[0m'
	backGreenFrontWhite = "\033[1;37m\033[42m"
print ('''%s
	BiAn v0.9
	%s''' % (blue, end))
main()
