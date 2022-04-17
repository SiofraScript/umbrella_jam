extends KinematicBody2D



onready var random_gen = RandomNumberGenerator.new()
onready var movement_interval = 160
onready var my_position = Vector2()
onready var should_move = false
onready var target_pos = Vector2()


func _ready():
	my_position = get_global_position()
	target_pos = my_position
	random_gen.randomize()


func _physics_process(delta):
	if($UpCast.is_colliding()):
		$AnimatedSprite.set_flip_v(true)
		
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
	my_position = get_global_position()
	if(!$LeftCast.is_colliding() and !$RightCast.is_colliding()):
		return 2
	elif($LeftCast.is_colliding() and !$RightCast.is_colliding()):
		return 0
	elif(!$LeftCast.is_colliding() and $RightCast.is_colliding()):
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
	queue_free()
	
func _on_hitbox_area_entered(area):
	die()
	
