heap = [4, 70, 38, 20, 8, 35, 19, 30, 28, 18, 25, 36, 37, 26, 22]
console.log("HeapMinMax test")
console.log("Create HeapMinMax structure")
heapmm = new HeapMinMax(15)
heapmm.insert(26, 26)
heapmm.insert(4, 4)
heapmm.insert(70, 70)
heapmm.insert(20, 20)
heapmm.insert(8, 8)
heapmm.insert(35, 35)
heapmm.insert(30, 30)
heapmm.insert(28, 28)
heapmm.insert(19, 19)
heapmm.insert(18, 18)
heapmm.insert(25, 25)
heapmm.insert(36, 36)
heapmm.insert(37, 37)
heapmm.insert(38, 38)
heapmm.insert(22, 22)
console.log("Checking HeapMinMax structure")
for(var i = 1; i < heapmm.elements.length; i++) {
	if(heapmm.isLevelMin(i)) {
		console.log(i, "is level min")
		if(Math.floor(i/2) > 0) {
			console.log("Compare "+i+" == "+Math.floor(i/2), heapmm.compare(i, Math.floor(i/2)), -1)
		}
		if(Math.floor(i/4) > 0) {
			console.log("Compare "+i+" == "+Math.floor(i/4), heapmm.compare(i, Math.floor(i/4)), 1)
		}
	} else {
		console.log(i, "is level max")
		if(Math.floor(i/2) > 0) {
			console.log("Compare "+i+" == "+Math.floor(i/2), heapmm.compare(i, Math.floor(i/2)), 1)
		}
		if(Math.floor(i/4) > 0) {
			console.log("Compare "+i+" == "+Math.floor(i/4), heapmm.compare(i, Math.floor(i/4)), -1)
		}
	}
}