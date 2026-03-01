## The main menu
class_name MainMenu extends Control

## A reference to the options menu
@onready var _options_menu: Control = $"CenterContainer/Options Menu"

## A reference to the level select menu
@onready var _level_select_menu: Control = $"CenterContainer/Level Selection Menu"

@export var main_focus_target: Control;
@export var default_button: Button;

func _ready() -> void:
	self._options_menu.visibility_changed.connect(self._focus_change);
	self._level_select_menu.visibility_changed.connect(self._focus_change);

## Acts on the play button being pressed
func _on_play_button_pressed() -> void:
	self._level_select_menu.visible = true;
	self._menu_sfx.play()

func _focus_change() -> void:
	var self_focusable: bool = !(self._level_select_menu.is_visible_in_tree() || \
		self._options_menu.is_visible_in_tree());
	self.main_focus_target.focus_behavior_recursive = Control.FOCUS_BEHAVIOR_INHERITED if self_focusable else Control.FOCUS_BEHAVIOR_DISABLED;
	if self_focusable:
		self.default_button.grab_focus.call_deferred();
@onready var _menu_sfx: AudioStreamPlayer = $"Menu sfx"

## Acts on the options button being pressed
func _on_options_button_pressed() -> void:
	self._options_menu.visible = true
	self._menu_sfx.play()
