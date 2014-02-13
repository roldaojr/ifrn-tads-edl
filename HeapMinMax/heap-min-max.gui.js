HeapMinMaxGui = function(capacity, elementId) {
	HeapMinMax.prototype.constructor.call(this, capacity)
	this.makeClear()
	var HeapCircleSize = 40
	this.stage = new createjs.Stage(document.getElementById(elementId));
	this.capacity = capacity
	this.animQueue = []
	this.lines = new createjs.Shape()
	this.stage.addChild(this.lines)
	this.textElements = []
	this.circleElements = []
	levelTotal = Math.floor(Math.log(this.capacity) / Math.LN2) + 1
	width = Math.pow(2, levelTotal-1)*HeapCircleSize*2
	height = 2*HeapCircleSize*(levelTotal)
	document.getElementById(elementId).setAttribute("width", width)
	document.getElementById(elementId).setAttribute("height", height)

	this.getPositionXY = function(i) {
		levelTotal = Math.floor(Math.log(this.capacity) / Math.LN2) + 1
		level = Math.floor(Math.log(i) / Math.LN2)+1
		offset = i - Math.pow(2, level-1) + 1
		y = 2*HeapCircleSize*(level-1)
		space = (Math.pow(2, levelTotal-level)-1)*HeapCircleSize
		x = space + (2*HeapCircleSize + 2*space)*(offset-1)
		return {x: x, y: y}
	}

	this.drawLine = function(i) {
		if(Math.floor(i/2) < 1) return
		g = this.lines.graphics
		g.setStrokeStyle(1).beginStroke("black")
		pos = this.getPositionXY(i)
		g.moveTo(pos.x+20, pos.y+20)
		pos = this.getPositionXY(Math.floor(i/2))
		g.lineTo(pos.x+20, pos.y+20)
	}
	this.drawCircle = function(i) {
		pos = this.getPositionXY(i)
		s = new createjs.Shape()
		s.x = pos.x+20
		s.y = pos.y+20
		s.graphics.beginStroke("black").beginFill("white").drawCircle(0, 0, 20)
		this.stage.addChildAt(s, 1)
		this.circleElements[i-1] = s
	}
	// draw index text
	this.drawText = function(t, x, y) {
		txt = new createjs.Text(t, "16px Arial", "#000")
		txt.maxWidth = 40
		txt.textAlign = "center"
		txt.x = x
		txt.y = y
		this.stage.addChild(txt)
		return txt
	}
	this.selectNode = function(i) {
		s = this.circleElements[i-1].graphics
		s.beginStroke("white").beginFill("white").drawCircle(0, 0, 20)
		s.beginStroke("black").beginFill("yellow").drawCircle(0, 0, 20)
		this.stage.update()
	},
	this.unselectNode = function(i) {
		s = this.circleElements[i-1].graphics
		s.beginFill("white").drawCircle(0, 0, 20)
		this.stage.update()
	}
	this.swapAnimate = function(i, j) {
		heap = this
		console.log("swap animate", i, j)
		this.animQueue.push(function() {
			ele1 = this.textElements[i]
			ele2 = this.textElements[j]
			console.log("anim", ele1)
			duration = 2000
			createjs.Tween.get(ele1, {override:true})
				.call(function(){ heap.selectNode(i); })
				.to({y: ele2.y}, duration/2)
				.to({x: ele2.x}, duration/2)
				.call(function(){ heap.unselectNode(i); })
			createjs.Tween.get(ele2, {override:true})
				.call(function(){ heap.selectNode(j); })
				.to({y: ele1.y}, duration/2)
				.to({x: ele1.x}, duration/2)
				.call(function(){ heap.unselectNode(j); })
				.call(function(){
					heap.textElements[i] = ele2
					heap.textElements[j] = ele1 
					if(heap.animQueue.length > 0) {
						func = heap.animQueue.shift()
						func.apply(heap, [])
					}
				})
		})
		//node1 = null
		//node2 = null
	}
}
HeapMinMaxGui.prototype = new HeapMinMax()

/**
 * Insert a element into heap
 *
 * @param {HeapNode} Element to insert
 */
HeapMinMaxGui.prototype.insert = function(key, content) {
	HeapMinMax.prototype.insert.call(this, key, content)
}

HeapMinMaxGui.prototype.swap = function(i, j) {
	HeapMinMax.prototype.swap.call(this, i, j)
	this.swapAnimate(i, j)
}

/**
 * Draw the Heap
 */
HeapMinMaxGui.prototype.draw = function() {
	for(var i = 1; i <= this.elements.length; i++) {
		pos = this.getPositionXY(i)
		this.drawLine(i)
		this.drawCircle(i)
		this.drawText(i, pos.x+20, pos.y+42)
		this.textElements[i] = this.drawText(this.elements[i-1].key, pos.x+20, pos.y+10)
	}
	this.stage.update()
}

HeapMinMaxGui.prototype.toggleSelect = function(i) {
	if(this.elements[i-1].selected) {
		this.unselectNode(i)
		this.elements[i-1].selected = false
	} else {
		this.selectNode(i)
		this.elements[i-1].selected = true
	}
}

HeapMinMaxGui.prototype.deleteLastNode = function() {
	this.animQueue.push(function() {
		HeapMinMax.prototype.deleteLastNode.call(this)
		this.stage.removeChild(this.textElements[this.textElements.length-1])
		this.textElements.splice(this.textElements.length-1, 1)
	})
}
HeapMinMaxGui.prototype.animate = function() {
	createjs.Ticker.setFPS(30)
	createjs.Ticker.addEventListener("tick", this.stage)
	this.animQueue.push(this.onEndAnimation)
	func = this.animQueue.shift()
	func.apply(this, [])
}
HeapMinMaxGui.prototype.onEndAnimation = function() {
	//console.log("end")
}