# -*- coding = 'utf-8 -*-

import argparse

from exp_generate import Config,Generator
from answer import expression_result,check_answer
from postProcessing import postProcessing
import sys

colors = True # Output should be colored
machine = sys.platform # Detecting the os of current system
if machine.lower().startswith(('os', 'win', 'darwin', 'ios')):
    colors = False # Colors shouldn't be displayed in mac & windows
if not colors:
    end = green = bad = info = ''
    start = ' ['
    stop = ']'
else:
    end = '\033[1;m'
    green = '\033[1;32m'
    white = "\033[1;37m"
    blue = "\033[1;34m"
    yellow = "\033[1;33m"
    bad = '\033[1;31m[-]\033[1;m'
    info = '\033[1;33m[!]\033[1;m'
    start = ' \033[1;31m[\033[0m'
    stop = '\033[1;31m]\033[0m'
    backGreenFrontWhite = "\033[1;37m\033[42m"

class generateExp:
    def __init__(self, _target):
        self.target = _target
        self.expNum = 5000
        self.expFile = "Exercises.txt"
        self.answerFile = "Answer.txt"

    def main(self):
        if self.target <= 2:
            target = 10
        else:
            target = self.target
        """
        主函数
        """
        '''
        parser = argparse.ArgumentParser(description="***** this is auto-generate-expression *****")
        parser.add_argument("-n", metavar = "--number", dest = "expnum_arg", help = "Generate a given number of expressions" )
        parser.add_argument("-r", metavar = "--range", dest = "range_arg", help = "Specify the range of operands")
        parser.add_argument("-e", metavar = "--exercise file", dest = "exercise_arg", help = "Given four arithmetic problem files")
        parser.add_argument("-a", metavar = "--answer file", dest = "answer_arg", help = "Given four arithmetic problem answer files")
        args = parser.parse_args()
        '''
    
        try:
            with open(self.expFile, "w+", encoding = "utf-8") as f:
                f.truncate()
                f.close()
            with open(self.answerFile, "w+", encoding = "utf-8") as f:
                f.truncate()
                f.close()
            print(("%s" + "Clear existing expressions....done." + "%s") % (white, end))
        except:
            print(("%s" + "No need to clear existing expressions." +  "%s") % (white, end))
        
        #判断生成的表达式的数目
        if self.expNum:
            #表达式的范围
            if self.target:
                config = Config(exp_num=int(self.expNum),num_range=int(target))
            else:
                config = Config(exp_num=int(self.expNum))
            print(("%s" + "Arithmetic expression replacing literal (" + str(self.target) + ") is being generated." + "%s") % (green, end))
            generator = Generator()
            res_list = generator.generate(config)
            generator.normalize_exp(res_list)
            expression_result(res_list)
            print(("%s" + 'Generation is complete.' + "%s")  % (green, end))
        #后期处理表达式的值
        #print(args.exercise_arg, args.answer_arg)
        pp = postProcessing(self.expFile, self.answerFile, self.target)
        return pp.run()
    
    '''
    #练习题答案的文件判断
    if args.exercise_arg:
        if args.answer_arg:
            check_answer(args.exercise_arg, args.answer_arg)
        else:
            print('please give an answer files')
            exit(0)
    '''

if __name__ == '__main__':
    ge = generateExp(5000)
    print(ge.main())