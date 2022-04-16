extends CollisionShape2D


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
onready var spawn_trigger_interval = 90
onready var spawn_window = 100
onready var ROOT = get_tree().get_root()


func _ready():
	pass 


func _physics_process(delta):

	rotation_pace += 180

	set_rotation_degrees(rotation_pace)
	current_rotation = get_rotation_degrees()
	
	if(spawn_trigger_interval > 0):
		spawn_trigger_interval -= 1
	elif(spawn_trigger_interval <= 0):
		spawn_window -= 1
		
		if(spawn_window % 25 == 0):
			spawn_projectile(NE, 3, current_rotation)
			spawn_projectile(NW, 3, current_rotation)
			spawn_projectile(SE, 3, current_rotation)
			spawn_projectile(SW, 3, current_rotation)
			
		if(spawn_window % 10 == 0):
			spawn_projectile(N, 3, current_rotation)
			spawn_projectile(E, 3, current_rotation)
			spawn_projectile(S, 3, current_rotation)
			spawn_projectile(W, 3, current_rotation)
			#spawn_amount -= 1
			
		if(spawn_window <= 0):
			spawn_window = 100
			spawn_trigger_interval = 90
	

func spawn_projectile(dir, speed, rot):
	var p = projectile.instance()
	ROOT.add_child(p)
	dir = dir.normalized() * speed
	p.set_trajectory(dir, rot)
	p.rotate(current_rotation)
	
	
