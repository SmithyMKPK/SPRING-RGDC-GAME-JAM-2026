extends Sprite2D
class_name Waves

@export var scale_fac: float = .01;
@export var move_with_self: Node3D;

func _process(_delta: float) -> void:
	self.move_with_self.global_position.x = self.global_position.x * self.scale_fac;
	self.move_with_self.global_position.z = self.global_position.y * self.scale_fac;
