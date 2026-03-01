## A test level to see whether distance can properly distance (or something idk)
class_name Level extends Node2D

## A reference to the camera that'll be following the player
@onready var following_camera: FollowCamera = $"Level Camera"

@onready var end_point: EndPoint = $EndPoint

@onready var spawn_point: Node2D = $"Spawn Point"

@onready var level_finished_menu: CanvasLayer = $LevelFinishedMenu

## References to each light node in a given level
var _light_nodes: Array[LightNode]

## Set property that allows the camera's target to be known each frame
var _closest_light_node: LightNode:
	set(value):
		following_camera.target_light_node = value

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child: Node in self.get_children():
		if child is LightNode:
			self._light_nodes.append(child)
	
	self.end_point.finished_level.connect(Callable(self, "_on_level_finished"))

func _process(_delta: float) -> void:
	var light_node_distances: Dictionary
	
	for light_node: LightNode in self._light_nodes:
		var light_node_distance: float = Player.current_position.distance_squared_to(light_node.position)
		light_node_distances[light_node] = light_node_distance
	
	self._closest_light_node = get_closest_light_node(light_node_distances)

## Acts on the end point's level finished signal
func _on_level_finished() -> void:
	Player.exit_level()
	level_finished_menu.visible = true

## Returns the light node that's closest to the player
func get_closest_light_node(light_node_distances: Dictionary) -> LightNode:
	var closest_light_node: LightNode = null
	
	for light_node: LightNode in light_node_distances.keys():
		if !closest_light_node:
			closest_light_node = light_node
		elif light_node_distances[closest_light_node] > light_node_distances[light_node]:
			closest_light_node = light_node
	
	return closest_light_node
