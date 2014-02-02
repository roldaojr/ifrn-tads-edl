require '../lib/QueueGe'

##
# A class to sort by distribution numbers
#
class SortByDist
	##
	# Sort a list of numbers
	#
	# @param [List] list List of numbers to sort
	# @param [int] maxDigits Maximum digits precision
	# @param [int] base Base of numbers
	# @return [List] Sorted list
	def sortList(aList, maxDigits=3, base=10)
		aQueue = QueueGe.new
		aQueue.fromList(aList)
		# create the queues
		@queues = []
		for k in 0..base-1
			@queues[k] = QueueGe.new
		end
		# One key at time loop
		for pos in 1..maxDigits
			# Iterates over all list keys
			while not aQueue.isEmpty?
				num = aQueue.dequeue
				k = (num % (base**pos)) / (base**(pos-1)) # get the number at pos
				@queues[k].enqueue(num)
			end
			for k in 0..base-1
				while not @queues[k].isEmpty?
					aQueue.enqueue @queues[k].dequeue
				end
			end
		end
		return aQueue.toList
	end
end