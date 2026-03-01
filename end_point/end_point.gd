## The area that signifies that a level has ended
class_name EndPoint extends Area2D

## Emitted when the end point is crossed
signal finished_level

@export var level: int;

var count = 60;

func _ready() -> void:
	$AnimatedSprite2D.frame = level - 1;

func _physics_process(_delta: float) -> void:
	count -= 1;
	if count < 0:
		self.monitoring = true;
	
## Acts on whenever something enters the end point's body
func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		self.finished_level.emit()
