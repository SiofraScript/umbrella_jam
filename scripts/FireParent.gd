extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func disable_children():
	visible = false
	for node in get_children():
		node.set_deferred("monitorable",false)
		
func enable_children():
	print("enable")
	visible = true
	for node in get_children():
		node.set_deferred("monitorable",true)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
