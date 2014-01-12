require 'test/unit'
require '../lib/QueueGe.rb'
require '../lib/QueueAsStack.rb'

class QueueAsStackTest < Test::Unit::TestCase
	def test_push
		paises = QueueAsStack.new(5)
		paises.push("Paraguai")
		paises.push("Brasil")
		assert_equal paises.size(), 2
		assert_equal paises.toList(), ["Paraguai", "Brasil"]
	end
	def test_push_pop
		paises = QueueAsStack.new(5)
		paises.push("Argentina")
		paises.push("Paraguai")
		paises.push("Chile")
		paises.push("Brasil")
		paises.pop()
		paises.pop()
		assert_equal paises.size(), 2
		assert_equal paises.toList(), ["Argentina", "Paraguai"]
	end
	def test_empty
		paises = QueueAsStack.new(5)
		paises.push("Chile")
		paises.push("Brasil")
		paises.push("Equador")
		paises.clear()
		assert_equal paises.isEmpty?(), true
	end
	def test_full
		paises = QueueAsStack.new(3)
		paises.push("Argentina")
		paises.push("Paraguai")
		paises.push("Chile")
		assert_equal paises.isFull?(), true
	end
end