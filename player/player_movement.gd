class_name PlayerMovement extends CharacterBody2D

@export var speed: float = 150;
@export var dead_zone: float = .06;

@export var animation_tree: AnimationTree;

@export var wall_walk_tolerance: float;

var wall_walk_timer: float;

## A direct reference to the initial position the player has in a level
var initial_pos: Vector2

@export var sprite: Node2D

var facing_left: bool = true:
	set(value):
		if value == facing_left:
			return;
		facing_left = value;
		self.sprite.scale.x *= sign(self.sprite.scale.x) * 1 if facing_left else -1;

## Sets the initial position of the player upon a level starting
func set_initial_position(initial_position: Vector2) -> void:
	self.respawning = false;
	self.position = initial_position
	self.initial_pos = initial_position
#
func _process(_delta: float) -> void:
	if self.respawning:
		var playback: AnimationNodeStateMachinePlayback = self.animation_tree.get("parameters/playback");
		#print(playback.get_current_node())
		if playback.get_current_node() == "End":
			self.animation_tree.set("parameters/conditions/dead", false);
			playback.travel("idle");
			self.respawning = false;
			self.position = self.initial_pos;

func _physics_process(delta: float) -> void:
	if self.respawning:
		return;
	
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
	var collided: bool = self.move_and_slide();
	if collided:
		self.wall_walk_timer -= delta;
	else:
		self.wall_walk_timer = wall_walk_tolerance;
	if self.wall_walk_timer < 0:
		self.dead();

var respawning: bool = false;

func dead() -> void:
	self.wall_walk_timer = 0;
	self.respawning = true;
	self.animation_tree.set("parameters/conditions/dead", true);
	#self.position = initial_pos;
