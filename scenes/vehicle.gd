class_name Vehicle
extends Node2D

@onready var vehicle_part_1: Sprite2D = %VehiclePart1
@onready var vehicle_part_2: Sprite2D = %VehiclePart2
@onready var vehicle_part_3: Sprite2D = %VehiclePart3
@onready var vehicle_part_4: Sprite2D = %VehiclePart4
@onready var vehicle_part_5: Sprite2D = %VehiclePart5
@onready var vehicle_part_6: Sprite2D = %VehiclePart6
@onready var vehicle_part_7: Sprite2D = %VehiclePart7
@onready var vehicle_part_8: Sprite2D = %VehiclePart8
@onready var vehicle_part_9: Sprite2D = %VehiclePart9
@onready var vehicle_part_10: Sprite2D = %VehiclePart10
@onready var vehicle_parts : Array[Sprite2D] = [vehicle_part_1, vehicle_part_2, vehicle_part_3, vehicle_part_4, vehicle_part_5, vehicle_part_6, vehicle_part_7, vehicle_part_8, vehicle_part_9, vehicle_part_10]

var current_vehicle_health : int = 0
var tween : Tween

func _ready() -> void:
	for i in range(0, 10):
		vehicle_parts[i].visible = false


func repair_vehicle(new_vehicle_health : float) -> void:
	print(new_vehicle_health)
	print(int(new_vehicle_health) - current_vehicle_health)
	for i in range(current_vehicle_health/10, int(new_vehicle_health)/10):
		vehicle_parts[i].visible = true
		tween = create_tween()
		tween.tween_property(vehicle_parts[i], "rotation_degrees", 5, .10)
		tween.tween_property(vehicle_parts[i], "rotation_degrees", -5, .10)
		tween.tween_property(vehicle_parts[i], "rotation_degrees", 0, .10)
		tween.set_loops(3)
	current_vehicle_health = int(new_vehicle_health)
