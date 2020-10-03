#!/bin/usr/python
#-*- coding: utf-8 -*-


'''
This Python program is the main Python file that performs layout confusion. 
The file provides input, output, and call-related operations for layout obfuscation.
input: sol's json_ast
'''

import os
import sys
import json
from replaceVarName import replaceVarName
from splitFunction import splitFunction
from changeFormat import changeFormat
from deleteComment import deleteComment
import time


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
    backBlueFrontWhite = "\033[1;37m\033[44m"


class layoutConfuse:
	def __init__(self, _filepath, _jsonFile):
		self.filePath = _filepath
		self.jsonPath = _jsonFile
		self.outputFileName = self.getOutputFileName(_filepath)
		self.solContent = self.getContent(_filepath)
		self.json = self.getJsonContent(_jsonFile)		
		self.middleContract = "temp.sol"
		self.middleJsonAST = "temp.sol_json.ast"
		self.configPath = "Configuration.json"
		self.getConfig()
	
	def getConfig(self):
		config = self.getJsonContent(self.configPath)
		self.featureList = config["activateFunc"]

	def getContent(self, _filepath):
		with open(_filepath, "r", encoding = "utf-8") as f:
			return f.read()
		return str()

	def getOutputFileName(self, _filepath):
		temp = _filepath.split(".")
		newFileName = temp[0] + "_layout_confuse." + temp[1]
		return newFileName

	def getJsonContent(self, _jsonFile):
		jsonStr = str()
		with open(_jsonFile, "r", encoding = "utf-8") as f:
			jsonStr = f.read()
		jsonDict = json.loads(jsonStr)
		return jsonDict

	def writeStrToFile(self, _filename, _str, _step):
		with open(_filename, "w", encoding = "utf-8") as f:
			f.write(_str)
		print(("%s" + _step + ".... done" + "%s") % (yellow, end))

	def recompileMiddleContract(self):
		compileResult = os.popen("solc --ast-json --pretty-json --overwrite " + self.middleContract + " -o .")
		#print(compileResult.read())
		print(("%s" + "\rIntermediate contract is being generated." + "%s") % (white, end), end = " ")
		time.sleep(1.5)
		print(("%s" + "\rIntermediate contract is being generated....done" + "%s") % (white, end))
		self.solContent = self.getContent(self.middleContract)
		self.json = self.getJsonContent(self.middleJsonAST)

	def isActivate(self, _name):
		for _dict in self.featureList:
			try:
				return _dict[_name]
			except:
				continue
		return True

	def run(self):
		print((("%s") + "Start layout confusion:" + ("%s")) % (backGreenFrontWhite, end))
		if self.isActivate("deleteComment"):
			try:
				self.DC = deleteComment(self.solContent)
				nowContent = self.DC.doDelete()
			except:	
				self.solContent = self.getContent(self.filePath)
				self.json = self.getJsonContent(self.jsonPath)
				print(("%s" + "Delete comments...Exception occurs" + "%s") % (bad, end))
		if self.isActivate("changeFormat"):
			try:
				self.CF = changeFormat(nowContent)
				nowContent = self.CF.doChange()
				self.writeStrToFile("temp.sol", nowContent, "Delete comments, disrupt the formatting")
				self.recompileMiddleContract()
			except:
				self.solContent = self.getContent(self.filePath)
				self.json = self.getJsonContent(self.jsonPath)
				print(("%s" + "Disrupt the formatting...Exception occurs" + "%s") % (bad, end))
		if self.isActivate("replaceVarName"):
			try:
				self.RVN = replaceVarName(self.solContent, self.json) # RVN is the class that performs "Replace Variable Name" operation
				nowContent = self.RVN.doReplace()
				self.writeStrToFile(self.outputFileName, nowContent, "Replace variable name")
			except:
				self.solContent = self.getContent(self.filePath)
				self.json = self.getJsonContent(self.jsonPath)
				print(("%s" + "Replace variable name...Exception occurs" + "%s") % (bad, end))
		print((("%s") + "Complete layout confusion." + ("%s")) % (backGreenFrontWhite, end))
		print(("%s" + "Complete layout confusion and data flow confusion! The obfuscation result is stored in file " + ("%s") + "." + ("%s")) % (backBlueFrontWhite, self.outputFileName, end))



#unit test
if __name__ == "__main__":
	if len(sys.argv) != 3:
		print("wrong parameters.")
	else:
		lc = layoutConfuse(sys.argv[1], sys.argv[2])
		lc.run()
		#print(dfo.solContent)

