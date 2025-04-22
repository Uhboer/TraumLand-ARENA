extends Control
@onready var button = $Button
@onready var click = $sounds/click
@onready var hover = $sounds/hover


func _on_button_pressed():
	click.play()
	get_tree().change_scene_to_file("res://csenes/world.tscn")


func _on_button_mouse_entered():
	hover.play()
