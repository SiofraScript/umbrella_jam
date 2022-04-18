extends Area2D


# Declare member variables here. Examples:
# var a = 2
export var scene = "test"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.





func _on_DialogTriggerBox_body_entered(_body):
	Global.shown_dialog = scene
	Global.show_dialog = true
	if scene == "stage1_1":
		get_parent().set_modulation("0c1699")
	elif scene == "stage1_2":
		get_tree().get_current_scene().get_node("EnemyEndGroup").intro()
	elif scene == "stage2_1":
		get_parent().set_modulation("a70b0b")
		get_parent().get_node("FireParent").enable_children()
	elif scene == "stage2_2":
		get_tree().get_current_scene().get_node("EnemyEndGroup").intro()
	elif scene == "stage3_1":
		get_parent().set_modulation("5ebc19")
	elif scene == "stage3_2":
		get_parent().get_node("MovableAnchor").move_y(100)
		get_tree().get_current_scene().get_node("EnemyEndGroup").intro()
	elif scene == "stage4_1":
		get_parent().set_modulation("0c1699")
		get_parent().flame_timer_enabled = true
	elif scene == "stage4_2":
		get_tree().get_current_scene().get_node("EnemyEndGroup").intro()
	elif scene == "stage5_1":
		get_parent().set_modulation("9a248d")
	elif scene == "stage5_2":
		get_tree().get_current_scene().get_node("EnemyEndGroup").intro()
	queue_free()
	
