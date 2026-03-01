extends Control

## The grid container that has buttons to each level
@export var _level_container: Container;

@export var button_preset: PackedScene;

@export var levels: Array[String] = [];

@export var _menu_sfx: AudioStreamPlayer

func _ready() -> void:
	var current_button_level: int = 0;
	
	for level: String in self.levels:
		
		var button: Button = self.button_preset.instantiate();
		button.text = "level %s" % [current_button_level + 1];
		
		self._level_container.add_child(button);
		
		button.pressed.connect(
			Callable(self, "_on_level_button_pressed").bind(current_button_level))
		current_button_level += 1

## Acts on a level being pressed
func _on_level_button_pressed(level_number: int) -> void:
	self._menu_sfx.play()
	self.get_tree().change_scene_to_file(self.levels[level_number]);

## Acts on the back button getting presses
func _on_back_button_pressed() -> void:
	self.visible = false
	self._menu_sfx.play()
