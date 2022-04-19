extends TextureRect


# Declare member variables here. Examples:
var startable = false
onready var score_label = $score
var score = 0

func save_score(time):
	var file = File.new()
	#file.open("user://score.dat", File.WRITE)
	file.open("user://score.dat", File.READ_WRITE)
	file.seek_end()
	file.store_string("\n")
	file.store_string(String(time))
	file.close()

func load_score():
	var file = File.new()
	var err = file.open("user://score.dat", File.READ)
	if err == OK:
		var content = file.get_as_text()
		file.close()
		var strarr = content.rsplit("\n", true, 1)
		score = float(strarr[strarr.size()-1])
	else:
		score = INF
	return score

func _ready():
	Global.completiontime = (OS.get_ticks_msec() - Global.time_start)/1000.0
	save_score(Global.completiontime)
	score = load_score()
	score_label.text = "Your time: " + String(score) + " s"

func _process(_delta):
	if	startable && (Input.is_action_just_pressed("advance_dialog")):
		var _ret = get_tree().change_scene("res://scenes/title.tscn")
	startable = true
