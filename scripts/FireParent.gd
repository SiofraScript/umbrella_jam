extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var disabled = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func disable_children():
	for node in get_children():
		#node.set_deferred("monitorable",false)
		node.despawn()
	disabled = true
		
func enable_children():
	for node in get_children():
		#node.set_deferred("monitorable",true)
		node.spawn()
	disabled = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
