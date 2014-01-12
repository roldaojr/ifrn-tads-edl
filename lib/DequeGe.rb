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
		return @endPos-@startPos == 0
	end
	##
	# Check if deque capacity is full
	#
	# @return [true, false] true if full false if not Full
	def isFull?
		return @endPos-@startPos == @capacity
	end
	##
	# Get the deque size
	#
	# @return [Integer] Size of deque
	def size
		return @endPos-@startPos
	end
	##
	# Get the first element on deque
	#
	# @return [Object] the first element
	def front 
		return @array[@startPos]
	end
	##
	# Get the last element on deque
	#
	# @return [Object] the last element
	def back
		return @array[@endPos-1]
	end
	##
	# Insert a element in end of the deque
	#
	# @param [Object] item Element to insert
	def pushBack(item)
		if @endPos-@startPos > @capacity-1
			doubleArray()
		end
		@startPos -= 1
		@array[@startPos] = item
	end
	##
	# Insert a element in front of the deque
	#
	# @param [Object] item Element to insert
	def pushFront(item)
		if @endPos-@startPos > @capacity-1
			doubleArray()
		end
		@array[@endPos % @capacity] = item
		@endPos += 1
	end
	##
	# Remove and returns the last element of the deque
	#
	# @return [Object] the last element of the deque
	def popBack
		if @endPos == @startPos
			raise "QueueUnderow"
		end
		item = @array[@endPos]
		@endPos -= 1
		# zerar ponteiros
		if @endPos == @startPos
			@startPos = 0
			@endPos = 0
		end
		return item
	end
	##
	# Remove and returns the first element of the deque
	#
	# @return [Object] the first element of the deque
	def popFront
		if @endPos == @startPos
			raise "QueueUnderow"
		end
		item = @array[@startPos % @capacity]
		@startPos += 1
		# zerar ponteiros
		if @endPos == @startPos
			@startPos = 0
			@endPos = 0
		end
		return item
	end
	##
	# Clear the deque making it empty
	#
	def clear
		@array = Array.new(@capacity)
		@startPos = 0
		@endPos = 0
	end
	##
	# Print the deque contents
	#
	def print
		for i in @startPos..@endPos-1
			if i >= @capacity
				puts @array[i % @capacity]
			else
				puts @array[i]
			end
		end
	end
	##
	# Get a array of deque elements
	#
	# @return [Array] Array of deque elements
	def toList
		list = []
		for i in @startPos..@endPos-1
			if i >= @capacity
				list << @array[i % @capacity]
			else
				list << @array[i]
			end
		end
		return list
	end

	private
	##
	# double the array capacity
	#
	def doubleArray
		@capacity = @capacity * 2
	end	
end