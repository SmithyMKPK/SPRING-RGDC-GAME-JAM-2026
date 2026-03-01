extends Control

@export var main_menu_scene: PackedScene

func _on_restart_level_button_pressed() -> void:
	self.visible = false
	get_tree().reload_current_scene()

func _on_main_menu_button_pressed() -> void:
	self.visible = false
	get_tree().change_scene_to_packed(self.main_menu_scene)
