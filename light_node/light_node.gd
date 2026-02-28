## A beacon that allows the player to see a given area under the correct circumstances
class_name LightNode extends Area2D

## A reference to the CollisionShape2D that represents the area that lights up
@export var circle_aoe: CollisionShape2D

## The desired radius for a light node to have (in pixels)
var _aoe_radius: float

## The desired height for a light node to have (in pixels)
var _aoe_height: float

## Radius setting for when a light node is instantiated prior to a scene starting
var aoe_radius: float:
	set(value):
		self._aoe_radius = value

## Radius setting for when a light node is instantiated prior to a scene starting
var aoe_height: float:
	set(value):
		self._aoe_height = value

func _ready() -> void:
	## These are made IF we choose to have something where these are instantiated during a scene
	#var node_aoe: CapsuleShape2D = CapsuleShape2D.new()
	#node_aoe.radius = self._aoe_radius
	#node_aoe.height = self._aoe_height
	#
	#self.circle_aoe.shape = node_aoe
	pass

## Returns the distance between the node and the player
func get_player_distance(player_global_position: Vector2) -> float:
	return self.global_position.distance_squared_to(player_global_position)
