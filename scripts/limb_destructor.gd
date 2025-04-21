extends Node2D

@onready var player = $"../character"

@export var limb = "lleg"

@onready var debug_text = $debug_text

func _physics_process(delta):
	debug_text.text = "destruct: "+limb

func _on_body_entered(body: Node2D):
	if body.name == "character":
		if limb == "lleg":
			Global.llegHP -= 100
		if limb == "rleg":
			Global.rlegHP -= 100
		if limb == "rarm":
			Global.rarmHP -= 100
		if limb == "larm":
			Global.larmHP -= 100
