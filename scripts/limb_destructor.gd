extends Node2D


@export var limb = "lleg"

@onready var dam = $dam

@onready var debug_text = $debug_text

@onready var bloody = $icon/bloody

@export var damage = 100

@export var type = "slash"

@onready var timer = $Timer


func _ready():
	debug_text.text = "dest: "+limb+"\n"+"type: "+type

func _on_area_entered(area : Area2D):
	if not is_multiplayer_authority(): return
	if area.name == "player_collider":
		dam.play()
		bloody.visible = true
		timer.wait_time = 2.0


func _on_body_entered(body: Node2D) -> void:
	if multiplayer.is_server():
		var node = body.get_node("./layouts/body")
		node.rpc("rpc_take_damage", limb, damage, type)
