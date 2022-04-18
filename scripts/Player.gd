extends KinematicBody2D

export (int) var walk_acc = 8
export (int) var max_walk_speed = 100
export (int) var default_max_fall_speed = 300
export var groundfriction = 0.2
export (int) var idle_speed_threshold = 10

export (int) var grav_strength = 50
export (int) var default_jump_acceleration = 100
export (int) var default_jump_height_timer = 30

export var float_grav_strn_mult = 0.35
export var cling_grav_strn_mult = 0.35
export var jump_gravity_mult = 0.35
export var jump_accel_tamper = 0.79


var max_fall_speed = default_max_fall_speed

onready var direction_input_check = 0
onready var jump_height_timer = 0
onready var jump_acceleration = default_jump_acceleration
onready var is_floating = false
onready var is_wall_slide = false
onready var is_idle = true
onready var last_facing_left = false
onready var last_slide_r = false
onready var last_slide_l = false
onready var can_jump = true
var on_ground = true

var can_die = true

var velocity = Vector2()

var death_animation = preload("res://scenes/PlayerDeath.tscn")

func update_camera():
	$Camera2D.limit_left = Global.camera_limit_left
	$Camera2D.limit_right = Global.camera_limit_right
	$Camera2D.limit_top = Global.camera_limit_top
	$Camera2D.limit_bottom = Global.camera_limit_bottom
	Global.update_camera = false

func _ready():
	can_die = true

func get_input(_delta):
	var x_input = Global.movementPressOrder[-1]
	var umbrella_input = Global.umbrellaPressOrder[-1]
	if on_ground and umbrella_input == Vector2.DOWN:
		umbrella_input = Global.umbrellaPressOrder[-2]
	
	is_wall_slide = false
	on_ground = ($FloorCast.is_colliding() or $FloorCast2.is_colliding())
	if(on_ground):
		is_floating = false
		last_slide_l = false
		last_slide_r = false
		can_jump = true
	
#
#	if($RightCast.is_colliding()):
#		if(Input.is_action_pressed("right")):
#			is_wall_slide = true
#			last_slide_r = true
#			last_slide_l = false
#			is_floating = false
#		elif(Input.is_action_just_pressed("left")):
#			can_jump = true
#		else:
#			is_wall_slide = false
#	elif($LeftCast.is_colliding()):
#		if(Input.is_action_pressed("left")):
#			is_wall_slide = true
#			is_floating = false
#			last_slide_r = false
#			last_slide_l = true
#		elif(Input.is_action_just_pressed("right")):
#			can_jump = true
#		else:
#			is_wall_slide = false
	
	
	if x_input != 0:
		is_idle = false
		velocity.x += x_input * walk_acc
		velocity.x = clamp(velocity.x,-max_walk_speed,max_walk_speed)
	else:
		velocity.x = lerp(velocity.x,0,groundfriction)
		if (abs(velocity.x) < idle_speed_threshold) and on_ground:
			is_idle = true
		
#	if Input.is_action_just_pressed("jump") and jump_height_timer <= 0:
#		if(!on_ground):
#			is_floating = true
#		else:
#			is_floating = false
		
	if Input.is_action_just_pressed("jump"):
		if(can_jump):
			is_idle = false
			if((last_slide_l or last_slide_r) and is_wall_slide):
				return
			if(!is_wall_slide and (last_slide_r and Input.is_action_pressed("left"))):
				jump_height_timer = default_jump_height_timer
				jump_acceleration = default_jump_acceleration
			elif(!is_wall_slide and (last_slide_l and Input.is_action_pressed("right"))):
				jump_height_timer = default_jump_height_timer
				jump_acceleration = default_jump_acceleration
			else:
				jump_height_timer = default_jump_height_timer
				jump_acceleration = default_jump_acceleration
			velocity.y = 0
				
			can_jump = false
		elif (!on_ground):
			is_floating = true
			
		
	if !Input.is_action_pressed("jump"):
		jump_height_timer = 0
		is_floating = false
		
	if(!on_ground):
		if(is_floating == true):
			velocity.y += (grav_strength * float_grav_strn_mult)
			can_jump = false
			velocity.y = clamp(velocity.y,-INF,default_max_fall_speed * float_grav_strn_mult)
		else:
			if(is_wall_slide):
				velocity.y += (grav_strength * cling_grav_strn_mult)
				can_jump = true
				velocity.y = clamp(velocity.y,-INF,default_max_fall_speed * cling_grav_strn_mult)
			elif jump_height_timer > 0:
				velocity.y += grav_strength* jump_gravity_mult
				can_jump = false
				velocity.y = clamp(velocity.y,-INF,default_max_fall_speed * jump_gravity_mult)
			else:
				velocity.y += grav_strength
				can_jump = false
				velocity.y = clamp(velocity.y,-INF,default_max_fall_speed)
	
	if jump_height_timer > 0:
		#print(jump_height_timer)
		#print(delta)
		velocity.y = velocity.y - jump_acceleration
		jump_height_timer = jump_height_timer - 1
		jump_acceleration = jump_acceleration * jump_accel_tamper
	
	if !is_floating:
		$umbrella.visible=true
		# TODO: move umbrella rotation logic to umbrella object itself
		# WE MIGHT want to change umbrella sprite for left/right, etc.
		# to have its tongue affected by gravity, etc.
		#$umbrella/blockbox.disabled = false
		if !(on_ground and umbrella_input == Vector2.DOWN):
			$umbrella.rotation = umbrella_input.angle()
	else:
		$umbrella.visible=false
		$umbrella.rotation = Vector2.UP.angle()
		#$umbrella/blockbox.disabled = true
		
	
func animation_state_handler(vel_vector):
	if (is_wall_slide):
		$AnimatedSprite.play("sliding")
	elif (is_floating):
		if (vel_vector.y >=0):
			$AnimatedSprite.play("floating")
		else:
			$AnimatedSprite.play("jump")
	else:
		if (jump_height_timer > 0):
			$AnimatedSprite.play("jump")
		elif (!on_ground):
			$AnimatedSprite.play("falling")
		elif (is_idle):
			$AnimatedSprite.play("idle")
		else:
			$AnimatedSprite.play("walk")


		
	
		
	if (vel_vector.x < 0):
		$AnimatedSprite.set_flip_h(true)
	elif(vel_vector.x > 0):
		$AnimatedSprite.set_flip_h(false)
	
	Global.anim_info = $AnimatedSprite.get_animation()
	#print(Global.anim_info)

func _physics_process(delta):
	
	if Global.update_camera:
		update_camera()
	
	get_input(delta)
	velocity = move_and_slide(velocity, Vector2.UP)
	animation_state_handler(velocity)
	Global.p_info = velocity
	if position.y > Global.camera_limit_bottom + 200:
		die()
	#print($FloorCast.is_colliding(), can_jump)

func die():
	# To prevent double-counting death if player touches two death-sources at once, etc.
	if can_die:
		Global.deaths = Global.deaths + 1
		print(Global.deaths)
		can_die = false
		var da = death_animation.instance()
		da.position = global_position
		if $AnimatedSprite.flip_h:
			da.flip_h = true
		get_tree().get_current_scene().add_child(da)
		visible = false
		

func _on_hitbox_area_entered(_area):
	die()
