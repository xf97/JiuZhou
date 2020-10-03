#!/usr/bin/python
#-*- coding: utf-8 -*-

import json

PURE_FLAG = "pure"
VIEW_FLAG = "view"

class noTouchPure:
	def __init__(self, _jsonContent):
		self.json = _jsonContent

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

	def srcToPos(self, _str):
		_list = _str.split(":")
		return [int(_list[0]), int(_list[0]) + int(_list[1])]

	def getStartEndPos(self, _list):
		posList = list()
		for item in _list:
			posList.append(self.srcToPos(item["src"]))
		return posList

	def isPureBool(self, _list, _sPos, _ePos):
		for item in _list:
			if int(_sPos) > int(item[0]) and int(_ePos) < int(item[1]):
				return True 
			else:
				continue
		return False

	def run(self, _literalList):
		#1. 找到所有pure函数节点
		funcNode = self.findASTNode("name", "FunctionDefinition")
		pureFuncNode = list()
		for func in funcNode:
			if func["attributes"].get("stateMutability") == PURE_FLAG:
				pureFuncNode.append(func)
			else:
				continue
		#2. 获取pure函数的起始和中止位置
		posList = self.getStartEndPos(pureFuncNode)
		noPureData = list()
		#3. 如何某个布尔常量处于pure函数内，就不要它
		for literal in _literalList:
			sPos, ePos = self.srcToPos(literal["src"])
			if self.isPureBool(posList, sPos, ePos):
				continue
			else:
				noPureData.append(literal)
		return noPureData

	def runLocalVar(self, _list):
		#1. 找到所有pure函数节点
		funcNode = self.findASTNode("name", "FunctionDefinition")
		pureFuncNode = list()
		for func in funcNode:
			if func["attributes"].get("stateMutability") == PURE_FLAG:
				pureFuncNode.append(func)
			elif func["attributes"].get("stateMutability") == VIEW_FLAG:
				pureFuncNode.append(func)
			else:
				continue
		#2. 获取pure函数的起始和中止位置
		posList = self.getStartEndPos(pureFuncNode)
		#print(posList)
		noPureData = list()
		#3. 如何某个本地变量处于pure函数内，就不要它
		for var in _list:
			sPos, ePos = self.srcToPos(var["src"])
			#print(sPos, ePos)
			if self.isPureBool(posList, sPos, ePos):
				continue
			else:
				noPureData.append(var)
		return noPureData

