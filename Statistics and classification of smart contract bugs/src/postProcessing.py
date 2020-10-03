#!/usr/bin/python
#-*- coding: utf-8 -*-

from fraction import Fraction
import random

class postProcessing:
	def __init__(self, _expFile, _answerFile, _target):
		self.target = int(_target)
		self.fracTarget = Fraction(self.target, 1)
		self.expFileName = _expFile
		self.answerFileName = _answerFile
		self.expList = self.getExpList(self.expFileName)
		self.answerList = self.getAnswerList(self.answerFileName)

	def getExpList(self, _expFile):
		with open(_expFile, "r", encoding = "utf-8") as f:
			return f.readlines()
		return list()

	def getAnswerList(self, _answerFile):
		with open(_answerFile, "r", encoding = "utf-8") as f:
			return f.readlines()
		return list()

	def filterExp(self, _expList, _answerList):
		expList = list()
		answerList = list()
		for index in range(len(_answerList)):
			if _answerList[index].split()[1] == "False":
				continue
			else:
				expList.append(_expList[index])
				answerList.append(_answerList[index])
		temp = list()
		for exp in expList:
			tempStr = exp.replace("=", "")
			tempStr = tempStr.strip("\n")
			#print(tempStr)
			temp.append(tempStr)
		return temp, answerList

	def getDifference(self, _value):
		#是不是分数
		if _value.find("/") != -1:
			fracSub = Fraction(int(_value.split("/")[0]), int(_value.split("/")[1]))
			'''
			print("****")
			print(type(self.fracTarget - fracSub))
			print("****")
			'''
			return self.fracTarget - fracSub
		else:
			return self.target - int(_value)

	def modifyExp(self, _expList, _answerList):
		expList = list()
		for index in range(len(_expList)):
			value = _answerList[index].split()[1]
			difference = str(self.getDifference(value))
			if difference.find("-") == 0:
				newExp = _expList[index]
				newExp += difference[:1] + " " + difference[1:]
				expList.append(newExp)
			else:
				newExp = _expList[index]
				newExp += ("+ " + difference)
				expList.append(newExp)
				#_answerList[index] += (" + " + difference)
		# 替换乘除操作符
		temp = list()
		tempStr = str()
		for exp in expList:
			tempStr = exp.replace("x", "*")
			tempStr = tempStr.replace("÷", "/")
			temp.append(tempStr.split(":")[1].lstrip())
		return temp




	def run(self):
		#1. get correct expressions
		expList, answerList = self.filterExp(self.expList, self.answerList)
		#print(len(expList), len(answerList))
		#2. modify expressions
		expList = self.modifyExp(expList, answerList)
		#3. randomly select one exp
		index = random.randint(0, len(expList))
		finalExp = expList[index]
		return finalExp
