tool
extends Node2D

var Hex = preload("res://Hexagon.tscn")

export(int, 1, 9000) var hexSize = 50 setget set_grid_size
export(int, 1, 100) var gridHeight = 1 setget set_grid_height
export(int, 1, 100) var gridWidth = 1 setget set_grid_width
export(bool) var squareOff = false setget set_squareOff
export(bool) var squareOffVertical = false setget set_squareOffVertical

var offset : Vector2 = Vector2(hexSize, hexSize * sin(PI/3))

var hexagons : Array

var hexagonMap : Dictionary

func set_grid_size(input):
	hexSize = input
	updateOffset()
	Update()

func set_grid_height(input):
	gridHeight = input
	clearGrid()
	generateGrid()

func set_grid_width(input):
	gridWidth = input
	clearGrid()
	generateGrid()

func set_squareOff(input):
	squareOff = input
	updateOffset()
	clearGrid()
	generateGrid()

func set_squareOffVertical(input):
	squareOffVertical = input
	updateOffset()
	clearGrid()
	generateGrid()

func updateOffset():
	if squareOffVertical == true:
		offset.x = hexSize /.2
	else:
		offset.x = hexSize
		
	if squareOff == true:
		offset.y = 0
	else:
		offset.y = hexSize * sin(PI/3)
	
	print(offset)

func Update():
	for child in $".".get_children():
		child.hexSize = hexSize
		child.updatePosition(offset)

func clearGrid():
	if not hexagons.empty():
		hexagons.clear()
	if not hexagonMap.empty():
		hexagonMap.clear()
	for child in $".".get_children():
		$".".remove_child(child)

func generateGrid():
	createBase()
	if squareOff:
		createHorizontalSquare()
	if squareOffVertical:
		createVerticalSquare()

func createBase():
	for row in range(0, gridHeight):
		for col in range(0, gridWidth):
			addHex(col, row, "Full")
			
#adds the necessary hexagons and changes some to 1/2 hexagons
func createHorizontalSquare():
	var temphex = Hex.instance()
	for col in range(0, gridWidth/2 + gridWidth % 2):
		#update top hexagons
		var pos = temphex.calculateAxialCoordinate(col * 2, 0)
		hexagonMap[pos].hexType = "Half Bottom"
		#create and add bottom hexagons
		addHex(col * 2, gridHeight, "Half Top" )

func createVerticalSquare():
	pass

func addHex(col : int, row : int, type : String):
	var hex = Hex.instance()
	hex.hexType = type
	hex.hexSize = hexSize
	hex.offsetToCube(col, row)
	var cubePos = hex.calculateAxialCoordinate(col, row)
	hex.updatePosition(offset)
	hexagonMap[cubePos] = hex
	$".".add_child(hex)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

