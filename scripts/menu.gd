extends Node2D
@onready var button = $Button
@onready var click = $sounds/click
@onready var hover = $sounds/hover


func _on_button_pressed():
	get_tree().change_scene_to_file("res://csenes/world.tscn")
	click.play()


func _on_button_mouse_entered():
	hover.play()
