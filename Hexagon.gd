tool
extends Node2D

export(int, 1, 9000) var hexSize = 40
var prevSize: int = 0

var hexHalf : bool = false
var disabled : bool = false

var _q : int = 0
var _r : int = 0
var _s : int = 0

func vertices( _size : int, center : Vector2 = Vector2(0,0) ) -> Array:
	var points : Array =[]
	for i in range(0,6):
		var angle_deg = 60 * i 
		var angle_rad = PI / 180 * angle_deg
		points.append(Vector2(center.x + _size * cos(angle_rad), \
							  center.y + _size * sin(angle_rad)))
	
	return points

func setCoordinate(q : int, r : int):
	_q = q
	_r = r
	_s = -q - r

func offsetToCube(col : int, row : int):
	_q = col 
	_r = row - (col - (col&1)) / 2
	_s = -_q - _r
	

func setVertices(vertices : Array):
	$"Line2D".clear_points()
	for point in vertices:
		$"Line2D".add_point(point)
	#add first point as last

	$"Line2D".add_point(vertices[0])
	#print($"Line2D".points)

func calculatePixelPosition() -> Vector2:
	return Vector2(float(hexSize) * 3.0/2.0 * float(_q), \
				   float(hexSize) * (sqrt(3.0)/2.0 * _q + sqrt(3.0) * float(_r)))

func updatePosition():
	set_position(calculatePixelPosition())

func height() -> float:
	return sqrt(3) * hexSize

func width() -> float:
	return float(hexSize) * 2

func q() -> int:
	return _q

func r() -> int:
	return _r
	
func s() -> int:
	return _s

func total() -> int:
	return _q + _r + _s

func debug():
	print("Hex: ", _q ,"q ", _r,"r ", _s, "s --")
	print("Position: ", calculatePixelPosition())
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(_delta):
	if prevSize != hexSize:
		prevSize = hexSize
		setVertices(vertices(hexSize))

func _on_Area2D_mouse_entered():
	print("Found Polygon " + String(_q) + ", " + String(_r))
