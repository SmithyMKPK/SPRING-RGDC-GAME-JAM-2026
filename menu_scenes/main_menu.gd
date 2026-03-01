## The main menu
class_name MainMenu extends Control

## A reference to the options menu
@onready var _options_menu: Control = $"CenterContainer/Options Menu"

## A reference to the level select menu
@onready var _level_select_menu: Control = $"CenterContainer/Level Selection Menu"

@onready var _menu_sfx: AudioStreamPlayer = $"Menu sfx"

## Acts on the play button being pressed
func _on_play_button_pressed() -> void:
	self._level_select_menu.visible = true
	self._menu_sfx.play()

## Acts on the options button being pressed
func _on_options_button_pressed() -> void:
	self._options_menu.visible = true
	self._menu_sfx.play()
