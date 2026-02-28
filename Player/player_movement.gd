class_name PlayerMovement extends CharacterBody2D


const SPEED: float = 150.0

## Sets the initial position of the player upon a level starting
func set_initial_position(initial_position: Vector2) -> void:
	self.position = initial_position

func _physics_process(_delta: float) -> void:
	var input_direction = Vector2(
		Input.get_action_strength("Move Right") - Input.get_action_strength("Move Left"),
		Input.get_action_strength("Move Down") - Input.get_action_strength("Move Up")
	).normalized()
	
	velocity = input_direction * SPEED
	move_and_slide()
