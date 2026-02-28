extends Node2D

func _ready() -> void:
	Player.enter_level(self.global_position)
