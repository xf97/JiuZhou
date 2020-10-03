#!/usr/bin/python
#-*- coding: utf-8 -*-

import re

class arrayMergeCollapse:
	def __init__(self, _solContent, _jsonContent):
		self.content = _solContent
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

	def getFixedArray(self):
		varList = self.findASTNode("name", "VariableDeclaration")
		fixedArrayList = list()
		pattern = r"\[(\d)+\]"
		for i in varList:
			_type = i["attributes"].get("type")
			#print(_type)
			d = re.search(pattern, _type)
			if d is None:
				continue
			else:
				_id = i["id"]
				#_type = _type.split("[")[0]
				fixedArrayList.append([_type, _id])
		return fixedArrayList

	def returnSpeTypeArray(self, _type, _list):
		result = list()
		for i in _list:
			if i[0].split('[')[0] == _type:
				result.append(i)
		return result

	def findTarget(self, _list):
		typeList = list()
		targetList = list()
		for i in _list:
			typeList.append(i[0].split("[")[0])
		for i in list(set(typeList)):
			if typeList.count(i) > 1:
				targetList.append(self.returnSpeTypeArray(i, _list))
			else:
				continue
		return targetList


	def doMerge(self):
		#1. 找到所有定长、且被初始化的数组的类型和id
		fixedArrayList = self.getFixedArray()
		#2. 找到需要合并的数组
		targetArrayList = self.findTarget(fixedArrayList)
		print(targetArrayList)