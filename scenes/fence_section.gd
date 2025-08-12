class_name FenceSection
extends TextureRect

var tween = Tween

func remove_fence_section() -> void:
	tween = create_tween()
	tween.tween_property(self, "modulate:a", 0, 1.0)
	tween.tween_callback(self.queue_free)
