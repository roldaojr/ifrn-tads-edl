##
# A Stack data structure
#
class StackGe
	##
	# Stack initializer
	#
	# @param [Integer] capacity The Capacity of the stack
	def initialize(capacity = 10)
		@capacity = capacity
		clear()
	end
	##
	# Check if stack is empty
	#
	# @return [Boolean] true if empty false if not empty
	def isEmpty?
		return @pos == 0
	end
	##
	# Check if stack capacity is full
	#
	# @return [true, false] true if full false if not Full
	def isFull?
		return @pos == @capacity
	end
	##
	# Get the stack size
	#
	# @return [Integer] Size of stack
	def size
		return @pos
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
		if @pos >= @capacity
			raise "StackOverflow"
		end
		@array[@pos] = item
		@pos += 1
	end
	##
	# Remove and returns the element on top of the stack
	#
	# @return [Object] the top element of the stack
	def pop
		if @pos == 0
			raise "StackUnderow"
		end
		item = @array[@pos]
		@pos -= 1
		return item
	end
	##
	# Clear the stack making it empty
	#
	def clear
		@array = Array.new(@capacity)
		@pos = 0
	end
	##
	# Print the stack contents
	#
	def print
		for i in 0..@pos-1
			puts @array[i]
		end
	end
	##
	# Get a array of stack elements
	#
	# @return [Array] Array of stack elements
	def toList
		list = []
		for i in 0..@pos-1
			list << @array[i]
		end
		return list
	end
end