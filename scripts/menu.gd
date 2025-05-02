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
@onready var plus = $make/age_text/plus
@onready var minus = $make/age_text/minus
@onready var age_text = $make/age_text
@onready var readyS = $sounds/ready
@onready var typing = $sounds/typing
@onready var chaos = $make/faith/chaos
@onready var angast = $make/faith/angast
@onready var great = $sounds/great
@onready var sup = $make/name/sup
@onready var sdown = $make/name/sdown
@onready var charactername = $make/name/charactername


@onready var angastS = $make/faith/Angast
@onready var chaosS = $make/faith/Chaos


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
	if Global.playername != "Nameless" && Global.playername != "" && Global.faith != "":
		readyfordeath.disabled = true
		readyS.play()
		await readyS.finished
		get_tree().change_scene_to_file("res://csenes/world.tscn")
	else:
		reject.play()


func _on_readyfordeath_mouse_entered():
	hover.play()


func _on_name_text_submitted(new_text):
	if playername.text != "" && len(playername.text) <= 10:
		Global.playername = playername.text
		charactername.text = "Name: " + Global.playername
		great.play()
		sup.visible = true
		sdown.visible = true
	else:
		reject.play()

func _on_name_text_changed(new_text):
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


func _on_chaos_pressed():
	click.play()
	chaosS.visible = true
	angastS.visible = false
	chaos.disabled = true
	angast.disabled = false
	Global.faith = "chaos"


func _on_angast_pressed():
	click.play()
	chaosS.visible = false
	angastS.visible = true
	chaos.disabled = false
	angast.disabled = true
	Global.faith = "angast"


func _on_chaos_mouse_entered():
	hover.play()


func _on_angast_mouse_entered():
	hover.play()
