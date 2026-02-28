## The player-in every form (I guess)
extends Node2D

## A reference to a movable character object
@onready var _movable_character: PlayerMovement = $"Moveable Character"

@onready var _background_music_player: AudioStreamPlayer = $"Background Music"

## The position that a player is at in any given moment
var current_position: Vector2:
	get:
		return self._movable_character.position

## The current volume background music is set to
var current_music_volume: float:
	get:
		return self._background_music_player.volume_linear
	set(value):
		self._background_music_player.volume_linear = value

## Not all the time does the player gotta be in the scene, so we have this
func _ready() -> void:
	self.remove_child(self._movable_character)

## Adds the moveable character to the scene tree
func enter_level(spawnpoint: Node2D) -> void:
	self.add_child(self._movable_character)
	self._movable_character.global_position = spawnpoint.global_position;
	self.z_index = spawnpoint.z_index;

## Removes the movable character to the scene tree
func exit_level() -> void:
	self.remove_child(_movable_character)
