require 'test/unit'
require '../lib/DequeGe.rb'

class DeeueGeTest < Test::Unit::TestCase
	def test_pushPopFront
		paises = DequeGe.new(5)
		paises.pushFront("Paraguai")
		paises.pushFront("Brasil")
		paises.pushFront("Venezuela")
		paises.popFront()
		assert_equal paises.size(), 2
		assert_equal paises.toList(), ["Brasil", "Paraguai"]
	end
	def test_pushPopBack
		paises = DequeGe.new(5)
		paises.pushBack("Argentina")
		paises.pushBack("Paraguai")
		paises.pushBack("Chile")
		paises.pushBack("Brasil")
		paises.popBack()
		paises.popBack()
		assert_equal paises.size(), 2
		assert_equal paises.toList(), ["Argentina", "Paraguai"]
	end
	def test_pushFrontPopBack
		paises = DequeGe.new(5)
		paises.pushFront("Argentina")
		paises.pushFront("Paraguai")
		paises.pushFront("Chile")
		paises.pushFront("Brasil")
		paises.popBack()
		paises.popBack()
		assert_equal paises.size(), 2
		assert_equal paises.toList(), ["Brasil", "Chile"]
	end
	def test_empty
		paises = DequeGe.new(5)
		paises.pushBack("Chile")
		paises.pushBack("Brasil")
		paises.pushBack("Equador")
		paises.clear()
		assert_equal paises.isEmpty?(), true
	end
	def test_full
		paises = DequeGe.new(3)
		paises.pushBack("Argentina")
		paises.pushBack("Paraguai")
		paises.pushBack("Chile")
		assert_equal paises.isFull?(), true
	end
end