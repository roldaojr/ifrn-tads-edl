require 'test/unit'
require '../lib/QueueGe.rb'

class QueueGeTest < Test::Unit::TestCase
	def test_enqueue
		paises = QueueGe.new(5)
		paises.enqueue("Paraguai")
		paises.enqueue("Brasil")
		assert_equal paises.size(), 2
		assert_equal paises.toList(), ["Paraguai", "Brasil"]
	end
	def test_enqueue_dequeue
		paises = QueueGe.new(5)
		paises.enqueue("Argentina")
		paises.enqueue("Paraguai")
		paises.enqueue("Chile")
		paises.enqueue("Brasil")
		paises.dequeue()
		paises.dequeue()
		assert_equal paises.size(), 2
		assert_equal paises.toList(), ["Chile", "Brasil"]
	end
	def test_doubleCapacity
		paises = QueueGe.new(3)
		paises.enqueue("Argentina")
		paises.enqueue("Paraguai")
		paises.enqueue("Chile")
		paises.enqueue("Brasil")
		paises.enqueue("Equador")
		paises.enqueue("Uruguai")
		paises.enqueue("Bolivia")
		assert_equal paises.size(), 7
	end
	def test_empty
		paises = QueueGe.new(5)
		paises.enqueue("Chile")
		paises.enqueue("Brasil")
		paises.enqueue("Equador")
		paises.clear()
		assert_equal paises.isEmpty?(), true
	end
	def test_full
		paises = QueueGe.new(3)
		paises.enqueue("Argentina")
		paises.enqueue("Paraguai")
		paises.enqueue("Chile")
		assert_equal paises.isFull?(), true
	end
end