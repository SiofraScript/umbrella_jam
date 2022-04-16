extends "res://scripts/Enemy.gd"


# Declare member variables here. Examples:
# var a = 2
export var fire_interval = 120
export var initial_timer = 0
export var bullet_type = "default"
export var bullet_scale = 1
export var bullet_velocity = Vector2.ZERO
var timer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	timer = initial_timer

func fire_bullet(bullet_type):
	var _bullet = bullets[bullet_type].instance()
	_bullet.global_position = position
	_bullet.velocity =  bullet_velocity
	_bullet.scale = Vector2.ONE*bullet_scale
	get_tree().get_current_scene().add_child(_bullet)

func _physics_process(_delta):
	timer = timer + 1
	if timer >= fire_interval:
		timer = 0
		fire_bullet(bullet_type)
