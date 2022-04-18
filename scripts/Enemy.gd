extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var bullets = {"default" : preload("res://scenes/Bullet.tscn")}
var death_animation = preload("res://scenes/EnemyDeath.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func die():
	# todo: spawn death animation object here
	var da = death_animation.instance()
	da.position = global_position
	get_tree().get_current_scene().add_child(da)
	queue_free()
	
func _on_hitbox_area_entered(_area):
	die()
