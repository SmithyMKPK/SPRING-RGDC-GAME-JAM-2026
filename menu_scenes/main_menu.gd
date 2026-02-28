## The main menu
class_name MainMenu extends Control

## A reference to the options menu
@onready var _options_menu: Control = $"CenterContainer/Options Menu"

## A reference to the level select menu
@onready var _level_select_menu: Control = $"CenterContainer/Level Selection Menu"


## Acts on the play button being pressed
func _on_play_button_pressed() -> void:
	self._level_select_menu.visible = true

## Acts on the options button being pressed
func _on_options_button_pressed() -> void:
	self._options_menu.visible = true

# NOTE: We can either make something goofy here, remove it, wtv
## Acts on the quit button being pressed
func _on_quit_button_pressed() -> void:
	pass # Replace with function body.
