extends TextureRect

var startable = false

onready var hiscore_label = $hiscore_label
onready var start = $start # sound effect

func load_hiscore():
	var file = File.new()
	var hiscore
	if file.file_exists("user://score.dat"):
		file.open("user://score.dat", File.READ)
		var content = file.get_as_text()
		file.close()
		var strarr = content.split("\n")
		var intarr = []
		for this_str in strarr:
			if "inf" in this_str.to_lower():
				intarr.append(INF)
			elif len(this_str) == 0:
				intarr.append(INF)
			else:
				intarr.append(float(this_str))
		hiscore = intarr.min()
		if !is_inf(hiscore):
			hiscore_label.text = "Best time: " + String(hiscore) + " s"
	else:
		hiscore = INF
		file.open("user://score.dat", File.WRITE)
		file.store_string(String(hiscore))
		file.close()
		hiscore_label.text = ""

func _ready():
	$buttonani.play('updown')
	load_hiscore()
	
	
func _process(_delta):
	if	startable && (Input.is_action_just_pressed('jump') or Input.is_action_just_pressed('left') or Input.is_action_just_pressed('right') or Input.is_action_just_pressed('down') or Input.is_action_just_pressed('umbrella_left') or Input.is_action_just_pressed('umbrella_right') or Input.is_action_just_pressed("umbrella_down") or Input.is_action_just_pressed("umbrella_up") or Input.is_action_just_pressed("advance_dialog")):
		start.play(0)
	startable = true


func _on_start_finished():
	Global.shown_dialog="intro"
	var _ret = get_tree().change_scene("res://scenes/Intro.tscn")
