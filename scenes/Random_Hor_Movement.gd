extends KinematicBody2D

var death_animation = preload("res://scenes/EnemyDeath.tscn")

onready var random_gen = RandomNumberGenerator.new()
onready var movement_interval = 160
onready var my_position = Vector2()
onready var should_move = false
onready var target_pos = Vector2()

var active = true

var orientation_corrected = false

func _ready():
	my_position = get_global_position()
	target_pos = my_position
	random_gen.randomize()
	


func _physics_process(_delta):
	if active:
		if($UpCast.is_colliding()) and !orientation_corrected:
			$AnimatedSprite.set_flip_v(true)
			$DownCastLeft.cast_to = -$DownCastLeft.cast_to
			$DownCastRight.cast_to = -$DownCastRight.cast_to
			orientation_corrected = true
		move()
		
		if(movement_interval > 0):
			movement_interval -= 1
		elif(movement_interval <= 0):
			movement_interval = 160
				
			var avail_movements = read_raycasts()
			if(avail_movements == 0):
				target_pos = my_position
				target_pos.x += 32
			elif(avail_movements == 1):
				target_pos = my_position
				target_pos.x -= 32
			elif(avail_movements == 2):
				var next_dir = random_int(0,1)
				if(next_dir == 0):
					target_pos = my_position
					target_pos.x += 32
				else:
					target_pos = my_position
					target_pos.x -= 32
			

func random_int(Min, Max):
	var value = randi() % (Max - Min + 1) + Min
	return value
	
func read_raycasts():
	var leftOK = !$LeftCast.is_colliding() and $DownCastLeft.is_colliding()
	var rightOK = !$RightCast.is_colliding() and $DownCastRight.is_colliding()
	my_position = get_global_position()
	if(leftOK and rightOK):
		return 2
	elif(!leftOK and rightOK):
		return 0
	elif(leftOK and !rightOK):
		return 1
		
func move():
	if(my_position.x == target_pos.x):
		$AnimatedSprite.stop()
		pass
	elif(my_position.x < target_pos.x):
		my_position.x += 1
		$AnimatedSprite.set_flip_h(true)
		$AnimatedSprite.play("walk")
	elif(my_position.x > target_pos.x):
		my_position.x -= 1
		$AnimatedSprite.play("walk")
		$AnimatedSprite.set_flip_h(false)
	set_global_position(my_position)

func die():
	var da = death_animation.instance()
	da.position = global_position
	get_tree().get_current_scene().add_child(da)
	queue_free()
	
func _on_hitbox_area_entered(_area):
	die()
	
func deactivate():
	get_node("Hurtbox").set_deferred("monitorable",false)
	get_node("hitbox").set_deferred("monitoring",false)
	active=false
	
func activate():
	get_node("Hurtbox").set_deferred("monitorable",true)
	get_node("hitbox").set_deferred("monitoring",true)
	active=true
