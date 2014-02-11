HeapNode.prototype = {
	shape: null,
	text: null,
	draw: function(stage) {
		this.stage = stage
		this.shape = new createjs.Shape()
		this.shape.graphics.beginStroke("black").beginFill("white").drawCircle(0, 0, 20)
		this.shape.x = this.x
		this.shape.y = this.y
		this.stage.addChildAt(this.shape, 1)
		this.text = new createjs.Text(this.key, "16px Arial", "#000")
		this.text.maxWidth = 40
		this.text.textAlign = "center"
		this.text.x = this.x
		this.text.y = this.y-10
		this.stage.addChild(this.text)
	},
	remove: function() {
		this.stage.removeChild(this.shape)
	},
	selected: false,
	select: function() {
		this.shape.graphics.beginStroke("white").beginFill("white").drawCircle(0, 0, 20)
		this.shape.graphics.beginStroke("black").beginFill("yellow").drawCircle(0, 0, 20)
		this.stage.update()
		this.selected = true
	},
	unselect: function() {
		this.shape.graphics.beginFill("white").drawCircle(0, 0, 20)
		this.stage.update()
		this.selected = false
	}
}
HeapMinMax.prototype.animQueue = []
HeapMinMax.prototype.GUI = function(elementId) {
	this.stage = new createjs.Stage(document.getElementById(elementId));
	createjs.Ticker.setFPS(30)
	createjs.Ticker.addEventListener("tick", this.stage);
	this.lines = new createjs.Shape()
	this.stage.addChild(this.lines)
	this.swaps = []
}
HeapMinMax.prototype.draw = function() {
	for(var i = 0; i < this.elements.length; i++) {
		pos = this.getPositionXY(i+1)
		this.elements[i].x = pos.x + 20
		this.elements[i].y = pos.y + 20
		this.elements[i].draw(this.stage)
		// draw index text
		txt = new createjs.Text(i+1, "16px Arial", "#000")
		txt.maxWidth = 40
		txt.textAlign = "center"
		txt.x = x + 20
		txt.y = y + 42
		this.stage.addChild(txt)
	}
	this.drawLines()
	this.stage.update()
}
HeapMinMax.prototype.getPositionXY = function(i) {
	levelTotal = Math.floor(Math.log(this.capacity) / Math.LN2) + 1
	level = Math.floor(Math.log(i) / Math.LN2)+1
	offset = i - Math.pow(2, level-1) + 1
	y = 80*(level-1)
	space = (Math.pow(2, levelTotal-level)-1)*40
	x = space + (80 + 2*space)*(offset-1)
	return {x: x, y: y}
}
HeapMinMax.prototype.drawLines = function() {
	g = this.lines.graphics
	g.clear()
	g.setStrokeStyle(1).beginStroke("black")
	for(var i = 2; i <= this.elements.length; i++) {
		pos = this.getPositionXY(i)
		g.moveTo(pos.x+20, pos.y+20)
		pos = this.getPositionXY(Math.floor(i/2))
		g.lineTo(pos.x+20, pos.y+20)
	}
}
HeapMinMax.prototype.toggleSelect = function(i) {
	console.log(this.elements[0].key)
	if(this.elements[i-1].selected) {
		this.elements[i-1].unselect()
	} else {
		this.elements[i-1].select()
	}
}
HeapMinMax.prototype.swapAnim = function(i, j) {
	heap = this
	console.log("defer swapAnim", i, j, this.elements[i-1].key, this.elements[j-1].key)
	this.animQueue.push(function() {
		node1 = this.__beforeSwaps[i-1]
		node2 = this.__beforeSwaps[j-1]
		ele1 = node1.text
		ele2 = node2.text
		duration = 2000
		createjs.Tween.get(ele1)
			//.call(function(){ node1.select(); })
			.to({y: ele2.y}, duration/2)
			.to({x: ele2.x}, duration/2)
			//.call(function(){ node1.unselect(); })
		createjs.Tween.get(ele2)
			//.call(function(){ node2.select(); })
			.to({y: ele1.y}, duration/2)
			.to({x: ele1.x}, duration/2)
			//.call(function(){ node2.unselect(); })
			.call(function(){
				heap.__beforeSwaps[i-1] = node2
				heap.__beforeSwaps[j-1] = node1
				if(heap.animQueue.length > 0) {
					func = heap.animQueue.shift()
					func.apply(heap, [])
				}
			})
	})
	node1 = null
	node2 = null
}
HeapMinMax.prototype.deleteLastNode = function() {
	this.animQueue.push(function() {
		this.stage.removeChild(this.elements[this.elements.length-1].text)
		delete this.elements[this.elements.length-1]
	})
}
HeapMinMax.prototype.__oldSwap = HeapMinMax.prototype.swap
HeapMinMax.prototype.swap = function(i, j) {
	if(!this.__beforeSwaps) this.__beforeSwaps = this.elements.slice(0);
	this.__oldSwap(i, j)
	this.swapAnim(i, j)
}
HeapMinMax.prototype.animate = function() {
	this.animQueue.push(this.onEndAnimation)
	func = this.animQueue.shift()
	func.apply(this, [])
}
HeapMinMax.prototype.onEndAnimation = function() {
	//console.log(this.animQueue)
}