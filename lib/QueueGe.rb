##
# A Queue data structure
class QueueGe
	##
	# Queue initializer
	#
	# @params [Integer] Capacity of the queue
	def initialize(*args)
		if args[0]
			@capacity = args[0]
		else
			@capacity = 10
		end
		clear()
	end
	##
	# Check if queue is empty
	#
	# @return [Boolean] true if empty false if not empty
	def isEmpty?
		return @size == 0
	end
	##
	# Check if queue capacity is full
	#
	# @return [true, false] true if full false if not Full
	def isFull?
		return @size == @capacity
	end
	##
	# Get the queue size
	#
	# @return [Integer] size of queue
	def size
		return @endPos-startPos
	end
	##
	# Get the first element on queue
	#
	# @return [Object] the element
	def front 
		return @array[@startPos]
	end
	##
	# Get the last element on queue
	#
	# @return [Object] the element
	def back
		return @array[@endPos-1]
	end
	##
	# Insert a element in end of the queue
	#
	# @params [Object] item to insert
	def push(item)
		if @endPos-@startPos > @capacity-1
			doubleArray()
		end
		@array[@endPos % @capacity] = item
		@endPos += 1
		puts "push: PF " + @endPos.to_s + " PI " + @startPos.to_s + " C " + @capacity.to_s
	end
	##
	# Remove and returns the first element of the queue
	#
	# @return [Object] the first item of the queue
	def pop
		if @endPos == @startPos
			throw "QueueUnderow"
		end
		item = @array[@startPos % @capacity]
		@startPos += 1
		puts "pop: PF " + @endPos.to_s + " PI " + @startPos.to_s
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
		@size = 0
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
	private
	##
	# double the array capacity
	#
	def doubleArray
		@capacity = @capacity * 2
	end	
end

e = QueueGe.new(5)
e.push("a")
e.push("b")
e.push("c")
e.push("d")
e.push("e")

e.pop()
e.pop()
e.push("f")
e.push("g")
e.pop()
e.pop()
e.print()