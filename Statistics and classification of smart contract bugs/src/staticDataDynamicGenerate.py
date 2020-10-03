#!/usr/bin/python
#-*- coding: utf-8 -*-

'''
This part of the program is used to convert 
the constants (address, integer, string, he-
xadecimal) in the contract into dynamically 
generated data without affecting the original 
function of the contract.
'''

'''
key points:
Solidity is a limited language, as is Ethereum.
'''

import os
import json
import sys
import re
from noTouchPure import noTouchPure

ADDRESS_FLAG = "address"
STRING_FLAG = "literal_string"
INT_FLAG = "int_const"
BOOL_FLAG = "bool"

CORPUS_PATH = "Corpus.txt"

START_FLAG = 1
END_FLAG = 2


class staticDataDynamicGenerate:
	def __init__(self, _solContent, _jsonContent):
		self.content = _solContent
		self.json = _jsonContent
		self.corpusDict = self.getCorpus()
		self.NTP = noTouchPure(self.json)

	def getCorpus(self):
		corpusDict = dict()
		with open(CORPUS_PATH, "r", encoding  = "utf-8") as f:
			corpusDict = json.loads(f.read())
		#print(corpusDict,"kkkkkkkk")
		return corpusDict

	def getIntType(self):
		temp = self.findLiteral(self.json, "name", "VariableDeclaration")
		intNode = list()
		for node in temp:
			try:
				if node["attributes"].get("type").find("int") != -1:
					intNode.append(node)
				else:
					continue
			except:
				continue
		intNodeInfor = list()
		for node in intNode:
			_type = node["attributes"].get("type")
			_id = node["id"]
			intNodeInfor.append([_type, _id])
		return intNodeInfor


	def filterString(self, _list):
		resultList = list()
		for i in _list:
			if i["attributes"].get("value") == "" and i["attributes"].get("type").split()[0] == STRING_FLAG:
				continue
			else:
				resultList.append(i)
		return resultList

	def filterOperation(self, _list):
		resultList = list()
		operationNode = self.findLiteral(self.json, "name", "BinaryOperation")
		for node in _list:
			literalSPos = self.listToInt([node["src"].split(":")[0]])
			literalEPos = self.listToInt(node["src"].split(":"))
			for i in operationNode:
				sPos = self.listToInt([i["src"].split(":")[0]])
				ePos = self.listToInt(i["src"].split(":"))
				if literalSPos <= sPos and literalEPos >= ePos:
					continue
				else:
					resultList.append(node)
		return resultList


	def doGenerate(self):
		#1. find each literal 
		literalList = self.findLiteral(self.json, "name", "Literal")
		literalList = self.NTP.run(literalList)
		literalList = self.filterString(literalList)
		literalList = self.filterOperation(literalList)
		if len(literalList) == 0:
			return self.content
		else:
			#2. generate each literal's replacement
			#2.1 declare array to store literal
			typeList = self.getLiteralType(literalList)
			#patch
			intTypeList = self.getIntType()
			nowContent = self.content
			insertPosition = self.getContractStartOrEnd(END_FLAG)
			#2.2 write getter function into contract
			#print(typeList)
			for _type in typeList:
				if _type == ADDRESS_FLAG:
					(nowContent, insertPosition) = self.insertFunc(nowContent, insertPosition, _type)
				elif _type == STRING_FLAG:
					(nowContent, insertPosition) = self.insertFunc(nowContent, insertPosition, _type)
				elif _type == INT_FLAG:
					(nowContent, insertPosition) = self.insertFunc(nowContent, insertPosition, _type)
				elif _type == BOOL_FLAG:
					(nowContent, insertPosition) = self.insertFunc(nowContent, insertPosition, _type)
				else:
					continue	
			#2.3 insert variable - array
			#insertPosition = self.getContractStartOrEnd(START_FLAG)
			arrayList = list()
			for _type in typeList:
				if _type == ADDRESS_FLAG:
					(nowContent, insertPosition, array) = self.insertArrayDeclare(nowContent, insertPosition, _type)
					arrayList.append(array)
				elif _type == STRING_FLAG:
					(nowContent, insertPosition, array) = self.insertArrayDeclare(nowContent, insertPosition, _type)
					arrayList.append(array)
				elif _type == INT_FLAG:
					(nowContent, insertPosition, array) = self.insertArrayDeclare(nowContent, insertPosition, _type)
					arrayList.append(array)
				elif _type == BOOL_FLAG:
					(nowContent, insertPosition, array) = self.insertArrayDeclare(nowContent, insertPosition, _type)
					arrayList.append(array)
				else:
					continue
			#3. find all literals and replace it 
			insertList = list()
			for _dict in literalList:
				(_type, value, startPos, endPos) = self.getLiteralInfor(_dict)
				if _type == INT_FLAG:
					callStatement = self.makeCallStatement(arrayList, _type, value)
					#print(callStatement, "****")
					callStatement = self.remakeCallStatement(callStatement, startPos, endPos, intTypeList)
					#print(callStatement)
				else:
					callStatement = self.makeCallStatement(arrayList, _type, value)
				insertList.append([callStatement, startPos, endPos])
			nowContent = self.strReplace(nowContent, insertList)
			return nowContent

	def remakeCallStatement(self, _state, _startPos, _endPos, _typeList):
		temp = self.findLiteral(self.json, "name", "VariableDeclaration");
		temp.extend(self.findLiteral(self.json, "name", "Assignment"))
		temp1 = self.findLiteral(self.json, "name", "VariableDeclarationStatement")
		for i in temp:
			sPos = self.listToInt([i["src"].split(":")[0]])
			ePos = self.listToInt(i["src"].split(":"))
			if sPos <= _startPos and ePos >= _endPos:
				_type = i["attributes"]["type"]
				return " " + _type + "(" + _state.lstrip() + ")"
			else:
				continue
		for i in temp1:
			sPos = self.listToInt([i["src"].split(":")[0]])
			ePos = self.listToInt(i["src"].split(":"))
			if sPos <= _startPos and ePos >= _endPos:
				_type = i["children"][0]["attributes"]["type"]
				return " " + _type + "(" + _state.lstrip() + ")"
			else:
				continue
		return _state

				#return " " + _type + "(" + _state.lstrip() + ")"




	'''
	def strReplace(self, _oldContent, _insertContent, _startPos, _endPos):
		return _oldContent[startPos:] + _insertContent + _oldContent[:endPos]
	'''

	def strReplace(self, _oldContent, _list):
		temp = str()
		sliceIndex = list()
		for item in _list:
			if item[1] == 0 and item[2] == 0:
				continue
			else:
				sliceIndex.append(int(item[1]))
				sliceIndex.append(int(item[2]))
		#sliceIndex = self.filterList(sliceIndex)
		sliceIndex.sort()	# from small to big
		flag = 0
		index = 0
		while flag < len(sliceIndex):
			if flag % 2 == 0:
				temp += _oldContent[index : sliceIndex[flag]]
				index = sliceIndex[flag]
				flag += 1
			else:
				temp += self.getCallStatement(_list, index, sliceIndex[flag])
				index = sliceIndex[flag] 
				flag += 1
		temp += _oldContent[index : ]
		return temp

	def getCallStatement(self, _list, _startPos, _endPos):
		for item in _list:
			if int(item[1]) == _startPos and int(item[2]) == _endPos:
				return item[0]
		return str()



	def makeCallStatement(self, _array, _type, _value):
		flag = self.reMakeType(_type)
		for state in _array:
			if flag == state.split()[0]:
				#print("hello", flag, _type, _type == BOOL_FLAG, state)
				valueList = self.getArrayElement(state, _type)
				for index in range(len(valueList)):
					if str(_value) == valueList[index] and _type == INT_FLAG:
						return " getIntFunc(" + str(index) + ")"
					elif str(_value) == valueList[index] and _type == ADDRESS_FLAG:
						return " getAddrFunc(" + str(index) + ")"
					elif  _type == STRING_FLAG and  _value == valueList[index].strip("\""):
						return " getStrFunc(" + str(index) + ")"
					elif _type == BOOL_FLAG and str(_value) == valueList[index]:
						#print(str(_value), valueList[index])
						return " getBoolFunc(" + str(index) + ")"
		return str()

	def getArrayElement(self, _state, _type):
		temp = _state.split("=")[1]
		result = list()
		if _type == INT_FLAG:
			for i in re.finditer(r"(\d)+", temp):
				result.append(i.group())
		elif _type == ADDRESS_FLAG:
			for i in re.finditer(r"((0x)|(0X))?(\w){39,41}", temp):
				result.append(i.group())
		elif _type == STRING_FLAG:
			for i in re.finditer(r"(\")(.)*(\")", temp):
				result.append(i.group())
		elif _type == BOOL_FLAG:
			for i in re.finditer(r"((false)|(true))", temp):
				result.append(i.group())
		#print(result)
		return result

	def reMakeType(self, _type):
		if _type == INT_FLAG:
			return "uint256[]"
		elif _type == STRING_FLAG:
			return "string[]"
		elif _type == ADDRESS_FLAG:
			return "address"
		elif _type == BOOL_FLAG:
			return "bool[]"

	def getLiteralInfor(self, _dict):
		try:
			startPos = int(_dict["src"].split(":")[0])
			endPos = int(_dict["src"].split(":")[1]) + int(startPos)
			_type = _dict["attributes"]["type"].split()[0]
			if _type == INT_FLAG:
				_value = _dict["attributes"]["type"].split()[1]
			elif _dict["attributes"]["value"] == None:
				return 0, 0, 0, 0
			else:
				_value = _dict["attributes"]["value"]
			return _type, _value, startPos, endPos
		except:
			return 0, 0, 0, 0



	def insertArrayDeclare(self, _content, _position, _type):
		intStr = str()
		for item in self.corpusDict:
			if item == "insertVariable":
				for _dict in self.corpusDict[item]:
					if _type == INT_FLAG and _dict.get("type") == "UintArrayDeclare":
						intStr = _dict.get("variableDeclaration")
						intStr += self.getValue(_type)
					elif  _type == STRING_FLAG and _dict.get("type") == "StringArrayDeclare":
						intStr = _dict.get("variableDeclaration")
						intStr += self.getValue(_type)
					elif  _type == ADDRESS_FLAG and _dict.get("type") == "AddressArrayDeclare":
						intStr = _dict.get("variableDeclaration")
						intStr += self.getValue(_type)
					elif _type == BOOL_FLAG and _dict.get("type") == "BoolArrayDeclare":
						intStr = _dict.get("variableDeclaration")
						intStr += self.getValue(_type)
		#print(self.strInsert(_content, intStr, _position))#, _position + len(intStr))
		return self.strInsert(_content, intStr, _position - 1), _position + len(intStr), intStr

	def getValue(self, _type):
		typeList = self.findLiteral(self.json, "name", "Literal")
		valueList = list()
		for _dict in typeList:
			try:
				if _type != INT_FLAG and _type == _dict["attributes"]["type"].split()[0]:
					valueList.append(_dict["attributes"]["value"])
				elif _type == INT_FLAG and _type == _dict["attributes"]["type"].split()[0]:
					valueList.append(_dict["attributes"]["type"].split()[1])
			except:
				continue
		valueList = self.filterList(valueList)
		intStr = str()
		if _type == INT_FLAG:
			for num in valueList:
				if valueList.index(num) == len(valueList) - 1:
					intStr += num
				else:
					intStr += num
					intStr += ", "
			intStr += "];\n"
		elif _type == ADDRESS_FLAG:
			for addr in valueList:
				if valueList.index(addr) == len(valueList) - 1:
					intStr += addr
				else:
					intStr += addr 
					intStr += ", "
			intStr += "];\n"
		elif _type == STRING_FLAG:
			for string in valueList:
				if valueList.index(string) == len(valueList) - 1:
					intStr += "\"" + string + "\""
				else:
					intStr += "\"" + string + "\""
					intStr += ", "
			intStr += "];\n"
		elif _type == BOOL_FLAG:
			for flag in valueList:
				if valueList.index(flag) == len(valueList) - 1:
					intStr += flag
				else:
					intStr += flag 
					intStr += ", "
			intStr += "];\n"
		return intStr

	def filterList(self, _list):
		temp = _list
		for item in temp:
			if item == None:
				temp.remove(item)
		return list(set(temp))

	def getContractStartOrEnd(self, _flag):
		_list = self.findLiteral(self.json, "name", "ContractDefinition")
		#contractEnd = list()
		temp = list()
		for _dict in _list:
			temp.append(_dict["src"])
		if _flag == END_FLAG:
			return self.listToInt(temp[0].split(":"))
		elif _flag == START_FLAG:
			return self.listToInt([temp[0].split(":")[0]])
		'''
		for item in temp:
			contractEnd.append(self.listToInt(item.split(":")))
		return contractEnd
		'''


	def listToInt(self, _list):
		totalSum = 0
		for num in _list:
			totalSum += int(num)
		return totalSum

	def insertFunc(self, _content, _position, _type):
		intStr = str()
		for item in self.corpusDict:
			if item == "insertFunc":
				for _dict in self.corpusDict[item]:
					if _type == INT_FLAG and _dict.get("type") == "getIntFunction":
						intStr = _dict.get("functionHeadAndBody")
					elif  _type == STRING_FLAG and _dict.get("type") == "getStrFunction":
						intStr = _dict.get("functionHeadAndBody")
					elif  _type == ADDRESS_FLAG and _dict.get("type") == "getAddrFunction":
						intStr = _dict.get("functionHeadAndBody")
					elif _type == BOOL_FLAG and _dict.get("type") == "getBoolFunction":
						intStr = _dict.get("functionHeadAndBody")
		#print(self.strInsert(_content, intStr, _position))#, _position + len(intStr))
		return self.strInsert(_content, intStr, _position - 1), _position + len(intStr)

    #Inserting a substr into another str at specific position
	def strInsert(self, _oldContent, _insertContent, _position):
		return _oldContent[:_position] + _insertContent + _oldContent[_position:]

		#self.declareAndInitArray(literalList, self.content, self.json)
		'''
		for literal in literalList:
			typeList = 
		return self.content
		'''

	def getLiteralType(self, _list):
		typeList = list()
		for _dict in _list:
			try:
				typeList.append(_dict["attributes"]["type"].split()[0])
			except:
				continue
		return list(set(typeList))


	def findLiteral(self, _json, _key, _value):
		queue = [_json]
		result = list()
		literalList = list()
		while len(queue) > 0:
			data = queue.pop()
			for key in data:
				if key == _key and  data[key] == _value:
					result.append(data)
				elif type(data[key]) == dict:
					queue.append(data[key])
				elif type(data[key]) == list:
					for item in data[key]:
						if type(item) == dict:
							queue.append(item)
		return result
		'''
		for _dict in result:
			literalList.append(self.getLiteralName(_dict))
		#print(literalList)
		return literalList
		'''

	def getLiteralName(self, _dict):
		try:
			value = _dict["attributes"]["value"]
			location = _dict["src"]
			return value, location
		except:
			return "hex literal is not supported.", 0




