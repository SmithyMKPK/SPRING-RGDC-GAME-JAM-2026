class_name FollowCamera extends Camera2D

@export var delta_coefficient: float = 3.25;
@export var internal_global_position: Vector2;
@export var target_light_node: LightNode:
	set(value):
		if value == target_light_node:
			return;
		if target_light_node != null:
			target_light_node.exit();
		target_light_node = value;
		if target_light_node != null:
			target_light_node.enter();
			
@export var reset_on_phys_interpolation: bool = true;
@export var snap_scale: float = 1;

func _ready() -> void:
	self.internal_global_position = self.global_position;
	
	var f = func(camera: FollowCamera):
		camera.internal_global_position = Player.current_position;
	f.call_deferred(self);

func _process(delta: float) -> void:
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
