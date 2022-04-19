extends Node


onready var p_info = Vector2()
onready var anim_info = 'start'
var deaths = 0
var currentStage = "res://scenes/title.tscn"
var nextStage = "res://scenes/title.tscn"

var movementPressOrder = [0] # this is a simple input buffer. The last entry is the last of 'left' or 'right' that was pressed
var umbrellaPressOrder = [Vector2.UP]

var show_dialog = false
var shown_dialog = "intro"
var hard_pause = false
var soft_pause = true

var time_start = -INF
var completiontime = 0

var camera_limit_left = 0
var camera_limit_right = 0
var camera_limit_top = 0
var camera_limit_bottom = 0
var update_camera = false

var stage_modulation = Color("ffffff")

var sadness_color = "0c1699"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func change_stage():
	var _ret = get_tree().change_scene(nextStage)
