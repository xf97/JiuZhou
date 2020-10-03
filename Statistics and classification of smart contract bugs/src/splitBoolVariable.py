#!/usr/bin/python
#-*- coding: utf-8 -*-

from random import randint
import json
from generateExp import generateExp

VAR_DECLARE = "VariableDeclaration"
VAR_DECLARE_STATE = "VariableDeclarationStatement"
VAR_ASSIGN = "Assignment"
CORPUS_PATH = "Corpus.txt"
RANDOM_LIMIT = 100

class splitBoolVariable:
	def __init__(self, _solContent, _jsonContent):
		self.content = _solContent
		self.json = _jsonContent
		self.corpusDict = self.getCorpus()
		self.boolExpList = list()

	def getCorpus(self):
		corpusDict = dict()
		with open(CORPUS_PATH, "r", encoding  = "utf-8") as f:
			corpusDict = json.loads(f.read())
		#print(corpusDict,"kkkkkkkk")
		return corpusDict

	def findBoolList(self):
		nodeList = self.findASTNode("name", "Literal")
		#nodeList.extend(self.findASTNode("name", "VariableDeclarationStatement"))
		resultList = list()
		for node in nodeList:
			try:
				if node["attributes"].get("type") == "bool":
					startPos, endPos = self.srcToPos(node["src"])
					value = node["attributes"].get("value")
					resultList.append([value, startPos, endPos])
				else:
					continue
			except:
				continue
		return resultList

	def findASTNode(self, _key, _value):
		queue = [self.json]
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

	def filterBoolVariable(self, _list):
		boolList = list()
		for node in _list:
			try:
				_id = node.get("id")
				#value = node["attributes"].get("value")
				boolList.append(_id)
			except:
				continue
		return boolList

	def findStatement(self):
		resultList = list()
		resultList.extend(self.findASTNode("name", "VariableDeclaration"))
		resultList.extend(self.findASTNode("name", "VariableDeclarationStatement"))
		resultList.extend(self.findASTNode("name", "Assignment"))
		return resultList

	def findBoolOpe(self, _boolList, _dict, _stateType):
		if _stateType == VAR_DECLARE:
			return self.findVarDeclare(_boolList, _dict)
		elif _stateType == VAR_DECLARE_STATE:
			return self.findVarDeclareState(_boolList, _dict)
		elif _stateType == VAR_ASSIGN:
			return self.findAssign(_boolList, _dict)
		else:
			return list()

	def findAssign(self, _boolList, _dict):
		for _bool in _boolList:
			try:
				ope = _dict["attributes"]["operator"]
				_id = _dict["children"][0]["attributes"].get("referencedDeclaration")
				name = _dict["children"][0]["attributes"].get("value")
				#print(ope, _id, name)
				if ope == "=" and _id == _bool[1] and name == _bool[0]:
					return self.srcToPos(_dict["src"])
				else:
					continue
			except:
				continue
		return list()


	def srcToPos(self, _str):
		_list = _str.split(":")
		return [int(_list[0]), int(_list[0]) + int(_list[1])]

	def findVarDeclare(self, _boolList, _dict):
		for _bool in _boolList:
			try:
				_id = _dict["id"]
				name = _dict["attributes"]["name"]
				#print(name, _id, _bool[0], _bool[1])
				if _bool[0] == name and _bool[1] == _id:
					return self.srcToPos(_dict["src"])
				else:
					continue
			except:
				continue
		return list()

	def findVarDeclareState(self, _boolList, _dict):
		for _bool in _boolList:
			try:
				if _bool[1] in _dict["attributes"]["assignments"]:
					#print(self.srcToPos(_dict["src"]))
					return self.srcToPos(_dict["src"])
				else:
					continue
			except:
				continue
		return list()

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
		#print(sliceIndex)
		flag = 0
		index = 0
		while flag < len(sliceIndex):
			if flag % 2 == 0:
				temp += _oldContent[index : sliceIndex[flag]]
				index = sliceIndex[flag]
				flag += 1
			else:
				temp += _oldContent[index : sliceIndex[flag]] + self.splitBool(_list, index, sliceIndex[flag])
				index = sliceIndex[flag] 
				flag += 1
		temp += _oldContent[index : ]
		return temp

	def splitBool(self, _list, _sPos, _ePos):
		for literal in _list:
			if literal[1] == _sPos and literal[2] == _ePos:
				return self.getBoolExp(literal[0])
			else:
				continue
		return ""

	def generateExp(self, _str):
		ge = generateExp(int(_str))
		#print(ge.main())
		return ge.main()

	def getBoolExp(self, _flag):
		flag = randint(0,1)
		ope = ["==", "!="]
		if flag:
			if len(self.boolExpList) == 0:
				expList = list()
				for item in self.corpusDict["boolExpressions"]:
					expList.append(item["text"])
				self.boolExpList = expList
			if _flag != "true":
				return " && (" + self.boolExpList[randint(0, len(self.boolExpList) - 1)] + ")"
			else:
				return " || (" + self.boolExpList[randint(0, len(self.boolExpList) - 1)] + ")"
		else:
			seed = randint(0, RANDOM_LIMIT)
			exp1 = str()
			exp2 = str()
			if _flag:
				return  " || ((" + self.generateExp(str(randint(0, RANDOM_LIMIT))) \
				+ ") " + ope[randint(0,1)]  + " (" + self.generateExp(str(randint(0, RANDOM_LIMIT))) + "))"
			else:
				return  " && ((" + self.generateExp(str(randint(0, RANDOM_LIMIT))) \
				+ ") " + ope[randint(0,1)] + " (" + self.generateExp(str(randint(0, RANDOM_LIMIT))) + "))"


	def doSplit(self):
		'''
		总的思想应该是：找到所有bool常量，
		在为这些常量的语句最后，添加”与真值与“或”与假值或“的部分。
		'''
		#1. 先找到每个布尔型常量的源代码位置
		boolList = self.findBoolList()
		if len(boolList) == 0:
			return self.content
		else:
			#print(len(boolList))
			#2. 为每个布尔型常量加后缀
			nowContent = self.content
			nowContent = self.strReplace(nowContent, boolList)
			#print(nowContent)
			return nowContent
		'''
		#1. 先找到每个布尔型变量的名字和id
		boolList = self.findBoolList()
		#print(boolList)
		#2. 找到每个VariableDeclaration、VariableDeclarationStatement、Assignment节点
		statementList = self.findStatement()
		boolOpeStatement = list()
		#3. 找到对bool变量操作的语句
		for statement in statementList:
			try:
				if statement["name"] == "VariableDeclaration":
					boolOpeStatement.append(self.findBoolOpe(boolList, statement, "VariableDeclaration"))
				elif statement["name"] == "VariableDeclarationStatement":
					boolOpeStatement.append(self.findBoolOpe(boolList, statement, "VariableDeclarationStatement"))
				elif statement["name"] == "Assignment":
					boolOpeStatement.append(self.findBoolOpe(boolList, statement, "Assignment"))
					#pass
				else:
					continue
			except:
				continue
		print(self.content[90:106], self.content[109:125])
		'''
