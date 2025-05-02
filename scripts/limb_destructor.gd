extends Node2D

@onready var player = $"../character"

@export var limb = "lleg"

@onready var debug_text = $debug_text

@onready var bloody = $icon/bloody

@export var damage = 100

@onready var timer = $Timer




func _ready():
	debug_text.text = "dest: "+limb

func _on_area_entered(area):
	if area.name == "hitbox":
		if limb == "lleg" && Global.llegHP > 0:
			Global.llegHP -= damage
			bloody.visible = true
			timer.wait_time = 2.0
		if limb == "rleg" && Global.rlegHP > 0:
			Global.rlegHP -= damage
			bloody.visible = true
			timer.wait_time = 2.0
		if limb == "rarm" && Global.rarmHP > 0:
			Global.rarmHP -= damage
			bloody.visible = true
			timer.wait_time = 2.0
		if limb == "larm" && Global.larmHP > 0:
			Global.larmHP -= damage
			bloody.visible = true
			timer.wait_time = 2.0
		if limb == "torso" && Global.torsoHP > 0:
			Global.torsoHP -= damage
			bloody.visible = true
			timer.wait_time = 2.0
		if limb == "head" && Global.headHP > 0:
			Global.headHP -= damage
			bloody.visible = true
			timer.wait_time = 2.0
