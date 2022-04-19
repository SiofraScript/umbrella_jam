extends "res://scripts/world.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var flame_interval = 225
var flame_timer = 0
var flame_timer_enabled = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$FireParent.disable_children()
	

func _physics_process(_delta):
	if flame_timer_enabled:
		flame_timer = flame_timer - 1
		if flame_timer < 0:
			flame_timer =  flame_interval
			if $FireParent.disabled:
				$FireParent.enable_children()
				set_modulation("a70b0b")
			else:
				$FireParent.disable_children()
				set_modulation("0c1699")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
