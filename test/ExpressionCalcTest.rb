require 'test/unit'
require '../lib/ExpressionCalc'

class ExpressionCalcTest < Test::Unit::TestCase
	def test_calc
		calc = ExpressionCalc.new
		assert_equal calc.calculate('3+6*2'), 15.0
		assert_equal calc.calculate('3*6+2'), 20.0
		assert_equal calc.calculate('3*(6+2)'), 24.0
		assert_equal calc.calculate('(3+6)*2'), 18.0
		assert_equal calc.calculate('(3+6)*2*(1+1)'), 36.0
	end
end