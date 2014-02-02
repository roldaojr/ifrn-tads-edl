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
		infix = _textToList(expression)
		postfix = _infixToPostfix(infix)
		return _calcPostfix(postfix)
	end

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

	def _textToList(expression)
		eles = expression.scan(/((\d+)|(\D))/)
		elements = []
		for e in eles
			elements += [e[0]]
		end
		return elements
	end

	def _infixToPostfix(elements)
		postfix = StackGe.new
		opStack = StackGe.new
		for symb in elements
			if not isOperator symb
				postfix.push symb
			else
				while not opStack.isEmpty? and hasPrecedence(opStack.top, symb)
					postfix.push opStack.pop
				end
				opStack.push symb
			end
		end
		while not opStack.isEmpty?
			topSymb = opStack.pop
			postfix.push topSymb
		end
		return postfix.toList
	end

	def _calcPostfix(elements)
		queue = QueueGe.new
		result = StackGe.new
		queue.fromList(elements)
		while not queue.isEmpty?
			symb = queue.dequeue
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