## A beacon that allows the player to see a given area under the correct circumstances
class_name LightNode extends Area2D

## Returns the distance between the node and the player
func get_player_distance(player_global_position: Vector2) -> float:
	return self.global_position.distance_squared_to(player_global_position)
