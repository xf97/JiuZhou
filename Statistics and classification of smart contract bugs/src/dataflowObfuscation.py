#!/usr/bin/python
#-*- coding: utf-8 -*-

'''
This program is the main program to execute data flow confusion, 
its input is a .sol source code file and the corresponding compiled 
json.ast file, its output is a .sol source code file after data 
flow obfuscation.
'''

import os
import json
import sys
from staticDataDynamicGenerate import staticDataDynamicGenerate
from literal2Exp import literal2Exp
from splitBoolVariable import splitBoolVariable
from local2State import local2State
from arrayMergeCollapse import arrayMergeCollapse
from scalar2Vector import scalar2Vector
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


class dataflowObfuscation:
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
		#self.finalContract = _filepath.split(".sol")[0] + "_dataflow_confuse.sol"

	def getOutputFileName(self, _filepath):
		temp = _filepath.split(".sol")
		newFileName = temp[0] + "_dataflow_confuse.sol"
		return newFileName

	def getContent(self, _filepath):
		with open(_filepath, "r", encoding = "utf-8") as f:
			return f.read()
		return str()

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

	def getConfig(self):
		config = self.getJsonContent(self.configPath)
		self.featureList = config["activateFunc"]

	def isActivate(self, _name):
		for _dict in self.featureList:
			try:
				return _dict[_name]
			except:
				continue
		return True

	def run(self):
		print((("%s") + "Start data flow confusion:" + ("%s")) % (backGreenFrontWhite, end))
		if self.isActivate("local2State"):
			try:
				self.L2S = local2State(self.solContent, self.json)
				nowContent = self.L2S.preProcess()
				self.writeStrToFile(self.middleContract, nowContent, "Convert local variables to state variables, preprocess")
				self.recompileMiddleContract()
				nowContent = self.L2S.resetSolAndJson(self.solContent, self.json)
				nowContent = self.L2S.doChange()
				self.writeStrToFile(self.middleContract, nowContent, "Convert local variables to state variables")
				self.recompileMiddleContract()
			except:
				#nowContent = solContent
				self.solContent = self.getContent(self.filePath)
				self.json = self.getJsonContent(self.jsonPath)
				print(("%s" + "Convert local variables to state variables...Exception occurs" + "%s") % (bad, end))
		if self.isActivate("staticDataDynamicGenerate"):
			self.SDDG = staticDataDynamicGenerate(self.solContent, self.json) #SDDG is a class which is used to convert static literal to dynamic generated data
			nowContent = self.SDDG.doGenerate()
			self.writeStrToFile(self.middleContract, nowContent, "Dynamically generate static data")
			self.recompileMiddleContract()
			'''
			except:
				self.solContent = self.getContent(self.filePath)
				self.json = self.getJsonContent(self.jsonPath)
				print(("%s" + "Dynamically generate static data...Exception occurs" + "%s") % (bad, end))
			'''
		if self.isActivate("literal2Exp"):
			try:
				self.L2E = literal2Exp(self.solContent, self.json) #L2E is a class which is used to convert integer literal to arithmetic expressions
				nowContent = self.L2E.doGenerate()
				self.writeStrToFile(self.middleContract, nowContent, "Convert integer literals to arithmetic expressions")
				self.recompileMiddleContract()
			except:
				self.solContent = self.getContent(self.filePath)
				self.json = self.getJsonContent(self.jsonPath)
				print(("%s" + "Convert integer literals to arithmetic expressions...Exception occurs" + "%s") % (bad, end))
		if self.isActivate("splitBoolVariable"):
			try:
				self.SBV = splitBoolVariable(self.solContent, self.json)
				nowContent = self.SBV.doSplit()
				self.writeStrToFile(self.middleContract, nowContent, "Split boolean variables")
				self.recompileMiddleContract()
			except:
				self.solContent = self.getContent(self.filePath)
				self.json = self.getJsonContent(self.jsonPath)
				print(("%s" + "Split boolean variables...Exception occurs" + "%s") % (bad, end))
		if self.isActivate("scalar2Vector"):
			try:
				self.S2V = scalar2Vector(self.solContent, self.json)
				nowContent = self.S2V.doChange()
				self.writeStrToFile(self.middleContract, nowContent, "Scalar to vector")
				self.recompileMiddleContract()
			except:
				self.solContent = self.getContent(self.filePath)
				self.json = self.getJsonContent(self.jsonPath)
				print(("%s" + "Scalar to vector...Exception occurs" + "%s") % (bad, end))
		'''
		if self.isActivate("arrayMergeCollapse"):
			self.AMC = arrayMergeCollapse(self.solContent, self.json)
			nowContent = self.AMC.doMerge()
		'''
		print((("%s") + "Complete data flow confusion." + ("%s")) % (backGreenFrontWhite, end))


#unit test
if __name__ == "__main__":
	if len(sys.argv) != 3:
		print("wrong parameters.")
	else:
		dfo = dataflowObfuscation(sys.argv[1], sys.argv[2])
		dfo.run()
		#print(dfo.solContent)
