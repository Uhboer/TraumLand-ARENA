extends CharacterBody2D

@onready var animLleg = $layouts/body/LLeg
@onready var animRleg = $layouts/body/RLeg

@onready var body = $layouts/body

@onready var combatModeSound = $sounds/combatmode
@onready var combatModeOffSound = $sounds/combatmodeoff

@onready var nickname = $nickname
@onready var faith = $faith
@onready var walk = $sounds/walk

@onready var camera = $Camera2D

var faith_index
var nicknam

@onready var faiths = [load("res://sprites/faith/angast.png"), load("res://sprites/faith/chaos.png")]

var isEnable = false 


func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())


func _ready() -> void:
	nickname.text = Global.playername
	if Global.faith == "angast":
		faith_index = 0
	else: if Global.faith == "chaos":
		faith_index = 1
	faith.set_meta("faith_type", faith_index)
	
	if not is_multiplayer_authority(): return
	camera.make_current()
	
func _process(delta: float) -> void:
	faith.texture = faiths[faith.get_meta("faith_type")]

func _physics_process(delta):
	if not is_multiplayer_authority(): return
		
	var direction = Input.get_vector("A", "D", "W", "S")
	if direction:
		animLleg.play("Run")
		animRleg.play("Run")
		velocity = direction * body.speed
	else:
		velocity = Vector2(0, 0)
		animLleg.play("Idle")
		animRleg.play("Idle")
	
	if velocity && !walk.playing:
		walk.play()
	
	move_and_slide()
	combatmode() 

func combatmode():
	if not is_multiplayer_authority(): return
	if Input.is_action_just_released("F"):
		isEnable = !isEnable
		if isEnable:
			combatModeSound.play()
		else:
			combatModeOffSound.play()
