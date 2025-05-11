extends Node2D

@onready var char = $"../.."
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

@onready var pain_shader = $"../../Camera2D/CanvasLayer/painShader"


@onready var player_collider = $"../../player_collider"
@onready var player_hitbox = $"../../player_hitbox"

@onready var limb_destructSound = $"../../sounds/limb_destruct"
@onready var taking_dam = $"../../sounds/taking_dam"
@onready var heart_slow = $"../../sounds/heart_slow"
@onready var heart_bad = $"../../sounds/heart_bad"

@onready var limb_list = [
	head,
	torso,
	rleg,
	lleg,
	rarm,
	larm
]

@onready var damage_list = [
	headG,
	torsoG,
	rlegG,
	llegG,
	rarmG,
	larmG,
]

var damage_area = null

#HEALTH

var speed = 150

var torsoLIVE = true
var headLIVE = true
var rarmLIVE = true
var larmLIVE = true
var rlegLIVE = true
var llegLIVE = true

var pain = 0.0

var death = false

func _physics_process(delta):
	_rotation_sprite()
	limb_damage()
	limb_destruction()
	painSystem()

func _ready() -> void:
	head.set_meta("hp", Global.headHP)
	torso.set_meta("hp", Global.torsoHP)
	rleg.set_meta("hp", Global.rlegHP)
	lleg.set_meta("hp", Global.llegHP)
	rarm.set_meta("hp", Global.rarmHP)
	larm.set_meta("hp", Global.larmHP)


@rpc("any_peer", "call_local")
func rpc_take_damage(limb, damage):
	take_damage(limb, damage)


@rpc("any_peer", "call_local")
func take_damage(part, damage):
	if part == "lleg" && lleg.get_meta("hp") > 0:
		lleg.set_meta("hp", lleg.get_meta("hp") - damage)
	if part == "rleg" && rleg.get_meta("hp") > 0:
		rleg.set_meta("hp", rleg.get_meta("hp") - damage)
	if part == "rarm" && rarm.get_meta("hp") > 0:
		rarm.set_meta("hp", rarm.get_meta("hp") - damage)
	if part == "larm" && larm.get_meta("hp") > 0:
		larm.set_meta("hp", larm.get_meta("hp") - damage)
	if part == "torso" && torso.get_meta("hp") > 0:
		torso.set_meta("hp", torso.get_meta("hp") - damage)
	if part == "head" && head.get_meta("hp") > 0:
		head.set_meta("hp", head.get_meta("hp") - damage)


func _rotation_sprite():
	var direction
	
	if is_multiplayer_authority():
		direction = Input.get_vector("A", "D", "W", "S")
	
	if !direction:
		return
		
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
	if rarm.get_meta("hp") > 80:
		rarmG.play("none")
	if rarm.get_meta("hp") <= 80:
		rarmG.play("dam1")
	if rarm.get_meta("hp") <= 50:
		rarmG.play("dam2")
	if rarm.get_meta("hp") <= 30:
		rarmG.play("dam3")
	if rarm.get_meta("hp") <= 0:
		rarmG.play("halfed")
	
	if larm.get_meta("hp") > 80:
		larmG.play("none")
	if larm.get_meta("hp") <= 80:
		larmG.play("dam1")
	if larm.get_meta("hp") <= 50:
		larmG.play("dam2")
	if larm.get_meta("hp") <= 30:
		larmG.play("dam3")
	if larm.get_meta("hp") <= 0:
		larmG.play("halfed")
	
	if lleg.get_meta("hp") > 80:
		llegG.play("none")
	if lleg.get_meta("hp") <= 80:
		llegG.play("dam1")
	if lleg.get_meta("hp") <= 50:
		llegG.play("dam2")
	if lleg.get_meta("hp") <= 30:
		llegG.play("dam3")
	if lleg.get_meta("hp") <= 0:
		llegG.play("halfed")
		
	if rleg.get_meta("hp") > 80:
		llegG.play("none")
	if rleg.get_meta("hp") <= 80:
		rlegG.play("dam1")
	if rleg.get_meta("hp") <= 50:
		rlegG.play("dam2")
	if rleg.get_meta("hp") <= 30:
		rlegG.play("dam3")
	if rleg.get_meta("hp") <= 0:
		rlegG.play("halfed")
	
	if torso.get_meta("hp") > 280:
		torsoG.play("none")
	if torso.get_meta("hp") <= 280:
		torsoG.play("dam1")
	if torso.get_meta("hp") <= 250:
		torsoG.play("dam2")
	if torso.get_meta("hp") <= 200:
		torsoG.play("dam3")
	if torso.get_meta("hp") <= 150:
		torsoG.play("dam4")
	if torso.get_meta("hp") <= 100:
		torsoG.play("dam5")
	if torso.get_meta("hp") <= 50:
		torsoG.play("dam6")
	if torso.get_meta("hp") <= 0:
		torsoG.play("destroyed")
	
	if head.get_meta("hp") > 180:
		headG.play("none")
	if head.get_meta("hp") <= 180:
		headG.play("dam1")
	if head.get_meta("hp") <= 150:
		headG.play("dam2")
	if head.get_meta("hp") <= 100:
		headG.play("dam3")
	if head.get_meta("hp") <= 80:
		headG.play("dam4")
	if head.get_meta("hp") <= 50:
		headG.play("dam5")
	if head.get_meta("hp") <= 0:
		head.visible = false
		headG.play("halfed")
	
	
func limb_destruction():	
	if rarm.get_meta("hp") <= 0 && rarmLIVE:
		rarm.visible = false
		limb_destructSound.play()
		rarmLIVE = false
		pain += 25
	if larm.get_meta("hp") <= 0 && larmLIVE:
		larm.visible = false
		limb_destructSound.play()
		larmLIVE = false
		pain += 25
	if rleg.get_meta("hp") <= 0 && rlegLIVE:
		rleg.visible = false
		limb_destructSound.play()
		rlegLIVE = false
		pain += 25
	if lleg.get_meta("hp") <= 0 && llegLIVE:
		lleg.visible = false
		limb_destructSound.play()
		llegLIVE = false
		pain += 25
	
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
	layouts.rotation_degrees = 90
	player_hitbox.rotation_degrees = 90
	player_collider.position.y = -13
	player_collider.scale.x = 2

func painSystem():	
	if not is_multiplayer_authority(): return
	pain_shader.get_material().set_shader_parameter("intensity", pain / 65)
	
	var firstpain = false
	
	if pain < 50:
		heart_slow.playing = false
	if pain >= 50 && heart_slow.playing == false:
		heart_slow.play()
		firstpain = true
		if heart_slow.playing == true && firstpain == true:
			heart_bad.play()
			firstpain = false
			

func _on_player_collider_area_entered(area: Area2D) -> void:
	if not is_multiplayer_authority(): return
	area = damage_area
	taking_dam.play()
	pain += 3


func _on_player_collider_area_exited(area: Area2D) -> void:
	if not is_multiplayer_authority(): return
	if area == damage_area:
		damage_area = null
