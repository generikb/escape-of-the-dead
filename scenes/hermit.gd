class_name Hermit
extends AnimatedSprite2D

var tween : Tween

func _ready() -> void:
	play("idle")
	Events.zombie_killed.connect(hermit_shoot_zombie)
	Events.barricade_repaired.connect(hermit_repair_barricade)
	Events.vehicle_repaired.connect(hermit_fix_vehicle)

func hermit_repair_barricade() -> void:
	tween = create_tween()
	var original_position = self.position
	tween.tween_property(self, "position", original_position + Vector2(40,0), .25)
	tween.tween_callback(self.play.bind("hammering"))
	tween.tween_interval(1.0)
	tween.tween_callback(self.play.bind("idle"))
	tween.tween_property(self, "position", original_position, .25)
	

func hermit_fix_vehicle() -> void:
	tween = create_tween()
	var original_position = self.position
	tween.tween_property(self, "flip_h", true, 0)
	tween.tween_property(self, "position", original_position + Vector2(-60,30), .25)
	tween.tween_callback(self.play.bind("wrenching"))
	tween.tween_interval(1.0)
	tween.tween_property(self, "flip_h", false, 0)
	tween.tween_callback(self.play.bind("idle"))
	tween.tween_property(self, "position", original_position, .25)
	

func hermit_shoot_zombie() -> void:
	play("shooting")
	await get_tree().create_timer(1.0).timeout
	play("idle")
