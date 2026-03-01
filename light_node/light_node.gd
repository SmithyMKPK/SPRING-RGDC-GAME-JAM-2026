## A beacon that allows the player to see a given area under the correct circumstances
class_name LightNode extends Area2D

func _ready() -> void:
	$Sprite2D.animation_finished.connect(self._on_anim_done);
	self.exit();

## Returns the distance between the node and the player
func get_player_distance(player_global_position: Vector2) -> float:
	return self.global_position.distance_squared_to(player_global_position)

func _on_anim_done():
	if $Sprite2D.animation == "light":
		$Sprite2D.animation = "hold_light";

func enter() -> void:
	$Sprite2D.play("light");

func exit() -> void:
	$Sprite2D.animation = "default";
