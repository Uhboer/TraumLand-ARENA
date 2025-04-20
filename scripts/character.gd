extends CharacterBody2D

@onready var animLleg = $layouts/body/LLeg
@onready var animRleg = $layouts/body/RLeg

@onready var body = $layouts/body

var speed = 150

func _physics_process(delta):
	var direction = Input.get_vector("A", "D", "W", "S")
	if direction:
		animLleg.play("Run")
		animRleg.play("Run")
		velocity = direction * speed
	else:
		velocity = Vector2(0, 0)
		animLleg.play("Idle")
		animRleg.play("Idle")
	move_and_slide()
