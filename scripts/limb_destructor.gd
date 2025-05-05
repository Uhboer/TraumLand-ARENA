extends Node2D


@export var limb = "lleg"

@onready var debug_text = $debug_text

@onready var bloody = $icon/bloody

@export var damage = 100

@onready var timer = $Timer



func _ready():
	debug_text.text = "dest: "+limb

func _on_area_entered(area : Area2D):
	if not is_multiplayer_authority(): return
	if area.name == "player_collider":
		Global.player_damaged.emit(limb, damage)
		timer.wait_time = 2.0
