require 'test/unit'
require '../lib/ExpressionCalc'

class ExpressionCalcTest < Test::Unit::TestCase
	def test_textToList
		calc = ExpressionCalc.new
		assert_equal calc._textToList('3+6*2'), ['3', '+', '6', '*', '2']
		assert_equal calc._textToList('3*6+2'), ['3', '*', '6', '+', '2']
	end
	def test_infixToPostfix
		calc = ExpressionCalc.new
		assert_equal calc._infixToPostfix(['3', '+', '6', '*', '2']), ['3', '6', '2', '*', '+']
		assert_equal calc._infixToPostfix(['3', '*', '6', '+', '2']), ['3', '6', '*', '2', '+']
	end
	def test_calcPostfix
		calc = ExpressionCalc.new
		assert_equal calc._calcPostfix(['3', '6', '2', '*', '+']), 15.0
		assert_equal calc._calcPostfix(['3', '6', '*', '2', '+']), 20.0
	end
	def test_calc
		calc = ExpressionCalc.new
		assert_equal calc.calcExp('3+6*2'), 15.0
		assert_equal calc.calcExp('3*6+2'), 20.0
	end
end