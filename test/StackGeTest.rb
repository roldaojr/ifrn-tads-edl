require 'test/unit'
require '../lib/StackGe.rb'

class StackGeTest < Test::Unit::TestCase
	def test_push
		paises = StackGe.new(5)
		paises.push("Paraguai")
		paises.push("Brasil")
		assert_equal paises.size(), 2
		assert_equal paises.toList(), ["Paraguai", "Brasil"]
	end
	def test_push_pop
		paises = StackGe.new(5)
		paises.push("Argentina")
		paises.push("Paraguai")
		paises.push("Chile")
		paises.push("Brasil")
		paises.pop()
		pais = paises.pop()
		assert_equal paises.size(), 2
		assert_equal paises.toList(), ["Argentina", "Paraguai"]
		assert_equal pais, "Chile"
	end
	def test_empty
		paises = StackGe.new(5)
		paises.push("Chile")
		paises.push("Brasil")
		paises.push("Equador")
		paises.clear()
		assert_equal paises.isEmpty?(), true
	end
	def test_full
		paises = StackGe.new(3)
		paises.push("Argentina")
		paises.push("Paraguai")
		paises.push("Chile")
		assert_equal paises.isFull?(), true
	end
	def test_top
		paises = StackGe.new(5)
		paises.push("Argentina")
		paises.push("Paraguai")
		paises.push("Chile")
		assert_equal paises.top(), "Chile"
	end
end