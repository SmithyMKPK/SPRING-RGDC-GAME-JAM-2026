@tool
extends Node2D
class_name LightSource

@export var strength: float = 300:
	set(value):
		strength = value;
		self.global_light_material.set("shader_parameter/max_distance", strength);
@export var global_light_material: ShaderMaterial;

func _ready() -> void:
	if !Engine.is_editor_hint():
		self.strength = self.strength;

func _process(_delta: float) -> void:
	self.global_light_material.set("shader_parameter/vision_light_source", self.global_position);
