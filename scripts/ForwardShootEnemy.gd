extends "res://scripts/Enemy.gd"


# Declare member variables here. Examples:
# var a = 2
export var fire_interval = 120
export var initial_timer = 0
export var bullet_scale = 1
export var bullet_velocity = Vector2.ZERO
var timer = 0
var active = true

# Called when the node enters the scene tree for the first time.
func _ready():
	timer = initial_timer

func fire_bullet(bullet_type):
	var _bullet = bullets[bullet_type].instance()
	print(scale)
	print(global_position)
	print(position)
	_bullet.global_position = global_position
	_bullet.velocity =  bullet_velocity
	_bullet.scale = Vector2.ONE*bullet_scale
	get_tree().get_current_scene().add_child(_bullet)

func _physics_process(_delta):
	if active:
		timer = timer + 1
		if timer >= fire_interval:
			timer = 0
			# bullet_type(s) are defined in a dictionary in the enemy base class...
			# SORRY!
			fire_bullet("default")

func deactivate():
	get_node("Hurtbox").set_deferred("monitorable",false)
	get_node("hitbox").set_deferred("monitoring",false)
	active=false
	
func activate():
	get_node("Hurtbox").set_deferred("monitorable",true)
	get_node("hitbox").set_deferred("monitoring",true)
	active=true
