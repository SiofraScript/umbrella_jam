extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var tween_time = 100

onready var tween = $Tween
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	

	
func move_y(new_y):
	var x = position[0]
	var new_position = Vector2(x,new_y)
	tween.interpolate_property(self, "position",
		position, new_position, tween_time,
		Tween.TRANS_QUAD, Tween.EASE_IN)
	tween.start()


func _on_Tween_tween_completed(object, key):
	Global.camera_limit_bottom = 3000
	Global.update_camera = true
	queue_free()
