extends ParallaxBackground


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var city_offset_x = 0
var city_offset_y = 75
var rail_offset_x = 0
var rail_offset_y = 47
export var cityspeed = -0.1
export var railspeed = -1


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _physics_process(_delta):
	$ParallaxLayerCity.set_motion_offset(Vector2(city_offset_x,city_offset_y))
	city_offset_x += cityspeed
	$ParallaxLayerRail.set_motion_offset(Vector2(rail_offset_x,rail_offset_y))
	rail_offset_x += railspeed

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
