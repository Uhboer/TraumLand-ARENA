extends Node2D
@onready var button = $Button


func _on_button_pressed():
	get_tree().change_scene_to_file("res://csenes/world.tscn")
