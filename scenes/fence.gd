class_name Fence
extends VBoxContainer

const FENCE_SECTION = preload("res://scenes/fence_section.tscn")

var children : Array[Node]
var tween : Tween

func _ready() -> void:
	Events.zombie_attack.connect(remove_fence)
	Events.barricade_repaired.connect(add_fence.bind(1))
	Events.reward_fix_barricade.connect(add_fence.bind(3))
	children = get_children()


func add_fence(amount : int) -> void:
	var fence_gap : int = 10 - children.size()
	if amount > fence_gap:
		amount = fence_gap
	for i in range(amount):
		var fence_section = FENCE_SECTION.instantiate()
		fence_section.flip_h = randi_range(0, 1)
		fence_section.flip_v = randi_range(0, 1)
		fence_section.modulate.a = 0
		self.add_child(fence_section)
		move_child(fence_section, 0)
		tween = create_tween()
		tween.tween_property(fence_section, "modulate:a", 1, 1.0)
		children = get_children()


func remove_fence(_zombie : int) -> void:
	if children:
		var fence_section = children.pop_front()
		fence_section.remove_fence_section()
