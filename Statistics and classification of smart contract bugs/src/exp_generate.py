# -*- coding: utf-8 -*-

from fractions import Fraction
from random import randint

from suffix_expression import suffix_to_value,to_suffix
from remove_duplicate import generate_binary_tree,tree_is_same

class Config:
    """
    配置参数类
    """
    def __init__(self, exp_num=10, num_range=10, max_num_of_oper=3):
        self.exp_num = exp_num   #生成表达式的数目
        self.num_range = num_range  #操作数的范围
        self.max_num_of_oper = max_num_of_oper #最大的运算符数

class Generator:
    """
    表达式生成类
    """
    def generate(self, config):
        """
        表达式生成主函数
        :param
            config: config类
        :return: 
        """
        exp_num = config.exp_num
        exp_list = []
        i = 0
        while i < exp_num:
            random_num_operation = config.max_num_of_oper #randint(1, config.max_num_of_oper)
            is_need_parenteses = randint(0,1)
            number_of_oprand = random_num_operation + 1 #操作数比操作符的数目多1
            exp = []
            for j in range(random_num_operation + number_of_oprand):
                if j % 2 == 0:
                    #随机生成操作数
                    #exp.append(self.generate_operand(randint(0,3), config.num_range))
                    exp.append(self.generate_operand(1, config.num_range))
                    if j > 1 and exp[j-1] == '÷' and exp[j] == '0':
                        while True:
                            exp[j-1] = self.generate_operation()
                            if exp [j-1] == '÷':
                                continue
                            else:
                                break
                else:
                    #生成运算符
                    exp.append(self.generate_operation())
            
            #判断是否要括号
            if is_need_parenteses and number_of_oprand != 2:
                expression = " ".join(self.generate_parentheses(exp, number_of_oprand))
            else:
                expression = " ".join(exp)
            
            #判断是否有重复
            #if self.is_repeat(exp_list, expression) or suffix_to_value(to_suffix(expression)) == False:
            #    continue
            #else:
            exp_list.append(expression)
            #print('第 %d 道题' % int(i+1))
            i = i + 1

        return exp_list

    def generate_parentheses(self, exp, number_of_oprand):
        """
        生成括号表达式
        :param
            exp: 表达式
            number_of_oprand: 运算符数目
        :return: 括号表达式
        """
        expression = []
        num = number_of_oprand
        if exp:
            exp_length = len(exp)
            left_position = randint(0,int(num/2))
            right_position = randint(left_position+1, int(num/2)+1)
            mark = -1
            for i in range(exp_length):
                if exp[i] in ['+', '-', 'x']:
                    expression.append(exp[i])
                else:
                    mark += 1
                    if mark == left_position:
                        expression.append('(')
                        expression.append(exp[i])
                    elif mark == right_position:
                        expression.append(exp[i])
                        expression.append(')')
                    else:
                        expression.append(exp[i])
        #如果生成的括号表达式形如 (1 + 2/3 + 3) 则重新生成
        if expression[0] == '(' and expression[-1] ==')':
            expression = self.generate_parentheses(exp, number_of_oprand)
            return expression
        return expression


    def generate_operand(self, is_fraction, num_range):
        """
        生成操作数值，判断是否需要真分数
        :param: 
            is_fra ction: True or False
            num_range: 操作数的范围
        :return: 操作数
        """
        if not is_fraction:
            return self.generate_fraction(num_range)
        else:
            return str(randint(0, num_range - 1))
    
    
    def generate_fraction(self, num_range):
        """
        生成真分数
        :param: 
            num_range: 操作数的范围
        :return: 真分数，例如1/2        
        """
        denominator = randint(2, num_range)
        numerator = randint(1, denominator - 1)
        random_attach = randint(0,1)
        real_fraction = str(Fraction(numerator, denominator))
        #调用fraction方法生成真分数
        if random_attach != 0:
            real_fraction = str(random_attach) + "'" + real_fraction
        return real_fraction
            
    def generate_operation(self):
        """
        随机生成`+ - x ÷`运算符
        :param: None
        :return: + - x ÷
        """
        operators = ['+', '-', 'x']
        return operators[randint(0,len(operators) - 1)]

    def is_repeat(self, express_set, expression):
        """
        判断重复方法
        :param
            express_set: 表达式集合
            expression: 生成的表达式
        :return: True or False
        """
        target_exp_suffix = to_suffix(expression)
        target_exp_binary_tree = generate_binary_tree(target_exp_suffix)
        for item in express_set:
            source_exp_suffix = to_suffix(item)
            source_exp_binary_tree = generate_binary_tree(source_exp_suffix)
            if tree_is_same(target_exp_binary_tree) == tree_is_same(source_exp_binary_tree):
                return True
        return False

    def normalize_exp(self, exp_list):
        """
        规范化输出表达式
        :param exp_list: 表达式列表
        :return 
        """
        if not exp_list:
            return 
        for i, exp in enumerate(exp_list):
            exp_str = str(i+1) + ': '+ exp +' = '+"\n"
            with open('Exercises.txt', "a+",encoding='utf-8') as f:
                f.write(exp_str)

if __name__ == '__main__':
    pass