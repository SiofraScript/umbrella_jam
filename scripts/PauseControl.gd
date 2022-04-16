extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var soft_pause = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(_delta):
	# input buffer logic
	if Input.is_action_just_pressed("left"):
		Global.movementPressOrder.erase(-1)
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
		Global.movementPressOrder.push_front(0)
	
	
	if Input.is_action_just_pressed("pause"):
		if !get_tree().paused:
			get_tree().paused = true
			$PauseSound.play(0)
			# TODO PAUSE BGM
		else:
			get_tree().paused = false
			$PauseSound.play(0) # unpause sound
			# TODO unpause BGM
	elif Input.is_action_just_pressed("reset"):
		var _unused = get_tree().change_scene(Global.currentLevel)
	elif soft_pause && (Input.is_action_just_pressed("left") || Input.is_action_just_pressed("right") || Input.is_action_just_pressed("down") || Input.is_action_just_pressed("jump")):
		get_tree().paused = false
		soft_pause = false
