#!/usr/bin/python
#-*- coding: utf-8 -*-

'''
This part of the program is used to split each function in a 
single contract into multiple functions without affecting the 
original function of the contract.
'''

import os
import json

class splitFunction:
	def __init__(self, _solContent, _jsonContent):
		self.content = _solContent
		self.json = _jsonContent

	def doSplitFunction(self):
		#1. find each function (include constructor)
		funcList = self.getFunctions()
		splittedContent = self.content
		#2. for each function, split it to multiple functions
		for funcName in funcList:
			if funcName != None:
				splittedContent = self.split1Function(splittedContent, funcName)
		#3. return result
		return splittedContent

	def getFunctions(self):
		return list()

	def split1Function(self, _solContent, _name):
		return str()

	
