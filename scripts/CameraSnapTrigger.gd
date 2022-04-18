extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var camera_limit_left = 0
export var camera_limit_right = 320
export var camera_limit_top = 0
export var camera_limit_bottom = 240

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_CameraSnapTrigger_body_entered(_body):
	print("triggered")
	Global.camera_limit_left = camera_limit_left
	Global.camera_limit_right = camera_limit_right
	Global.camera_limit_bottom = camera_limit_bottom
	Global.camera_limit_top = camera_limit_top
	Global.update_camera = true

