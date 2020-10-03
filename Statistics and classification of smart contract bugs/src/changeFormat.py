#!/usr/bin/python
#-*- coding: utf-8 -*-

import re

class changeFormat:
	def __init__(self, _solContent):
		self.content = _solContent

	def reSubT(self, _content):
		pattern = r"\t"
		return re.sub(pattern, "", _content)

	def reSubN(self, _content):
		pattern = r"\n"
		return re.sub(pattern, "", _content)

	def reSubS(self, _content):
		pattern = r"(\s){1,}"
		return re.sub(pattern, " ", _content)

	def doChange(self):
		nowContent = self.content
		#1. delete \t
		nowContent = self.reSubT(nowContent)
		#2. delete \n
		nowContent = self.reSubN(nowContent)
		#3. delete \s
		nowContent = self.reSubS(nowContent)
		return nowContent
