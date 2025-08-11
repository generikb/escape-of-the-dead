class_name Zombie
extends TextureRect

var tween = Tween
@onready var blood_splatter: TextureRect = $BloodSplatter


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	blood_splatter.visible = false



func remove_zombie() -> void:
	print("zombie destroyed!")
	blood_splatter.visible = true
	tween = create_tween()
	tween.tween_property(self, "modulate:a", 0, 1.0)
	tween.tween_callback(self.queue_free)
