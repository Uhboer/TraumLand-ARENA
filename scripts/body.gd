extends Node2D

@onready var head = $Head
@onready var torso = $Torso
@onready var rleg = $RLeg
@onready var lleg = $LLeg
@onready var rarm = $RArm
@onready var larm = $LArm

#HEALTH

var death = false

func _physics_process(delta):
	_rotation_sprite()
	limb_destruction()
	print(Global.rarmHP)


func _rotation_sprite():
	if Input.is_action_just_pressed("A"):
		head.flip_h = true
		torso.flip_h = true
		rleg.flip_h = true
		lleg.flip_h = true
		rarm.flip_h = true
		larm.flip_h = true
	if Input.is_action_just_pressed("D"):
		head.flip_h = false
		torso.flip_h = false
		rleg.flip_h = false
		lleg.flip_h = false
		rarm.flip_h = false
		larm.flip_h = false


func limb_destruction():
	if Global.rarmHP <= 0:
		rarm.visible = false
	if Global.larmHP <= 0:
		larm.visible = false
	if Global.rlegHP <= 0:
		rleg.visible = false
	if Global.llegHP <= 0:
		lleg.visible = false
