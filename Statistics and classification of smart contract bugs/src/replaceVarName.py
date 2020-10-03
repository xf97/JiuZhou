#!/usr/bin/python
#-*- coding: utf-8 -*-

'''
This python file is part of the layout obfuscation and 
is used to replace variable names with less readable 
strings (currently hash values).
'''

import os
import json
import sys
import re
import hashlib
import time

VAR_FLAG = 1
IDENTIFIER_FLAG = 2
FUNC_FLAG = 3
CONTRACT_FLAG = 4

class replaceVarName:
	def __init__(self, _solContent, _jsonContent):
		self.content = _solContent
		self.json = _jsonContent
		#print(type(self.json))

	def getNames(self, _json):
		#dictList = list()
		#dictList.append(_json)
		varName = set(self._getName(_json, "name", "VariableDeclaration", VAR_FLAG))
		idenName = set(self._getName(_json, "name", "Identifier", IDENTIFIER_FLAG))
		funcName = set(self._getName(_json, "name", "FunctionDefinition", FUNC_FLAG))
		contractName = set(self._getName(_json, "exportedSymbols", "", CONTRACT_FLAG))
		#print(idenName)
		return varName | idenName | funcName | contractName

	def getDictName(self, _dict, _flag):
		for key in _dict:
			if key == "attributes" and _flag == VAR_FLAG:
				if len(_dict[key].get("name")) > 0:
					return _dict[key].get("name")
				else:
					continue
			elif key == "attributes" and _flag == IDENTIFIER_FLAG and \
			     _dict[key].get("referencedDeclaration") != None and \
			     _dict[key].get("referencedDeclaration") > 0 and \
			     _dict[key].get("value") != None and _dict[key].get("type") != "msg":
			     #print(_dict[key].get("referencedDeclaration"))
			     return _dict[key].get("value")
			elif key == "attributes" and _flag == FUNC_FLAG and \
			     _dict[key].get("kind") != None and \
			     _dict[key].get("kind") == "function" :
			     return _dict[key].get("name")
			elif _flag == CONTRACT_FLAG and key == "exportedSymbols":
				return _dict[key].keys()

	def _getName(self, _json, _key, _value, _flag):
		queue = [_json]
		result = list()
		while len(queue) > 0:
			data = queue.pop()
			#print(data)
			for key in data:
				if _flag == CONTRACT_FLAG and key == _key:
					namelist = self.getDictName(data, _flag)
					result.extend(namelist)
				#print(key)
				elif key == _key and data[key] == _value:
					name = self.getDictName(data, _flag)
					#print(data)
					#print("****************************")
					result.append(name)
					#result.append(data)
				elif type(data[key]) == dict:
					queue.append(data[key])
				elif type(data[key]) == list:
					for item in data[key]:
						if type(item) == dict:
							queue.append(item)
		return result


	def doReplace(self):
		#1. get names of all variables and identifiers
		nameList = self.getNames(self.json)
		replacedResult = self.content
		#2. Replace the name of each variable and identifier with a hash value
		for name in nameList:
			if name != None:
				replacedResult = self.replace1Name(replacedResult, name)
		#print(replacedResult)
		#3. return result
		return replacedResult

	def makeRe(self, _str):
		return "(\\b)" + _str + "(\\b)"


	'''
	Why do we choose sha1 algorithm? 
	There are two reasons for this:
	1. Although the SHA1 algorithm can be cracked, 
	in our intention, cracking the "variable name" is actually meaningless.
    2. The output of the SHA1 algorithm is a 160-bit hash value, which is 
    the same as Solidity's address type and can interfere with some static 
    code scanning tools.
	'''
	def makeHashName(self, _str):
		sha1 = hashlib.sha1()
		sha1.update(_str.encode("utf-8") + str(time.time()).encode("utf-8"))
		res = sha1.hexdigest()
		return "Ox" + res


	def replace1Name(self, _content, _name):
		#1. construct the re expression
		reExp = self.makeRe(_name)
		#2. generate the replacement
		hashName = self.makeHashName(_name)
		#3. find the name and replace it
		#temp = _content
		return re.sub(reExp, hashName, _content)

