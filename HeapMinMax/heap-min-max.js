/**
 * Creates an instance of HeapNode
 *
 * @constructor
 * @param {object} Content of node
 * @param {number} Key of node
 */
HeapNode = function(key, content) {
	this.content = content
	this.key = key
}
/**
 * Creates an instance of HeapMinMax
 *
 * @constructor
 * @param {number} capacity The size of Heap structure
 */
HeapMinMax = function(capacity) {
	this.capacity = capacity
	this.makeClear()

	// compare two heap positions
	this.compare = function(i, j) {
		if(this.elements[i-1].key > this.elements[j-1].key) {
			return 1
		} else if(this.elements[i-1].key == this.elements[j-1].key) {
			return 0
		} else {
			return -1
		}
	}

	// return true if is level min
	this.isLevelMin = function(i) {
		return (Math.floor(Math.log(i) / Math.LN2)+1) % 2 == 1
	}

	// get minimum of child and grandchild
	this.minChildGrandchild = function(i){
		var min
		var left = i*2
		var right = i*2+1
		if(this.compare(left, right) < 0) {
			min = left
		} else {
			min = right
		}
		if(left*2 < this.elements.length && this.compare(left*2, min) < 0)
			min = left*2
		if(left*2+1 < this.elements.length && this.compare(left*2+1, min) < 0)
			min = left*2+1
		if(right*2 < this.elements.length && this.compare(right*2, min) < 0)
			min = left*2
		if(right*2+1 < this.elements.length && this.compare(right*2+1, min) < 0)
			min = left*2+1
		return min
	}

	// get maximum of child and grandchild
	this.maxChildGrandchild = function(i){
		var max
		var left = i*2
		var right = i*2+1
		if(this.compare(left, right) > 0) {
			max = left
		} else {
			max = right
		}
		if(left*2 < this.elements.length && this.compare(left*2, max) > 0) max = left*2
		if(left*2+1 < this.elements.length && this.compare(left*2+1, max) > 0) max = left*2+1
		if(right*2 < this.elements.length && this.compare(right*2, max) > 0) max = left*2
		if(right*2+1 < this.elements.length && this.compare(right*2+1, max) > 0) max = left*2+1
		return max
	}

	this.down = function(i) {
		if (this.isLevelMin(i)) {
			this.downMin(i)
		} else {
			this.downMax(i)
		}
	}

	this.downMin = function(i) {
		console.log("downMin", i)
		if(i*2 < this.elements.length) {
			m = this.minChildGrandchild(i)
			if(Math.floor(m/4) == i) {
				if(this.compare(m, i) < 0) {
					this.swap(m, i)
					p = Math.floor(m/2)
					if(this.compare(p, m) < 0) {
						this.swap(p, m)
					}
					this.downMin(m)
				}
			} else {
				if(this.compare(m, i) < 0) {
					this.swap(m, i)
				}
			}
		}
	}

	this.downMax = function(i) {
		console.log("downMax", i)
		if(i*2 < this.elements.length) {
			m = this.maxChildGrandchild(i)
			if(Math.floor(m/4) == i) {
				if(this.compare(m, i) > 0) {
					this.swap(m, i)
					p = Math.floor(m/2)
					if(this.compare(p, m) > 0) {
						this.swap(p, m)
					}
					this.downMax(m)
				}
			} else {
				if(this.compare(m, i) > 0) {
					this.swap(m, i)
				}
			}
		}
	}

	this.up = function(i) {
		p = Math.floor(i/2)
		if (this.isLevelMin(i)) {
			if(p >= 1 && this.compare(i, p) > 0) {
				this.swap(p, i)
				this.upMax(p)
			} else {
				this.upMin(i)
			}
		} else {
			if(p >= 1 && this.compare(i, p) < 0) {
				this.swap(p, i)
				this.upMin(p)
			} else {
				this.upMax(i)
			}
		}
	}

	this.upMin = function(i) {
		g = Math.floor(i/4)
		if(g > 0) {
			if(this.compare(i, g) < 0) {
				this.swap(i, g)
				this.upMin(i)
			}
		}
	}

	this.upMax = function(i) {
		g = Math.floor(i/4)
		if(g > 0) {
			if(this.compare(i, g) > 0) {
				this.swap(g, i)
				this.upMin(i)
			}
		}
	}
}
HeapMinMax.prototype = {
	swap: function(i, j) {
		aux = this.elements[i-1]
		this.elements[i-1] = this.elements[j-1]
		this.elements[j-1] = aux
	},

	deleteLastNode: function() {
		this.elements.splice(this.elements.length-1, 1)
	},

	/**
	 * Get the min element
	 *
	 * @return {number} The index of min element
	 */
	findMin: function() {
		return 1
	},
	/**
	 * Get the max element
	 *
	 * @return {number} The index of max element
	 */
	findMax: function() {
		if(this.compare(2, 3) > 0) {
			return 2
		} else {
			return 3
		}
	},
	/**
	 * Check if heap is empty
	 *
	 * @return {boolean} true if heap is empty, false otherwise
	 */
	isEmpty: function() {
		return this.elements.length == 0
	},
	/**
	 * Get the size of heap
	 *
	 * @return {number} The size of the heap
	 */
	size: function() {
		return this.elements.length
	},
	/**
	 * Insert a element into heap
	 *
	 * @param {Number} key Priority of object
	 * @param {Object} content Object to insert
	 */
	insert: function(key, content) {
		if(this.elements.length > this.capacity) {
			throw "Heap overflow"
		}
		this.elements.push(new HeapNode(key, content))
		this.up(this.elements.length-1)
	},
	/**
	 * Remove min element from heap
	 *
	 * @return {object} The min element
	 */
	deleteMin: function() {
		if(this.elements.length < 1) {
			throw "Heap underflow"
		}
		min = this.elements[0]
		this.swap(1, this.elements.length)
		this.down(1)
		this.deleteLastNode()
		return min
	},
	/**
	 * Remove min element max heap
	 *
	 * @return {object} The max element
	 */
	deleteMax: function() {
		if(this.compare(2, 3) > 0) {
			maxIdx = 2
		} else {
			maxIdex = 3
		}
		max = this.elements[maxIdx]
		this.swap(maxIdx, this.elements.length)
		this.down(maxIdx)
		this.deleteLastNode()
		return max
	},
	/**
	 * Delete ao nodes from heap
	 */
	makeClear: function() {
		this.size = 0
		this.elements = []
	},
	/**
	 * Convert heap to array of HeapNode
	 * @return {array} Array of heap elements
	 */
	toArray: function() {
		return this.elements
	},
}