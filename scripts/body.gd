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
@onready var death_shader = $"../../Camera2D/CanvasLayer/deathShader"


@onready var player_collider = $"../../player_collider"
@onready var player_hitbox = $"../../player_hitbox"

@onready var torso_dest = $"../../sounds/torso_dest"
@onready var head_dest = $"../../sounds/head_dest"
@onready var bone_destructSound = $"../../sounds/bone_destruct"
@onready var limb_destructSound = $"../../sounds/limb_destruct"
@onready var taking_dam = $"../../sounds/taking_dam"
@onready var heart_slow = $"../../sounds/heart_slow"
@onready var heart_bad = $"../../sounds/heart_bad"

var Ambibass = AudioServer.get_bus_index("Ambience")
var Soundbass = AudioServer.get_bus_index("Sounds")

@onready var limb_list = [
	head,
	torso,
	rleg,
	lleg,
	rarm,
	larm
]

@onready var bone_list = [
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

var torsoLIVEBone = true
var headLIVEBone = true
var rarmLIVEBone = true
var larmLIVEBone = true
var rlegLIVEBone = true
var llegLIVEBone = true

var lay = false
var cangetup = true

var pain = 0.0

var deathcomeslowe = 0
var char_death = false

func _physics_process(delta):
	_rotation_sprite()
	limb_damage()
	limb_destruction()
	painSystem()
	death_checkout()

func _ready() -> void:
	head.set_meta("hp", Global.headHP)
	torso.set_meta("hp", Global.torsoHP)
	rleg.set_meta("hp", Global.rlegHP)
	lleg.set_meta("hp", Global.llegHP)
	rarm.set_meta("hp", Global.rarmHP)
	larm.set_meta("hp", Global.larmHP)

	head.set_meta("bone", Global.headbone)
	torso.set_meta("bone", Global.torsobone)
	rleg.set_meta("bone", Global.rlegbone)
	lleg.set_meta("bone", Global.llegbone)
	rarm.set_meta("bone", Global.rarmbone)
	larm.set_meta("bone", Global.larmbone)

@rpc("any_peer", "call_local")
func rpc_take_damage(limb, damage, type):
	take_damage(limb, damage, type)

@rpc("any_peer", "call_local")
func take_damage(part, damage, type):
	if part == "lleg" && type == "slash" && lleg.get_meta("hp") > 0:
		lleg.set_meta("hp", lleg.get_meta("hp") - damage)
	if part == "rleg" && type == "slash" && rleg.get_meta("hp") > 0:
		rleg.set_meta("hp", rleg.get_meta("hp") - damage)
	if part == "rarm" && type == "slash" && rarm.get_meta("hp") > 0:
		rarm.set_meta("hp", rarm.get_meta("hp") - damage)
	if part == "larm" && type == "slash" && larm.get_meta("hp") > 0:
		larm.set_meta("hp", larm.get_meta("hp") - damage)
	if part == "torso" && type == "slash" && torso.get_meta("hp") > 0:
		torso.set_meta("hp", torso.get_meta("hp") - damage)
	if part == "head" && type == "slash" && head.get_meta("hp") > 0:
		head.set_meta("hp", head.get_meta("hp") - damage)

	if part == "lleg" && type == "blunt" && lleg.get_meta("hp") > 0 && lleg.get_meta("bone") > 0:
		lleg.set_meta("hp", lleg.get_meta("hp") - damage / 2)
		lleg.set_meta("bone", lleg.get_meta("bone") - damage * 1.3)
	if part == "rleg" && type == "blunt" && rleg.get_meta("hp") > 0 && rleg.get_meta("bone") > 0:
		rleg.set_meta("hp", rleg.get_meta("hp") - damage / 2)
		rleg.set_meta("bone", rleg.get_meta("bone") - damage * 1.3)
	if part == "rarm" && type == "blunt" && rarm.get_meta("hp") > 0 && rarm.get_meta("bone") > 0:
		rarm.set_meta("hp", rarm.get_meta("hp") - damage / 2)
		rarm.set_meta("bone", rarm.get_meta("bone") - damage * 1.3)
	if part == "larm" && type == "blunt" && larm.get_meta("hp") > 0 && larm.get_meta("bone") > 0:
		larm.set_meta("hp", larm.get_meta("hp") - damage / 2)
		larm.set_meta("bone", larm.get_meta("bone") - damage * 1.3)
	if part == "torso" && type == "blunt" && torso.get_meta("hp") > 0 && torso.get_meta("bone") > 0:
		torso.set_meta("hp", torso.get_meta("hp") - damage / 2)
		torso.set_meta("bone", torso.get_meta("bone") - damage * 1.3)
	if part == "head" && type == "blunt" && head.get_meta("hp") > 0 && head.get_meta("bone") > 0:
		head.set_meta("hp", head.get_meta("hp") - damage / 2)
		head.set_meta("bone", head.get_meta("bone") - damage * 1.3)

func _rotation_sprite():
	var direction
	
	if is_multiplayer_authority():
		direction = Input.get_vector("A", "D", "W", "S")
	
	if !direction:
		return
		
	if direction.x < 0 && char_death == false:
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
	if direction.x > 0 && char_death == false:
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
	
	##VITALS
	if head.get_meta("hp") <= 0 && headLIVE:
		head.visible = false
		head_dest.play()
		headLIVE = false
		pain += 50
	
	if torso.get_meta("hp") <= 0 && torsoLIVE:
		torso_dest.play()
		torsoLIVE = false
		pain += 50
	
	
	## BONES
	if rarm.get_meta("bone") <= 0 && rarmLIVEBone:
		bone_destructSound.play()
		rarmLIVEBone = false
		pain += 20
	if larm.get_meta("bone") <= 0 && larmLIVEBone:
		bone_destructSound.play()
		larmLIVEBone = false
		pain += 20
	if rleg.get_meta("bone") <= 0 && rlegLIVEBone:
		bone_destructSound.play()
		rlegLIVEBone = false
		pain += 20
	if lleg.get_meta("bone") <= 0 && llegLIVEBone:
		bone_destructSound.play()
		llegLIVEBone = false
		pain += 20
	
	
	
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
	if lay == false:
		layouts.rotation_degrees = 90
		player_hitbox.rotation_degrees = 90
		player_collider.position.y = -13
		player_collider.scale.x = 2
		lay = true
	if Input.is_action_just_pressed("V") && cangetup && lay:
		layouts.rotation_degrees = 0
		player_hitbox.rotation_degrees = 0
		player_collider.position.y = 0
		player_collider.scale.x = 1
		lay == false

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
			

func death_checkout():
	print(pain)
	if pain >= 100:
		death()


func death():
	death_shader.visible = true
	char_death = true
	death_shader.get_material().set_shader_parameter("intensity", deathcomeslowe)
	speed = 0
	AudioServer.set_bus_volume_db(Ambibass, -80)
	AudioServer.set_bus_volume_db(Soundbass, -80)
	if deathcomeslowe <= 1.0:
		deathcomeslowe += 0.1





func _on_player_collider_area_entered(area: Area2D) -> void:
	if not is_multiplayer_authority(): return
	area = damage_area
	taking_dam.play()
	pain += 3


func _on_player_collider_area_exited(area: Area2D) -> void:
	if not is_multiplayer_authority(): return
	if area == damage_area:
		damage_area = null
