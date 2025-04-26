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
@onready var plus = $make/plus
@onready var minus = $make/minus
@onready var age_text = $make/age_text
@onready var readyS = $sounds/ready
@onready var typing = $sounds/typing


func _ready():
	pass

func _physics_process(delta):
	Global.age = age.value
	age_text.text = "AGE: " + str(int(Global.age))

func _on_button_pressed():
	click.play()
	play.visible = false
	make.visible = true


func _on_button_mouse_entered():
	hover.play()


func _on_readyfordeath_pressed():
	if (Global.playername != "Nameless" && Global.playername != ""):
		readyfordeath.disabled = true
		readyS.play()
		await readyS.finished
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
	typing.play()


func _on_plus_pressed():
	accept.play()
	age.value += 1


func _on_minus_pressed():
	accept.play()
	age.value -= 1


func _on_plus_mouse_entered():
	hover.play()


func _on_minus_mouse_entered():
	hover.play()
