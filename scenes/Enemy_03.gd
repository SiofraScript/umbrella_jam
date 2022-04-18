extends Path2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var death_animation = preload("res://scenes/EnemyDeath.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func die():
	#deactivate()
	queue_free()

func deactivate():
	get_node("PathFollow2D/Ghost/Hurtbox").set_deferred("monitorable",false)
	get_node("PathFollow2D/Ghost/hitbox").set_deferred("monitoring",false)
	get_node("PathFollow2D/Ghost").active=false
	
func activate():
	get_node("PathFollow2D/Ghost/Hurtbox").set_deferred("monitorable",true)
	get_node("PathFollow2D/Ghost/hitbox").set_deferred("monitoring",true)
	get_node("PathFollow2D/Ghost").active=true
