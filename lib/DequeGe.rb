##
# A Deque linked list node
#
class DequeNode < Struct.new :element, :nextNode, :prevNode
end
##
# A Deque data structure
#
class DequeGe
	##
	# Queue initializer
	#
	# @param [Integer] capacity The Capacity of the deque
	def initialize(capacity = 10)
		@capacity = capacity
		clear()
	end
	##
	# Check if deque is empty
	#
	# @return [Boolean] true if empty false if not empty
	def isEmpty?
		return @size == 0
	end
	##
	# Check if deque capacity is full
	#
	# @return [true, false] true if full false if not Full
	def isFull?
		return @size == @capacity
	end
	##
	# Get the deque size
	#
	# @return [Integer] Size of deque
	def size
		return @size
	end
	##
	# Get the first element on deque
	#
	# @return [Object] the first element
	def front 
		return @front.element
	end
	##
	# Get the last element on deque
	#
	# @return [Object] the last element
	def back
		return @back.element
	end
	##
	# Insert a element in end of the deque
	#
	# @param [Object] item Element to insert
	def pushBack(item)
		if self.isFull?
			raise "DequeOverow"
		end
		node = DequeNode.new(item, nil, @back)
		if(@back)
			@back.nextNode = node
		end
		@back = node
		@size += 1
		if size < 2
			@front = @back
		end
	end
	##
	# Insert a element in front of the deque
	#
	# @param [Object] element Element to insert
	def pushFront(element)
		if self.isFull?
			raise "DequeOverow"
		end
		node = DequeNode.new(element, @front)
		if(@front)
			@front.prevNode = node
		end
		@front = node
		@size += 1
		if size < 2
			@back = @front
		end
	end
	##
	# Remove and returns the last element of the deque
	#
	# @return [Object] the last element of the deque
	def popBack
		if @size == 0
			raise "DequeUnderow"
		end
		node = @back
		node.prevNode.nextNode = nil
		@back = node.prevNode
		@size -= 1
		if size < 2
			@front = @back
		end
		return node.element
	end
	##
	# Remove and returns the first element of the deque
	#
	# @return [Object] the first element of the deque
	def popFront
		if @size == 0
			raise "DequeUnderow"
		end
		node = @front
		@front = node.nextNode
		@size -= 1
		if size < 2
			@back = @front
		end
		return node.element
	end
	##
	# Clear the deque making it empty
	#
	def clear
		@front = nil
		@back = nil
		@size = 0
	end
	##
	# Print the deque contents
	#
	def print
		node = @front
		while node do
			puts node.element
			node = node.nextNode
		end
	end
	##
	# Get a array of deque elements
	#
	# @return [Array] Array of deque elements
	def toList
		list = []
		node = @front
		while node do
			list << node.element
			node = node.nextNode
		end
		return list
	end
end