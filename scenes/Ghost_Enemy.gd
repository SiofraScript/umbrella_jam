extends KinematicBody2D

onready var movement_interval = 160
onready var my_position = Vector2()
onready var should_move = false
onready var target_pos = Vector2()
onready var pause_movement = false
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
onready var offset_adjust = 0
onready var pause_time = 80
onready var kogasa_pos = Vector2()
var active = true

func _ready():
	pass

func _physics_process(_delta):
	if active:
		if(pause_movement):
			if(pause_time > 0):
				pause_time -= 1
				$AnimatedSprite.play("attack")
				if(pause_time % 15 == 0):
					spawn_projectile(NE, 2, 0)
					spawn_projectile(SE, 2, 0)
					spawn_projectile(NW, 2, 0)
					spawn_projectile(SW, 2, 0)
				if(pause_time % 10 == 0):
					spawn_projectile(N, 2, 0)
					spawn_projectile(S, 2, 0)
					spawn_projectile(W, 2, 0)
					spawn_projectile(E, 2, 0)
			elif(pause_time <= 0):
				pause_movement = false
				movement_interval = 160
		else:
			$AnimatedSprite.play("float")
			if(movement_interval > 0):
				movement_interval -= 1
				move()
			elif(movement_interval <= 0):
				pause_movement = true
				pause_time = 80
			
		
func move():
	offset_adjust += 1
	get_parent().set_offset(offset_adjust)
	
	kogasa_pos = get_owner().get_parent().get_owner().get_node("Player").get_global_position()
	if(get_global_position().x > kogasa_pos.x):
		$AnimatedSprite.set_flip_h(false)
	elif(get_global_position().x < kogasa_pos.x):
		$AnimatedSprite.set_flip_h(true)

func die():
	get_parent().get_parent().die()
	#queue_free()
	
func _on_hitbox_area_entered(_area):
	die()
	
func spawn_projectile(dir, speed, rot):
	var p = projectile.instance()
	p.set_global_position(get_global_position())
	get_tree().get_current_scene().add_child(p)
	dir = dir.normalized() * speed
	p.set_trajectory(dir, rot)
