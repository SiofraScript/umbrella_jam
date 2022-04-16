extends Node


onready var p_info = Vector2()
onready var anim_info = 'start'
var deaths = 0
var currentLevel = "res://scenes/TestWorld.tscn"

var movementPressOrder = [] # this is a simple input buffer. The last entry is the last of 'left' or 'right' that was pressed


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
