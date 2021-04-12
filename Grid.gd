tool
extends Node2D

var Hex = preload("res://Hexagon.tscn")

export(int, 1, 9000) var hexSize = 50 setget set_grid_size
export(int, 1, 100) var gridHeight = 1 setget set_grid_height
export(int, 1, 100) var gridWidth = 1 setget set_grid_width
export(bool) var squareOff = false setget set_squareoff

var currentGridHeight : int = 1 
var currentGridWidth : int = 1

var hexagons : Array

func set_grid_size(input):
	hexSize = input
	for hex in hexagons:
		hex.hexSize = hexSize
		hex.updatePosition()

func set_grid_height(input):
	gridHeight = input
	clearGrid()
	generateGrid()

func set_grid_width(input):
	gridWidth = input
	clearGrid()
	generateGrid()

func set_squareoff(input):
	squareOff = input
	clearGrid()
	generateGrid()

func clearGrid():
	if not hexagons.empty():
		hexagons.clear()
	for child in $".".get_children():
		$".".remove_child(child)

func generateGrid():
	if squareOff:
		generateSquareGrid()
	else:
		generateRegularGrid()

func generateRegularGrid():
	#creates initial hexes
	var numberOfHexs = gridHeight * gridWidth
	createHexes(numberOfHexs)
	calculateCoordinates()

func generateSquareGrid():
	var numberOfHexs = gridHeight * gridWidth + gridWidth/2 + gridWidth % 2
	createHexes(numberOfHexs)
	squareOff()
	calculateCoordinates()
	squareOffCoordinates()

func createHexes(numberOfHexs : int):
	for _i in range(0, numberOfHexs):
		var newHex = Hex.instance()
		newHex.hexType = "Full"
		newHex.hexSize = hexSize
		hexagons.append(newHex)
		$".".add_child(newHex)

func calculateCoordinates():
	#sets grid coordinates
	for row in range(0, gridHeight):
		for col in range(0, gridWidth):
			var pos = col + row*(gridWidth)
			hexagons[pos].offsetToCube(col, row)
			hexagons[pos].updatePosition()
			#hexagons[pos].debug()

func squareOffCoordinates():
	for _i in range(0, gridWidth/2 + gridWidth % 2):
		var pos = gridHeight * gridWidth + _i
		hexagons[pos].offsetToCube(_i * 2, gridWidth-2)
		hexagons[pos].updatePosition()
		hexagons[pos].hexType = "Half Top"
		print(pos)

func squareOff():
	var col = 0
	while col < gridWidth:
		hexagons[col].hexType = "Half Bottom"
		col = col + 2


"""
func calculateHalfHex() -> int:
	var halfHexes = 0
	if squareOff:
		if gridWidth % 2 == 1:
			halfHexes = gridWidth - 1
		else:
			halfHexes = gridWidth
	return halfHexes 
"""


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

