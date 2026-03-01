extends CanvasLayer

@export var main_menu_scene: String

func _ready() -> void:
	self.visible = false

func _on_restart_level_button_pressed() -> void:
	self.visible = false
	get_tree().reload_current_scene();

func _on_main_menu_button_pressed() -> void:
	self.visible = false
	self.get_tree().change_scene_to_file(self.main_menu_scene)
	Player.in_level = false
