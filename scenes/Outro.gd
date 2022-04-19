extends TextureRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.shown_dialog = "outro"
	Global.show_dialog = true
	$DialogBox.scene="outro"


func _process(_delta):
	if get_child_count() <= 0:
		PauseControl.title_bgm()
		var _unused = get_tree().change_scene("res://scenes/Ending.tscn")
		
