class_name FollowCamera extends Camera2D

@export var spawn_grace_timer: Timer;

@export var delta_coefficient: float = 3.25;
@export var internal_global_position: Vector2;
@export var target_light_node: Node2D:
	set(value):
		if value == target_light_node:
			return;
		if target_light_node != null:
			if target_light_node is LightNode:
				target_light_node.exit();
		target_light_node = value;
		if target_light_node != null:
			if target_light_node is LightNode:
				target_light_node.enter();
			
@export var reset_on_phys_interpolation: bool = true;
@export var snap_scale: float = 1;

var last_light_strength: float = 0;
@export var light_source: LightSource;

func _ready() -> void:
	self.internal_global_position = self.global_position;
	
	_on_player_spawn.call_deferred();
	Player.get_respawn_signal().connect(self._on_player_spawn);
	Player.get_death_signal().connect(self._on_player_death);

func _on_player_death() -> void:
	self.last_light_strength = self.light_source.strength;
	self.light_source.strength = 60;

func _on_player_spawn() -> void:
	$ColorRect.modulate.a = 1;
	self.internal_global_position = Player.current_position;
	self.spawn_grace_timer.start();
	if self.last_light_strength != 0:
		self.light_source.strength = self.last_light_strength;

func _process(delta: float) -> void:
	if !self.spawn_grace_timer.is_stopped():
		delta = 0;
	var target_position: Vector2 = self._get_target_global_position();

	self.internal_global_position = target_position.lerp(
		self.internal_global_position,
		exp(-delta * self.delta_coefficient)
	);
	
	self.global_position = round(self.internal_global_position / snap_scale) * snap_scale;

func _get_target_global_position() -> Vector2:
	if self.target_light_node == null:
		return self.internal_global_position;
	return self.target_light_node.global_position;
