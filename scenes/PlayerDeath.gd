extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	frame=0
	play()

func _on_PlayerDeath_animation_finished():
	var _tmp = get_tree().change_scene(Global.currentStage)
