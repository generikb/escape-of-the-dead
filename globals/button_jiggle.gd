extends Button

var button_jiggle_intensity : float = 1.04
var button_jiggle_duration : float = 0.4
var tween : Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_entered.connect(_button_enter)
	mouse_exited.connect(_button_exit)
	self.pivot_offset = self.size / 2

func _button_enter() -> void:
	if is_instance_valid(tween) and tween.is_valid():
		tween.kill()
	tween = create_tween()
	tween.tween_property(self, "scale", Vector2.ONE * button_jiggle_intensity, button_jiggle_duration)
	tween.tween_property(self, "scale", Vector2.ONE, button_jiggle_duration)
	tween.set_loops(10)

func _button_exit() -> void:
	if is_instance_valid(tween) and tween.is_valid():
		tween.kill()
	tween = create_tween()
	tween.tween_property(self, "scale", Vector2.ONE, button_jiggle_duration)
