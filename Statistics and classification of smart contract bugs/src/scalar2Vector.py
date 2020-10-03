#!/usr/bin/python
#-*- coding: utf-8 -*-

import json
import copy

BOOL_FLAG = "bool"
INT_FLAG = "int"
ADDRESS_FLAG = "address"
ADDRESS_PAYABLE_FLAG = "address payable"
STRING_FLAG = "string"
BYTES_FLAG = "bytes"

CORPUS_PATH = "Corpus.txt"

class scalar2Vector:
	def __init__(self, _solContent, _jsonContent):
		self.content = _solContent
		self.json = _jsonContent
		self.corpusDict = self.getCorpus()
		self.mapping = dict()

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

	def findStateVar(self, _list):
		temp = list()
		for node in _list:
			try:
				if node["attributes"].get("stateVariable") == True:
					temp.append(node)
				else:
					continue
			except:
				continue
		return temp

	def findTargetType(self, _list):
		temp = list()
		for node in _list:
			try:
				if node["attributes"].get("type") == BOOL_FLAG:
					temp.append(node)
				elif node["attributes"].get("type").find(INT_FLAG) != -1 and \
				node["attributes"].get("type").find("[") == -1 and node["attributes"].get("type").find("mapping") == -1:
					temp.append(node)
				elif node["attributes"].get("type") == ADDRESS_FLAG or \
				node["attributes"].get("type") == ADDRESS_PAYABLE_FLAG:
					temp.append(node)
				elif node["attributes"].get("type") == STRING_FLAG:
					temp.append(node)
				elif node["attributes"].get("type") == BYTES_FLAG:
					temp.append(node)
				else:
					continue
			except:
				continue
		return temp

	def srcToPos(self, _str):
		_list = _str.split(":")
		return int(_list[0]), int(_list[0]) + int(_list[1])

	def getNodeInfo(self, _list):
		infoList = list()
		for node in _list:
			name = node["attributes"].get("name")
			_type = node["attributes"].get("type")
			_id = node["id"]
			(sPos, ePos) = self.srcToPos(node["src"])
			value = str()
			if self.content[sPos: ePos].find("=") != -1:
				state = self.content[sPos: ePos]
				#s, e = state.find('=') + 1, state.find(";")
				#print(s, e)
				value = state[state.find("=") + 1 :]
			else:
				value = self.getTypeInit(_type)
			infoList.append([name, _type, _id, (sPos, ePos), value])
		return infoList

	def getTypeInit(self, _type):
		if _type == BOOL_FLAG:
			return "false"
		elif _type.find(INT_FLAG) != -1 and _type.find("[") == -1:
			return "0"
		elif _type == ADDRESS_FLAG:
			return "address(0)"
		elif _type == STRING_FLAG:
			return ""
		elif _type == BYTES_FLAG:
			return "bytes(\"\")"

	def findTargetVar(self):
		nodeList = self.findASTNode("name", "VariableDeclaration")
		# 过滤非状态变量
		stateVarList = self.findStateVar(nodeList)
		# 过滤非目标类型变量
		targetVarList = self.findTargetType(stateVarList)
		# 获取目标信息
		infoList = self.getNodeInfo(targetVarList)
		return infoList

	def getCorpus(self):
		corpusDict = dict()
		with open(CORPUS_PATH, "r", encoding  = "utf-8") as f:
			corpusDict = json.loads(f.read())
		#print(corpusDict,"kkkkkkkk")
		return corpusDict

	def makeDeclareStatement(self, _list):
		structPre = self.corpusDict["insertStructPrefix"]
		_str = str()
		for node in _list:
			#声明变量时，表明对应关系
			self.mapping[node[0]] = node[2]
			_str += node[1]
			_str += " "
			_str += node[0]
			if _list.index(node) == len(_list) - 1:
				_str += ";\n"
			else:
				_str += ";\n\t\t"
		structPre += _str
		structPre += "\t}"
		structPre += self.corpusDict["insertStructSuffix"]
		for node in _list:
			#structPre += node[0]
			#structPre +=  ":"
			structPre += node[4]
			#print(node)
			if _list.index(node) == len(_list) - 1:
				structPre += ");\n"
			else:
				structPre += ", "

		return structPre

	def strInsert(self, _oldContent, _insertContent, _position):
		return _oldContent[:_position] + _insertContent + _oldContent[_position:]

	def insertStruIntoContract(self, _content, _str):
		sPos, ePos = self.srcToPos(self.findASTNode("name", "ContractDefinition")[0]["src"])
		return self.strInsert(_content, _str, ePos - 1)

	def reDefineTargetVar(self, _content, _list):
		content = _content
		for item in _list:
			#state = _content[item[3][0] : item[3][1]]０
			content = self.paddingBlank(content, item[3][0], item[3][1])
				#content = content[item[3][0]:] + " " * (item[3][1] - item[3][0]) + content[:item[3][1]]
		return content

	def reInitVar(self, _content, _sPos, _ePos, _name):
		name = "s2c." +  _name + " "
		i = _sPos
		while i <  _ePos - 5:
			name =  " " + name
			i += 1
		return _content[:_sPos] + name + _content[_ePos:]


	def paddingBlank(self, _content, _sPos, _ePos):
		content = _content[:_sPos]
		i = _sPos
		while _content[i - 1] != ";":
			content += " "
			i += 1
		content += _content[i:]
		return content

	def getIdenInfo(self, _list):
		infoList = list()
		for node in _list:
			_id = node["attributes"]["referencedDeclaration"]
			sPos, ePos = self.srcToPos(node["src"])
			infoList.append([_id, sPos, ePos])
		return infoList

	def findUsedVar(self):
		#print(self.mapping)
		nodeList = self.findASTNode("name", "Identifier")
		#从所有标识符中挑选目标标识符，记录id和起始终止位置
		nodeList = self.findTargetIden(nodeList)
		nodeInfoList = self.getIdenInfo(nodeList)
		return nodeInfoList

	def inMapping(self, _id):
		for key in self.mapping:
			if self.mapping[key] == _id:
				return True
			else:
				continue
		return False

	def findTargetIden(self, _list):
		resultList = list()
		for node in _list:
			try:
				_id = node["attributes"]["referencedDeclaration"]
				if self.inMapping(_id):
					resultList.append(node)
				else:
					continue
			except:
				continue
		return resultList

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
				temp += self.findNewName(_list, index, sliceIndex[flag])
				index = sliceIndex[flag] 
				flag += 1
		temp += _oldContent[index : ]
		return temp

	def findNewName(self, _list, _sPos, _ePos):
		for node in _list:
			if node[1] == _sPos and node[2] == _ePos:
				return node[0]
			else:
				continue
		return str()

	def getNewName(self, _id):
		for key in self.mapping:
			if self.mapping[key] == _id:
				return "s2c." + key
			else:
				continue
		return str()

	def replaceIdentifier(self, _content, _usedInfo):
		#content = copy.deepcopy(_content)
		replacedInfo = list()
		for node in _usedInfo:
			newName = self.getNewName(node[0])
			replacedInfo.append([newName, node[1], node[2]])
		return self.strReplace(_content, replacedInfo)




	#node info: name type id (sPos, ePos)
	def doChange(self):
		#1. 获取目标状态变量信息
		infoList = self.findTargetVar()
		if len(infoList) == 0:
			return self.content 
		else:
			#print(infoList)
			#2. 在合约内部声明结构体——语料库
			declareStatement = self.makeDeclareStatement(infoList)
			#print(declareStatement)
			#3. 插入声明语句
			nowContent = self.content
			nowContent = self.insertStruIntoContract(nowContent, declareStatement)
			#4. 删掉所有的定义并初始化的语句
			nowContent = self.reDefineTargetVar(nowContent, infoList)
			#5. 找到所有使用这些变量的语句
			useInfo = self.findUsedVar()
			#6. 替换标识符
			nowContent = self.replaceIdentifier(nowContent, useInfo)
			#print(nowContent)
			return nowContent
		'''
		for i in infoList:
			print(i)
		'''
