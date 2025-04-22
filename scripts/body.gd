extends Node2D

@onready var layouts = $".."

@onready var head = $Head
@onready var torso = $Torso
@onready var rleg = $RLeg
@onready var lleg = $LLeg
@onready var rarm = $RArm
@onready var larm = $LArm

@onready var rarmG = $"../gore/rarm"



@onready var limb_destructSound = $"../../sounds/limb_destruct"

#HEALTH

var speed = 150

var torsoLIVE = true
var headLIVE = true
var rarmLIVE = true
var larmLIVE = true
var rlegLIVE = true
var llegLIVE = true

var death = false

func _physics_process(delta):
	_rotation_sprite()
	limb_damage()
	limb_destruction()
	


func _rotation_sprite():
	var direction = Input.get_vector("A", "D", "W", "S")
	if direction.x < 0:
		head.flip_h = true
		torso.flip_h = true
		rleg.flip_h = true
		lleg.flip_h = true
		rarm.flip_h = true
		larm.flip_h = true
		rarmG.flip_h = true
	if direction.x > 0:
		head.flip_h = false
		torso.flip_h = false
		rleg.flip_h = false
		lleg.flip_h = false
		rarm.flip_h = false
		larm.flip_h = false
		rarmG.flip_h = false

func limb_damage():
	if Global.rarmHP <= 80:
		rarmG.play("dam1")
	if Global.rarmHP <= 50:
		rarmG.play("dam2")
	if Global.rarmHP <= 30:
		rarmG.play("dam3")
	if Global.rarmHP <= 0:
		rarmG.play("halfed")
		
	

func limb_destruction():
	if Global.rarmHP <= 0 && rarmLIVE:
		rarm.visible = false
		limb_destructSound.play()
		rarmLIVE = false
	if Global.larmHP <= 0 && larmLIVE:
		larm.visible = false
		limb_destructSound.play()
		larmLIVE = false
	if Global.rlegHP <= 0 && rlegLIVE:
		rleg.visible = false
		limb_destructSound.play()
		rlegLIVE = false
	if Global.llegHP <= 0 && llegLIVE:
		lleg.visible = false
		limb_destructSound.play()
		llegLIVE = false
	
	## LEGS
	if llegLIVE == false:
		speed = 50
		laying()
	if rlegLIVE == false:
		speed = 50
		laying()
	if rlegLIVE == false && llegLIVE == false:
		speed = 0


func laying():
	layouts.rotation = 80
