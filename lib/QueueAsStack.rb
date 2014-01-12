##
# Creates a stack that internally is a queue
#
class QueueAsStack
	##
	# Stack initializer
	#
	# @param [Integer] capacity The Capacity of the stack
	def initialize(capacity = 10)
		@queue = QueueGe.new(capacity)
	end
	##
	# Check if stack is empty
	#
	# @return [Boolean] true if empty false if not empty
	def isEmpty?
		return @queue.isEmpty?()
	end
	##
	# Check if stack capacity is full
	#
	# @return [true, false] true if full false if not Full
	def isFull?
		return @queue.isFull?()
	end
	##
	# Get the stack size
	#
	# @return [Integer] Size of stack
	def size
		return @queue.size()
	end
	##
	# Get the top element on stack
	#
	# @return [Object] the element
	def top
		return @array[@pos]
	end
	##
	# Insert a element on top of the stack
	#
	# @param [Object] item Element to insert
	def push(item)
		@queue.enqueue(item)
	end
	##
	# Remove and returns the element on top of the stack
	#
	# @return [Object] the top element of the stack
	def pop
		if @queue.size() == 0
			raise "StackUnderow"
		end
		tempQueue = QueueGe.new() # used to store queue itens while iterating
		lastPosition = @queue.size()-1
		for i in 1..lastPosition do
			tempQueue.enqueue(@queue.dequeue())
		end
		item = @queue.dequeue()
		for i in 1..lastPosition do
			@queue.enqueue(tempQueue.dequeue())
		end
		return item
	end
	##
	# Clear the stack making it empty
	#
	def clear
		@queue.clear()
	end
	##
	# Print the stack contents
	#
	def print
		@queue.print()
	end
	##
	# Get a array of stack elements
	#
	# @return [Array] Array of stack elements
	def toList
		return @queue.toList()
	end
end