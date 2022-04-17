extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const dialog_file = "res://ui/dialog_scenes.json"
var scene = ""
var dialogs = {}
var dialog = []
var this_box = []
var speaker = ""
var portrait_path = ""
var text_to_show = ""
var lapsed = 0

var maxchar = 0
var ibox = 0
var max_box = 0

onready var textbox = $textbox

# Called when the node enters the scene tree for the first time.
func _ready():
	var file = File.new()
	var _err = file.open(dialog_file, File.READ)
	dialogs = parse_json(file.get_as_text())
	scene = Global.shown_dialog
	ibox = 0
	get_scene_dialog()

func get_scene_dialog():
	dialog = dialogs[scene]
	max_box = len(dialog)
	this_box = dialog[ibox]
	speaker = this_box[0]
	portrait_path = this_box[1]
	text_to_show = this_box[2]
	maxchar = len(text_to_show)
	textbox.visible_characters = 1
	lapsed = 1.0
	textbox.bbcode_text = text_to_show
	textbox.bbcode_enabled=true

func _process(_delta):
	if (textbox.visible_characters >= maxchar) && Input.is_action_just_pressed("advance_dialog"):
		ibox = ibox + 1
		if ibox == max_box:
			Global.show_dialog = false
			get_tree().paused = false
			queue_free()
			
		else:
			get_scene_dialog()
	elif textbox.visible_characters<maxchar && Input.is_action_just_pressed("advance_dialog"):
		lapsed += 10
	elif textbox.visible_characters<maxchar:
		lapsed += 1
	textbox.visible_characters = lapsed
	
