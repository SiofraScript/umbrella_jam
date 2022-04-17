extends Area2D


# Declare member variables here. Examples:
# var a = 2
export var scene = "test"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_DialogTriggerBox_body_entered(_body):
	Global.shown_dialog = scene
	Global.show_dialog = true
	if scene == "stage1_1":
		get_parent().set_modulation("0c1699")
	elif scene == "stage1_2":
		# TODO: spawn enemies
		pass
	elif scene == "stage2_1":
		get_parent().set_modulation("a70b0b")
		get_parent().get_node("FireParent").enable_children()
	elif scene == "stage2_2":
		# TODO: spawn enemies
		pass
	queue_free()
	
