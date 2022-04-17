extends KinematicBody2D

onready var movement_interval = 160
onready var my_position = Vector2()
onready var should_move = false
onready var target_pos = Vector2()
onready var spinning_web = false
onready var run_idle_timer = true
onready var projectile = preload("res://scenes/Bullet.tscn")
onready var N = Vector2(0,-1)
onready var E = Vector2(1,0)
onready var S = Vector2(0,1)
onready var W = Vector2(-1,0)
onready var NE = Vector2(1,-1)
onready var NW = Vector2(-1,-1)
onready var SE = Vector2(1,1)
onready var SW = Vector2(-1,1)
onready var spawn_trigger_interval = 0
onready var ROOT = get_tree().get_root()


func _ready():
	my_position = get_global_position()
	target_pos = my_position

func _physics_process(delta):
	if(run_idle_timer):
		movement_interval -= 1
	
	if(movement_interval <= 0):
		spinning_web = true
		run_idle_timer = false
	
	if(spinning_web):
		move()
	elif(!spinning_web):
		if(!$UpCast.is_colliding()):
			my_position = get_global_position()
			my_position.y -= 0.8
			set_global_position(my_position)
		elif($UpCast.is_colliding()):
			if(!run_idle_timer):
				run_idle_timer = true
		
func move():
	if(!$DownCast.is_colliding()):
		my_position = get_global_position()
		my_position.y += 0.8
		set_global_position(my_position)
		$AnimatedSprite.play("attack")
		spawn_trigger_interval += 1
		if(spawn_trigger_interval % 16 == 0):
			spawn_projectile(E, 2, 0)
			spawn_projectile(W, 2, 0)
	elif($DownCast.is_colliding()):
		spawn_trigger_interval = 0
		spinning_web = false
		$AnimatedSprite.play("idle")
		movement_interval = 160

func die():
	queue_free()
	
func _on_hitbox_area_entered(area):
	die()
	
func spawn_projectile(dir, speed, rot):
	var p = projectile.instance()
	p.set_global_position(get_global_position())
	ROOT.add_child(p)
	dir = dir.normalized() * speed
	p.set_trajectory(dir, rot)