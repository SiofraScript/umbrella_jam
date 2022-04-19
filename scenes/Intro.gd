extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.shown_dialog = "intro"
	Global.show_dialog = true
	$DialogBox.scene="intro"


func _process(_delta):
	if get_child_count() <= 6:
		Global.time_start = OS.get_ticks_msec()
		Global.deaths = 0
		PauseControl.stage_bgm()
		var _unused = get_tree().change_scene("res://scenes/Stage1.tscn")
		
