extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$SpawnAnimation.visible = false
	$AnimatedSprite.play("default")


func spawn():
	$AnimatedSprite.visible = false
	$SpawnAnimation.visible = true
	$SpawnAnimation.animation = "default"
	$SpawnAnimation.frame=0
	$SpawnAnimation.play()
	
	
func despawn():
	set_deferred("monitorable",false)
	$AnimatedSprite.animation = "despawn"
	$AnimatedSprite.frame=0
	$AnimatedSprite.play()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass





func _on_SpawnAnimation_animation_finished():
	$AnimatedSprite.animation = "default"
	$AnimatedSprite.visible = true
	$AnimatedSprite.play()
	$SpawnAnimation.visible = false
	set_deferred("monitorable",true)

