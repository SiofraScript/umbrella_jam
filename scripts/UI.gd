extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var dialogBox = preload("res://scenes/DialogBox.tscn")
var shown = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$ColorRect.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if !Global.show_dialog:
		shown = false
	elif Global.show_dialog and !shown:
		var d = dialogBox.instance()
		#d.anchor_left = 10
		#d.anchor_top = 10
		$DialogAnchor.add_child(d)
		shown = true
	
