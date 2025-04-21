extends Node2D

@onready var player = $"../character"

func _on_body_entered(body: Node2D):
	if body.name == "character":
		Global.rarmHP = 0
