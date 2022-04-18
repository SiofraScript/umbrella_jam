extends Node2D

var saved_umbrella_class = preload("res://scenes/SavedUmbrella.tscn")

export var nextStage = "res://scenes/Stage2.tscn"
export var camera_limit_left = 0 
export var camera_limit_right = 2112 #window widht: 416
export var camera_limit_bottom = 300 
export var camera_limit_top = 0 #window height: 240


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.camera_limit_bottom = camera_limit_bottom
	Global.camera_limit_top = camera_limit_top
	Global.camera_limit_right = camera_limit_right
	Global.camera_limit_left = camera_limit_left
	Global.update_camera = true
	Global.currentStage = filename
	Global.nextStage = nextStage
	$UI/AnimationPlayer.play("undim")
	Global.soft_pause = true
	set_modulation("ffffff")
		
		
func set_modulation(modulation):
	$ColorModulator.change_modulation(modulation)
	Global.stage_modulation = modulation

func change_umbrella():
	var umbrella_pos = $stray_umbrella.global_position
	var new_umbrella = saved_umbrella_class.instance()
	new_umbrella.global_position = umbrella_pos
	add_child(new_umbrella)
	
