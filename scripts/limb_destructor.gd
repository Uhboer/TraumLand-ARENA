extends Node2D

@onready var player = $"../character"


func _on_area_2d_body_entered(body):
	if body:
		var playerbody = player.get_child(body)
		playerbody.rarmHP = 0
