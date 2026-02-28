extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(_delta: float) -> void:
	var input_direction = Vector2(
		Input.get_action_strength("Move Right") - Input.get_action_strength("Move Left"),
		Input.get_action_strength("Move Down") - Input.get_action_strength("Move Up")
	).normalized()
	
	velocity = input_direction * SPEED
	move_and_slide()
