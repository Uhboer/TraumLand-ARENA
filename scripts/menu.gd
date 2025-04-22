extends Control
@onready var play = $play
@onready var click = $sounds/click
@onready var hover = $sounds/hover
@onready var make = $make
@onready var age = $make/age
@onready var readyfordeath = $make/readyfordeath
@onready var playername = $make/name
@onready var accept = $sounds/accept
@onready var reject = $sounds/reject


func _ready():
	pass

func _on_button_pressed():
	click.play()
	play.visible = false
	make.visible = true


func _on_button_mouse_entered():
	hover.play()


func _on_readyfordeath_pressed():
	if (Global.playername != "Nameless" && Global.playername != "") && (Global.age > str(14)):
		click.play()
		get_tree().change_scene_to_file("res://csenes/world.tscn")
	else:
		reject.play()


func _on_readyfordeath_mouse_entered():
	hover.play()


func _on_name_text_submitted(new_text):
	Global.playername = playername.text
	accept.play()

func _on_name_text_changed(new_text):
	Global.playername = playername.text 


func _on_age_text_changed(new_text):
	Global.age = age.text


func _on_age_text_submitted(new_text):
	Global.age = age.text
	accept.play()
