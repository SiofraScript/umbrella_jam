extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var tween = $Tween
onready var bgtween = $BGTween
export var tween_time = 1.0

func change_modulation(new_modulation):
	var current_modulation = modulate
	tween.interpolate_property(self, "modulate",
		current_modulation, Color(new_modulation), tween_time,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

	tween.interpolate_property(get_node("ParallaxBackground"), "modulate",
		current_modulation, Color(new_modulation), tween_time,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
