extends Node2D


onready var rotation_pace = 1
onready var projectile = preload("res://scenes/Bullet.tscn")
onready var current_rotation = Vector2()
onready var N = Vector2(0,-1)
onready var E = Vector2(1,0)
onready var S = Vector2(0,1)
onready var W = Vector2(-1,0)
onready var NE = Vector2(1,-1)
onready var NW = Vector2(-1,-1)
onready var SE = Vector2(1,1)
onready var SW = Vector2(-1,1)
onready var spawn_trigger_interval = 160
onready var spawn_window = 100
onready var ROOT = get_tree().get_root()

onready var down_cast = get_parent().get_node("DownCast")
onready var up_cast = get_parent().get_node("UpCast")


func _ready():
	pass 


func _physics_process(_delta):
	if(spawn_trigger_interval > 0):
		spawn_trigger_interval -= 1
	elif(spawn_trigger_interval <= 0):
		spawn_trigger_interval = 160
		spawn_projectile(W, 2, 0)
		spawn_projectile(E, 2, 0)
		if(!down_cast.is_colliding()):
			spawn_projectile(S, 2, 0)
		if(!up_cast.is_colliding()):
			spawn_projectile(N, 2, 0)
	

func spawn_projectile(dir, speed, rot):
	var p = projectile.instance()
	p.set_global_position(get_parent().get_global_position())
	ROOT.add_child(p)
	dir = dir.normalized() * speed
	p.set_trajectory(dir, rot)

	
	
