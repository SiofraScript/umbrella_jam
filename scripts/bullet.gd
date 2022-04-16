extends Area2D


export var velocity = Vector2.ZERO

func _ready():
	pass

func _physics_process(_delta):
	position = position + velocity


func _on_bullet_body_entered(body):
	# we collided with the player or the stage
	queue_free()


func _on_bullet_area_entered(area):
	# we collided with the player's umbrella, most likely.
	queue_free()
