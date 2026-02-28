## A test level to see whether distance can properly distance (or something idk)
class_name Level extends Node2D

var _light_nodes: Array[LightNode]

var _closest_light_node: LightNode

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child: Node in self.get_children():
		if child is LightNode:
			self._light_nodes.append(child)


func _process(_delta: float) -> void:
	var light_node_distances: Dictionary
	
	for light_node: LightNode in self._light_nodes:
		var light_node_distance: float = PlayerCharacter.global_position.distance_squared_to(light_node.position)
		light_node_distances[light_node] = light_node_distance
	
	self._closest_light_node = get_closest_light_node(light_node_distances)
	$"Closes Light Node Label".text = "Closest Light Node: %s" % [self._closest_light_node.name]

## Returns the light node that's closest to the player
func get_closest_light_node(light_node_distances: Dictionary) -> LightNode:
	var closest_light_node: LightNode = null
	
	for light_node: LightNode in light_node_distances.keys():
		if !closest_light_node:
			closest_light_node = light_node
		elif light_node_distances[closest_light_node] > light_node_distances[light_node]:
			closest_light_node = light_node
	
	return closest_light_node
