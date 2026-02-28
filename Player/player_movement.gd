class_name PlayerMovement extends CharacterBody2D

@export var speed: float = 150;
@export var dead_zone: float = .06;

@export var animation_tree: AnimationTree;

@export var sprite: Node2D

var facing_left: bool = true:
	set(value):
		if value == facing_left:
			return;
		facing_left = value;
		self.sprite.scale.x *= sign(self.sprite.scale.x) * 1 if facing_left else -1;

## Sets the initial position of the player upon a level starting
func set_initial_position(initial_position: Vector2) -> void:
	self.position = initial_position

func _physics_process(_delta: float) -> void:
	var input_direction = Vector2(
		Input.get_action_strength("Move Right") - Input.get_action_strength("Move Left"),
		Input.get_action_strength("Move Down") - Input.get_action_strength("Move Up")
	).normalized()
	if input_direction.length() < self.dead_zone:
		input_direction = Vector2.ZERO;
	
	self.animation_tree.set("parameters/conditions/walking", input_direction != Vector2.ZERO);
	
	if input_direction.x < 0:
		self.facing_left = true;
	if input_direction.x > 0:
		self.facing_left = false;
	
	velocity = input_direction * self.speed;
	self.move_and_slide()
