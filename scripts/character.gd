extends CharacterBody2D

@onready var animLleg = $layouts/body/LLeg
@onready var animRleg = $layouts/body/RLeg

@onready var body = $layouts/body

@onready var combatModeSound = $sounds/combatmode
@onready var combatModeOffSound = $sounds/combatmodeoff

var isEnable = false 

func _physics_process(delta):
	var direction = Input.get_vector("A", "D", "W", "S")
	if direction:
		animLleg.play("Run")
		animRleg.play("Run")
		velocity = direction * body.speed
	else:
		velocity = Vector2(0, 0)
		animLleg.play("Idle")
		animRleg.play("Idle")
	move_and_slide()
	combatmode() 

func combatmode():
	if Input.is_action_just_released("F"):
		isEnable = !isEnable  # Инвертируем значение
		if isEnable:
			combatModeSound.play()
		else:
			combatModeOffSound.play()
