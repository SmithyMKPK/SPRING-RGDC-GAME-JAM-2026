
extends Node2D
class_name LightSource

var _light_exists: bool = false;

@export var strength: float = 300:
	set(value):
		strength = value;
		if self.global_light_material == null:
			return;
		self.global_light_material.set("shader_parameter/max_distance", strength);
@export var global_light_material: ShaderMaterial;

func _process(_delta: float) -> void:
	if self.global_light_material == null:
		return;
	if !self._light_exists:
		if !Engine.is_editor_hint():
			self.set_deferred("strength", self.strength);
		self._light_exists = true;
	self.global_light_material.set("shader_parameter/vision_light_source", self.global_position);
