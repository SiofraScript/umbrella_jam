extends Node2D

var active = false
export var funny_scale = 1.0 setget scaling_intro
# Called when the node enters the scene tree for the first time.

func deactivate_enemies():
	for node in get_children():
		if node.has_method("die"):
			node.deactivate()
			node.visible = false
		
func activate_enemies():
	for node in get_children():
		if node.has_method("die"):
			node.activate()
			node.visible = true
			
func visible_enemies():
	for node in get_children():
		if node.has_method("die"):
			node.visible = true

func _ready():
	deactivate_enemies()

func intro():
	if not active:
		visible_enemies()
		$AnimationPlayer.play("intro")
	
func scaling_intro(s):
	scale = Vector2(s,s)
	for node in get_children():
		if node.has_method("die"):
			node.scale = Vector2(1/s,1/s)

func _physics_process(_delta):
	if active:
		var N = 0
		for node in get_children():
			if node.has_method("die"):
				N = N + 1
		if N <= 0:
			# I want to dim the stage, but it would never play
			# since change_stage() would happen immediately
			# need to do it at the end of animation signal
			#get_parent().get_node("UI/AnimationPlayer").play("dim")
			get_tree().get_current_scene().change_umbrella()
			active = false


func _on_AnimationPlayer_animation_finished(_anim_name):
	activate_enemies()
	active = true
