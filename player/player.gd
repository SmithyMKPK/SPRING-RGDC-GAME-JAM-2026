## The player-in every form (I guess)
extends Node2D

## A reference to a movable character object
@onready var _movable_character: PlayerMovement = $"Moveable Character"

@onready var _background_music_player: AudioStreamPlayer = $"Background Music"

@export var _background_music: Dictionary

var in_level: bool:
	set(value):
		if value:
			self._background_music_player.stream = self._background_music["Level Theme"]
		else:
			self._background_music_player.stream = self._background_music["Main Menu Theme"]
		self._background_music_player.play()

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
	self.in_level = false

## Adds the moveable character to the scene tree
func enter_level(spawnpoint: Node2D) -> void:
	self.add_child(self._movable_character)
	self._movable_character.set_initial_position(spawnpoint.global_position)
	self.z_index = spawnpoint.z_index;
	self.in_level = true
	#self._movable_character.collision_layer = 1;

## Removes the movable character to the scene tree
func exit_level() -> void:
	#self._movable_character.collision_layer = 0;
	self.remove_child(_movable_character)

func get_death_signal() -> Signal:
	return self._movable_character.start_respawn;

func get_respawn_signal() -> Signal:
	return self._movable_character.respawn;
