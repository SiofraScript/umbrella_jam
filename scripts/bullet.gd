extends Area2D


export var velocity = Vector2.ZERO 

onready var updated_velocity = Vector2()
onready var lifetime = 240

func _ready():
	#This is redundant, but I wanted to keep the original velocity assignment 
	#in the event we go a different way with this. If not, then we can clean up later. 
	updated_velocity = velocity 
	pass

func _physics_process(_delta):
	move()
	lifetime -= 1
	if(lifetime <= 0):
		queue_free()
	

func move():
	position += updated_velocity


func set_trajectory(vel2, rot):
	updated_velocity = vel2.rotated(rot)
	
	
func _on_bullet_body_entered(_body):
	# we collided with the player or the stage
	queue_free()


func _on_bullet_area_entered(_area):
	# we collided with the player's umbrella, most likely.
	queue_free()
