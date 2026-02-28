## The area that signifies that a level has ended
class_name EndPoint extends Area2D

## Emitted when the end point is crossed
signal finished_level

## Acts on whenever something enters the end point's body
func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		self.finished_level.emit()
