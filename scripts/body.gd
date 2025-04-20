extends Node2D

@onready var head = $Head
@onready var torso = $Torso
@onready var rleg = $RLeg
@onready var lleg = $LLeg
@onready var rarm = $RArm
@onready var larm = $LArm

#HEALTH

var headHP = 100
var torsoHP = 100
var rlegHP = 100
var llegHP = 100
var rarmHP = 100
var larmHP = 100

var death = false

func _physics_process(delta):
	_rotation_sprite()


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
	if rarmHP <= 0:
		rarm.visible = false
	if larmHP <= 0:
		larm.visible = false
	if rlegHP <= 0:
		rleg.visible = false
	if llegHP <= 0:
		lleg.visible = false
