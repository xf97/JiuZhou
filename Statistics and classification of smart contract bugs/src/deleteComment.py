#!/usr/bin/python
#-*- coding: utf-8 -*-

import re

class deleteComment:
	def __init__(self, _solContent):
		self.content = _solContent

	def deleteSingleComment(self, _content):
		pattern = r"//(.)*(\n)?"
		return re.sub(pattern, "", _content)

	def deleteMultiComment(self, _content):
		pattern = r"(\/)(\*)((.)|(\n))*(\*)(\/)"
		return re.sub(pattern, "", _content)

	def doDelete(self):
		nowContent = self.content
		#1. delete the single-line comment
		nowContent = self.deleteSingleComment(nowContent)
		#2. delete the multi-line comment
		nowContent = self.deleteMultiComment(nowContent)
		return nowContent