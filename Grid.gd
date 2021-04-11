tool
extends Node2D

var Hex = preload("res://Hexagon.tscn")

export(int, 1, 9000) var hexSize = 50
export(int, 1, 100) var gridHeight = 1 
export(int, 1, 100) var gridWidth = 1
export(bool) var squareOff = false

var currentGridHeight : int = 1 
var currentGridWidth : int = 1

var hexagons : Array

func clearGrid():
	if not hexagons.empty():
		hexagons.clear()
	for child in $"collection".get_children():
		$"collection".remove_child(child)

func generateGrid():
	#creates initial hexs
	var numberOfHexs = gridHeight * gridWidth
	print(numberOfHexs)
	for _i in range(0, numberOfHexs):
		var newHex = Hex.instance()
		newHex.hexSize = hexSize
		hexagons.append(newHex)
		$"collection".add_child(newHex)
	
	#sets grid coordinates
	for row in range(0, gridHeight):
		for col in range(0, gridWidth):
			var pos = col + row*(gridWidth)
			hexagons[pos].offsetToCube(col, row)
			hexagons[pos].updatePosition()
			hexagons[pos].debug()
			#print(col, " ", row, " : ", hexagons[pos].q(), " ", hexagons[pos].r(), " ", hexagons[pos].s(), ": ", hexagons[pos].total() )
	"""
	#sets actual position of grid
	for hex in hexagons:
		hex.updatePosition()
		#hex.debug()
	"""

func _process(_delta):
	if currentGridHeight != gridHeight or currentGridWidth != gridWidth:
		clearGrid()
		generateGrid()
		currentGridHeight = gridHeight
		currentGridWidth = gridWidth


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

