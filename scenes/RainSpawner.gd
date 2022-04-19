extends Node2D

export var width = 360
export var spawn_interval = 10
export var timer = 0
export var bullet_scale = 1
export var bullet_velocity = Vector2(0,2)
# Called when the node enters the scene tree for the first time.
var rng = RandomNumberGenerator.new()
var bullet = preload("res://scenes/RainBullet.tscn")

func _ready():
	rng.randomize()
	
	
	
func _physics_process(_delta):
	timer = timer + 1
	if timer>=spawn_interval:
		timer = 0
		fire_bullet()

func fire_bullet():
	var _bullet = bullet.instance()
	_bullet.global_position = global_position
	_bullet.global_position.x += rng.randf_range(-width/2, width/2)
	_bullet.velocity =  bullet_velocity
	_bullet.scale = Vector2.ONE*bullet_scale
	get_tree().get_current_scene().add_child(_bullet)
