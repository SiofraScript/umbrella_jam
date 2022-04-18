extends TextureRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.shown_dialog = "intro"
	Global.show_dialog = true
	$DialogBox.scene="intro"


func _process(_delta):
	if get_child_count() <= 0:
		var _unused = get_tree().change_scene("res://scenes/Stage1.tscn")
