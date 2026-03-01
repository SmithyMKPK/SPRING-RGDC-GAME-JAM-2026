extends ColorRect

@export var fade_speed: float;

func _process(delta: float) -> void:
	self.modulate.a -= delta * fade_speed;
