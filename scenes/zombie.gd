class_name Zombie
extends TextureRect

var tween = Tween
@onready var blood_splatter: TextureRect = $BloodSplatter


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	blood_splatter.visible = false

func zombie_attack() -> void:
	tween = create_tween()
	var original_position = self.position
	print(original_position)
	tween.tween_property(self, "position", Vector2(- 50, original_position.y), 0.5)
	tween.tween_property(self, "position", original_position, 0.5)

func remove_zombie() -> void:
	print("zombie destroyed!")
	blood_splatter.visible = true
	tween = create_tween()
	tween.tween_property(self, "modulate:a", 0, 1.0)
	tween.tween_callback(self.queue_free)
