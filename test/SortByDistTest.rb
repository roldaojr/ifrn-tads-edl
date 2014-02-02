require 'test/unit'
require '../lib/SortByDist'

class SortByDistTest < Test::Unit::TestCase
	def test_calc
		sorter = SortByDist.new
		assert_equal sorter.sortList([12, 3, 43, 01, 04, 38, 86, 10, 85, 100, 11, 7, 93, 13, 21], 3), [1, 3, 4, 7, 10, 11, 12, 13, 21, 38, 43, 85, 86, 93, 100]
	end
end