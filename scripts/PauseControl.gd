extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(_delta):
	######### input buffer logic #############
	# needs to be updated even when paused
	if Input.is_action_just_pressed("left"):
		Global.umbrellaPressOrder.erase(-1)
		Global.movementPressOrder.append(-1)

	if Input.is_action_just_released("left"):
		Global.movementPressOrder.erase(-1)
		
	if Input.is_action_just_pressed("right"):
		Global.movementPressOrder.erase(1)
		Global.movementPressOrder.append(1)

	if Input.is_action_just_released("right"):
		Global.movementPressOrder.erase(1)
		
	if Input.is_action_just_pressed("down"):
		Global.movementPressOrder.erase(0)
		Global.movementPressOrder.append(0)

	if Input.is_action_just_released("down"):
		Global.movementPressOrder.erase(0)
		Global.movementPressOrder.push_front(0) #default if nothing pressed
	
	########### umbrella input buffer ###############
	# needs to be updated even when paused
	if Input.is_action_just_pressed("umbrella_left"):
		Global.umbrellaPressOrder.erase(Vector2.LEFT)
		Global.umbrellaPressOrder.append(Vector2.LEFT)

	if Input.is_action_just_released("umbrella_left"):
		Global.umbrellaPressOrder.erase(Vector2.LEFT)
		
	if Input.is_action_just_pressed("umbrella_right"):
		Global.umbrellaPressOrder.erase(Vector2.RIGHT)
		Global.umbrellaPressOrder.append(Vector2.RIGHT)

	if Input.is_action_just_released("umbrella_right"):
		Global.umbrellaPressOrder.erase(Vector2.RIGHT)
		
	if Input.is_action_just_pressed("umbrella_down"):
		Global.umbrellaPressOrder.erase(Vector2.DOWN)
		Global.umbrellaPressOrder.append(Vector2.DOWN)

	if Input.is_action_just_released("umbrella_down"):
		Global.umbrellaPressOrder.erase(Vector2.DOWN)

	if Input.is_action_just_pressed("umbrella_up"):
		Global.umbrellaPressOrder.erase(Vector2.UP)
		Global.umbrellaPressOrder.append(Vector2.UP)

	if Input.is_action_just_released("umbrella_up"):
		Global.umbrellaPressOrder.erase(Vector2.UP)
		Global.umbrellaPressOrder.push_front(Vector2.UP) # default if nothing pressed

	# handle pause inputs iff we are not showing dialog
	if Global.show_dialog:
		get_tree().paused = true
		
		
	elif Global.soft_pause:
		get_tree().paused = true
		# pause controls for soft pause
		# pause button enters hard pause
		# reset resets
		# most other buttons unpause
		if Input.is_action_just_pressed("pause"):
			get_tree().paused = true
			$PauseSound.play(0) # pause sound
			# TODO pause BGM
			Global.hard_pause = true
			Global.soft_pause = false
		elif Input.is_action_just_pressed("reset"):
			var _unused = get_tree().change_scene(Global.currentLevel)
		elif (Input.is_action_just_pressed("left") || Input.is_action_just_pressed("right") || Input.is_action_just_pressed("down") || Input.is_action_just_pressed("jump")):
			get_tree().paused = false
			Global.soft_pause = false
	else:
		
		# default pass control
		if Input.is_action_just_pressed("pause"):
			if Global.hard_pause:
				get_tree().paused = false
				$PauseSound.play(0) # Unpause sound
				Global.hard_pause = false
				# TODO UNPAUSE BGM
			else:
				get_tree().paused = true
				$PauseSound.play(0)
				Global.hard_pause = true
				# TODO PAUSE BGM
		elif Input.is_action_just_pressed("reset"):
			var _unused = get_tree().change_scene(Global.currentStage)
			get_tree().paused = true
			Global.soft_pause = true
			Global.hard_pause = false
		
		
