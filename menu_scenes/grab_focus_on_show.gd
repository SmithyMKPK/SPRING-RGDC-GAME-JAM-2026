extends Button

var last_shown: bool = false;

## cleanup will be using notifications instead
func _process(_delta: float) -> void:
	if self.last_shown != self.is_visible_in_tree():
		self.last_shown = self.is_visible_in_tree();
		if self.is_visible_in_tree():
			self.grab_focus();
