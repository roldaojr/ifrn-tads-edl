require '../lib/StackGe'
require '../lib/QueueGe'

##
# Expession calculator class
#
class ExpressionCalc
	##
	# Create a new calculator
	#
	def initialize()
		@operators = {'+' => 1, '-' => 1, '*' => 2, '/' => 2, '^' => 3}
	end
	##
	# Calculate expression
	#
	# @param [String] expression The expression to calculate
	def calcExp(expression)
		infix = textToList(expression)
		postfix = infixToPostfix(infix)
		return calcPostfix(postfix)
	end

	private
	##
	# Check if given symbol is operator or number
	#
	def isOperator(symb)
		symbols = @operators.keys
		return symbols.include? symb
	end
	##
	# Check if op1 has precedence over op2
	#
	def hasPrecedence(op1, op2)
		return @operators[op1] >= @operators[op2]
	end
	##
	# Realize que operation with two numbers and one operator
	#
	def operation(op, val1, val2)
		return val1.send(op, val2)
	end
	##
	# Convert text to a list of values and operators
	#
	def textToList(expression)
		eles = expression.scan(/((\d+)|(\D))/)
		elements = []
		for e in eles
			elements += [e[0]]
		end
		return elements
	end
	##
	# Convert infix expression to postfix
	#
	def infixToPostfix(elements)
		postfix = StackGe.new
		opStack = StackGe.new
		opStackSize = 0
		for symb in elements
			if symb == '('
				opStackSize = opStack.size
			elsif symb == ')'
				while not opStack.isEmpty? and opStack.size > opStackSize
					postfix.push opStack.pop
				end
				opStackSize = 0
			elsif not isOperator symb
				postfix.push symb
			else
				while not opStack.isEmpty? and hasPrecedence(opStack.top, symb) and opStack.size > opStackSize
					postfix.push opStack.pop
				end
				opStack.push symb
			end
		end
		while not opStack.isEmpty?
			postfix.push opStack.pop
		end
		return postfix.toList
	end
	##
	# Calculates postfix expression
	#
	def calcPostfix(elements)
		result = StackGe.new
		for symb in elements
			if not isOperator symb
				result.push symb
			else
				opnd2 = result.pop
				opnd1 = result.pop
				valor = operation(symb, opnd1.to_f, opnd2.to_f)
				result.push(valor)
			end
		end
		return result.toList[0]
	end
end