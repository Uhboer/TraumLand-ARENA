extends Node2D

@onready var player = $"../character"

@onready var playerbody = $layouts/body

func _on_body_entered(body: Node2D):
	if body.name == "character":
		playerbody.rarmHP -= 100
