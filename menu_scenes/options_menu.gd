extends Control

## A reference to the volume bar
@export var _volume_bar: HSlider

## Sets the initial value of the volume bar to be that of the current music volume
func _ready() -> void:
	self._volume_bar.value = Player.current_music_volume

## Acts on the back button being pressed
func _on_back_button_pressed() -> void:
	self.visible = false

## Acts on the value of the volume changed slider being changed
func _on_h_slider_value_changed(value: float) -> void:
	Player.current_music_volume = value
