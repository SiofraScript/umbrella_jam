extends KinematicBody2D

export (int) var walk_speed = 175
export (int) var run_speed = 300
export (int) var grav_strength = 150
export (int) var jump_strength = 250

onready var current_speed = walk_speed
onready var direction_input_check = 0
onready var jump_height_timer = 0
onready var jump_acceleration = 6
onready var is_floating = false
onready var is_wall_slide = false
onready var last_facing_left = false
onready var last_slide_r = false
onready var last_slide_l = false
onready var can_jump = true


var velocity = Vector2()

func get_input():
	is_wall_slide = false
	velocity = Vector2()
	direction_input_timer(false)
	
	if($FloorCast.is_colliding()):
		is_floating = false
		last_slide_l = false
		last_slide_r = false
		if(jump_height_timer < 20):
			can_jump = true
		
	if($RightCast.is_colliding()):
		if(Input.is_action_pressed("right")):
			is_wall_slide = true
			last_slide_r = true
			last_slide_l = false
			is_floating = false
		elif(Input.is_action_just_pressed("left")):
			can_jump = true
		else:
			is_wall_slide = false
	elif($LeftCast.is_colliding()):
		if(Input.is_action_pressed("left")):
			is_wall_slide = true
			is_floating = false
			last_slide_r = false
			last_slide_l = true
		elif(Input.is_action_just_pressed("right")):
			can_jump = true
		else:
			is_wall_slide = false
	
	if Input.is_action_pressed("right"):
		velocity.x += 1
		direction_input_timer(true)
	if Input.is_action_pressed("left"):
		velocity.x -= 1
		direction_input_timer(true)
		
	if jump_height_timer > 0:
		velocity.y -= jump_acceleration * jump_strength
		jump_height_timer -= 1
		jump_acceleration *= 0.89
		
	if Input.is_action_pressed("cont_x"):
			if current_speed < run_speed:
				current_speed *= 1.015
				velocity.x = velocity.x * current_speed
			elif run_speed <= current_speed:
				velocity.x = velocity.x * run_speed
				jump_strength = 310
	else:
		current_speed = walk_speed
		jump_strength = 250
		velocity.x = velocity.x * current_speed
		
	if Input.is_action_pressed("jump"):
		if(!$FloorCast.is_colliding()):
			is_floating = true
		else:
			is_floating = false
					
	if Input.is_action_just_released("jump"):
		jump_height_timer = 0
		is_floating = false
		
	if Input.is_action_just_pressed("jump"):
		if(can_jump):
			if((last_slide_l or last_slide_r) and is_wall_slide):
				return
			if(!is_wall_slide and (last_slide_r and Input.is_action_pressed("left"))):
				jump_height_timer = 30
				jump_acceleration = 6
			elif(!is_wall_slide and (last_slide_l and Input.is_action_pressed("right"))):
				jump_height_timer = 30
				jump_acceleration = 6
			else:
				jump_height_timer = 30
				jump_acceleration = 6
				
			can_jump = false
			
	if(!is_on_floor()):
		if(is_floating == true):
			velocity.y += (grav_strength * 0.35)
		else:
			if(is_wall_slide):
				velocity.y += grav_strength * 0.6
			else:
				velocity.y += grav_strength
		

	
func animation_state_handler(vel_vector):
	if (vel_vector.x == 0):
		$AnimatedSprite.play("idle")
	elif (vel_vector.x > 0 and vel_vector.x < 251):
		$AnimatedSprite.play("walk")
	elif (vel_vector.x > 251):
		$AnimatedSprite.play("run")
	elif (vel_vector.x < 0 and vel_vector.x > -251):
		$AnimatedSprite.play("walk")
	elif (vel_vector.x < 251):
		$AnimatedSprite.play("run")
		
	if (vel_vector.y < 0):
		$AnimatedSprite.play("jump")
	elif (vel_vector.y > 0):
		$AnimatedSprite.play("falling")
		
	if (is_floating):
		$AnimatedSprite.play("floating")
		if(vel_vector.y <0):
			$AnimatedSprite.play("jump")
			
	if (is_wall_slide):
		$AnimatedSprite.play("sliding")
	
	if (vel_vector.x < 0):
		$AnimatedSprite.set_flip_h(true)
	elif(vel_vector.x > 0):
		$AnimatedSprite.set_flip_h(false)
	
	Global.anim_info = $AnimatedSprite.get_animation()


func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity, Vector2.UP)
	animation_state_handler(velocity)
	Global.p_info = velocity
	print($FloorCast.is_colliding(), can_jump)

func direction_input_timer(is_input = false):
	if !is_input:
		if direction_input_check > 0:
			direction_input_check -= 1
		else:
			jump_strength = 250
			current_speed = walk_speed
	else:
		direction_input_check = 5
