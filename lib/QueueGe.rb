##
# A Queue data structure
#
class QueueGe
	##
	# Queue initializer
	#
	# @param [Integer] capacity The Capacity of the queue
	def initialize(capacity = 10)
		@capacity = capacity
		clear()
	end
	##
	# Check if queue is empty
	#
	# @return [Boolean] true if empty false if not empty
	def isEmpty?
		return @endPos-@startPos == 0
	end
	##
	# Check if queue capacity is full
	#
	# @return [true, false] true if full false if not Full
	def isFull?
		return @endPos-@startPos == @capacity
	end
	##
	# Get the queue size
	#
	# @return [Integer] Size of queue
	def size
		return @endPos-@startPos
	end
	##
	# Get the first element on queue
	#
	# @return [Object] the first element
	def front 
		return @array[@startPos]
	end
	##
	# Get the last element on queue
	#
	# @return [Object] the last element
	def back
		return @array[@endPos-1]
	end
	##
	# Insert a element in end of the queue
	#
	# @param [Object] item Element to insert
	def enqueue(item)
		if @endPos-@startPos > @capacity-1
			doubleArray()
		end
		@array[@endPos % @capacity] = item
		@endPos += 1
	end
	##
	# Remove and returns the first element of the queue
	#
	# @return [Object] the first element of the queue
	def dequeue
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
	# Clear the queue making it empty
	#
	def clear
		@array = Array.new(@capacity)
		@startPos = 0
		@endPos = 0
	end
	##
	# Print the queue contents
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
	# Get a array of queue elements
	#
	# @return [Array] Array of queue elements
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

	def fromList(aList)
		@array = aList
		@startPos = 0
		@endPos = aList.count
		@capacity = @endPos
	end

	private
	##
	# double the array capacity
	#
	def doubleArray
		@capacity = @capacity * 2
	end	
end