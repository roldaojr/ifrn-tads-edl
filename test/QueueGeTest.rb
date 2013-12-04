require 'test/unit'
require '../lib/QueueGe.rb'

class QueueGeTest < Test::Unit::TestCase
	def test_push
		paises = QueueGe.new(5)
		paises.push("Paraguai")
		paises.push("Brasil")
		assert_equal paises.size(), 2
		assert_equal paises.toList(), ["Paraguai", "Brasil"]
	end
	def test_push_pop
		paises = QueueGe.new(5)
		paises.push("Argentina")
		paises.push("Paraguai")
		paises.push("Chile")
		paises.push("Brasil")
		paises.pop()
		paises.pop()
		assert_equal paises.size(), 2
		assert_equal paises.toList(), ["Chile", "Brasil"]
	end
	def test_doubleCapacity
		paises = QueueGe.new(3)
		paises.push("Argentina")
		paises.push("Paraguai")
		paises.push("Chile")
		paises.push("Brasil")
		paises.push("Equador")
		paises.push("Uruguai")
		paises.push("Bolivia")
		assert_equal paises.size(), 7
	end
	def test_empty
		paises = QueueGe.new(5)
		paises.push("Chile")
		paises.push("Brasil")
		paises.push("Equador")
		paises.clear()
		assert_equal paises.isEmpty?(), true
	end
	def test_full
		paises = QueueGe.new(3)
		paises.push("Argentina")
		paises.push("Paraguai")
		paises.push("Chile")
		assert_equal paises.isFull?(), true
	end
end