extends Node2D

@onready var player = $"../character"

@export var limb = "lleg"

@onready var debug_text = $debug_text

@onready var bloody = $icon/bloody

@export var damage = 100

@onready var timer = $Timer




func _ready():
	debug_text.text = "destruct: "+limb

func _on_body_entered(body: Node2D):
	if body.name == "character":
		if limb == "lleg":
			Global.llegHP -= damage
			bloody.visible = true
			timer.wait_time = 2.0
		if limb == "rleg":
			Global.rlegHP -= damage
			bloody.visible = true
			timer.wait_time = 2.0
		if limb == "rarm":
			Global.rarmHP -= damage
			bloody.visible = true
			timer.wait_time = 2.0
		if limb == "larm":
			Global.larmHP -= damage
			bloody.visible = true
			timer.wait_time = 2.0
