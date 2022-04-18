extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_umbrella_area_entered(_area):
	# if we want umbrella to react to blocking bulllets
	pass # Replace with function body.


func _on_umbrella_body_entered(_body):
	# if we want umbrella to react to attacking enemies
	pass # Replace with function body.


func _on_hitbox_area_entered(_area):
	# kill the player
	get_parent().die()
