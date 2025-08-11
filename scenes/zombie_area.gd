class_name ZombieArea
extends FlowContainer

const ZOMBIE = preload("res://scenes/zombie.tscn")

var children : Array[Node]

func _ready() -> void:
	Events.zombie_killed.connect(remove_zombie)
	children = get_children()
	


func add_zombie(amount: int) -> void:
	for i in range(amount):
		var zombie = ZOMBIE.instantiate()
		self.add_child(zombie)
		children = get_children()
		

func remove_zombie() -> void:
	if children:
		var targeted_zombie = children.pop_back()
		targeted_zombie.remove_zombie()
		
