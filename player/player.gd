## The player-in every form (I guess)
extends Node2D

## A reference to a movable character object
@onready var _movable_character: PlayerMovement = $"Moveable Character"

## The position that a player is at in any given moment
var current_position: Vector2:
	get:
		return self._movable_character.position

## Not all the time does the player gotta be in the scene, so we have this
func _ready() -> void:
	self.remove_child(self._movable_character)

## Adds the moveable character to the scene tree
func enter_level(initial_position: Vector2) -> void:
	self.add_child(self._movable_character)
	self._movable_character.position = initial_position

func exit_level() -> void:
	self.remove_child(_movable_character)
