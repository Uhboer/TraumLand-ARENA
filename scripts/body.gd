extends Node2D

@onready var layouts = $".."

@onready var head = $Head
@onready var torso = $Torso
@onready var rleg = $RLeg
@onready var lleg = $LLeg
@onready var rarm = $RArm
@onready var larm = $LArm

@onready var rarmG = $"../gore/rarm"
@onready var larmG = $"../gore/larm"
@onready var llegG = $"../gore/lleg"
@onready var rlegG = $"../gore/rleg"
@onready var torsoG = $"../gore/torso"
@onready var headG = $"../gore/head"

@onready var inv = $"../../Inv"

@onready var collider = $"../../collider"
@onready var hitbox = $"../../hitbox"

@onready var limb_destructSound = $"../../sounds/limb_destruct"

var damage_area = null

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
	
	if inv.time_left == 0:
		taking_damage()
		inv.start()


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
		larmG.flip_h = true
		llegG.flip_h = true
		rlegG.flip_h = true
		torsoG.flip_h = true
		headG.flip_h = true
	if direction.x > 0:
		head.flip_h = false
		torso.flip_h = false
		rleg.flip_h = false
		lleg.flip_h = false
		rarm.flip_h = false
		larm.flip_h = false
		rarmG.flip_h = false
		larmG.flip_h = false
		llegG.flip_h = false
		rlegG.flip_h = false
		torsoG.flip_h = false
		headG.flip_h = false

func limb_damage():
	if Global.rarmHP > 80:
		rarmG.play("none")
	if Global.rarmHP <= 80:
		rarmG.play("dam1")
	if Global.rarmHP <= 50:
		rarmG.play("dam2")
	if Global.rarmHP <= 30:
		rarmG.play("dam3")
	if Global.rarmHP <= 0:
		rarmG.play("halfed")
	
	if Global.larmHP > 80:
		larmG.play("none")
	if Global.larmHP <= 80:
		larmG.play("dam1")
	if Global.larmHP <= 50:
		larmG.play("dam2")
	if Global.larmHP <= 30:
		larmG.play("dam3")
	if Global.larmHP <= 0:
		larmG.play("halfed")
	
	if Global.llegHP > 80:
		llegG.play("none")
	if Global.llegHP <= 80:
		llegG.play("dam1")
	if Global.llegHP <= 50:
		llegG.play("dam2")
	if Global.llegHP <= 30:
		llegG.play("dam3")
	if Global.llegHP <= 0:
		llegG.play("halfed")
		
	if Global.rlegHP > 80:
		llegG.play("none")
	if Global.rlegHP <= 80:
		rlegG.play("dam1")
	if Global.rlegHP <= 50:
		rlegG.play("dam2")
	if Global.rlegHP <= 30:
		rlegG.play("dam3")
	if Global.rlegHP <= 0:
		rlegG.play("halfed")
	
	if Global.torsoHP > 280:
		torsoG.play("none")
	if Global.torsoHP <= 280:
		torsoG.play("dam1")
	if Global.torsoHP <= 250:
		torsoG.play("dam2")
	if Global.torsoHP <= 200:
		torsoG.play("dam3")
	if Global.torsoHP <= 150:
		torsoG.play("dam4")
	if Global.torsoHP <= 100:
		torsoG.play("dam5")
	if Global.torsoHP <= 50:
		torsoG.play("dam6")
	if Global.torsoHP <= 0:
		torsoG.play("destroyed")
	
	if Global.headHP > 180:
		headG.play("none")
	if  Global.headHP <= 180:
		headG.play("dam1")
	if  Global.headHP <= 150:
		headG.play("dam2")
	if  Global.headHP <= 100:
		headG.play("dam3")
	if  Global.headHP <= 80:
		headG.play("dam4")
	if  Global.headHP <= 50:
		headG.play("dam5")
	if Global.headHP <= 0:
		head.visible = false
		headG.play("halfed")
	
	
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
	hitbox.rotation = 80
	collider.position.y = 0
	collider.scale.x = 2


func taking_damage():
	pass


func _on_hitbox_area_entered(area):
	area = damage_area


func _on_hitbox_area_exited(area):
	if area == damage_area:
		damage_area = null
