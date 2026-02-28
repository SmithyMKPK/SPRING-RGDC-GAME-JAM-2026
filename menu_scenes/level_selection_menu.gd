extends Control

## The grid container that has buttons to each level
@export var _level_container: GridContainer

func _ready() -> void:
	var current_button_level: int = 1
	
	for button: Button in self._level_container.get_children():
		button.pressed.connect(
			Callable(self, "_on_level_button_pressed").bind(current_button_level))
		current_button_level += 1

## Acts on a level being pressed
func _on_level_button_pressed(level_number: int) -> void:
	match level_number:
		1:
			get_tree().change_scene_to_file("res://levels/one/level_one_concept.tscn")
		2:
			get_tree().change_scene_to_file("res://levels/two/level_two_concept.tscn")
		3:
			get_tree().change_scene_to_file("res://levels/three/level_three_concept.tscn")

## Acts on the back button getting presses
func _on_back_button_pressed() -> void:
	self.visible = false
