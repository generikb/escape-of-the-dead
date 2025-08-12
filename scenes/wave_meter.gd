class_name WaveMeter
extends TextureRect

@onready var wave_meter_arrow: TextureRect = %WaveMeterArrow

var tween : Tween

func _ready() -> void:
	pass


func adjust_meter(vehicle_health : float) -> void:
	var new_angle : float = (180.0 * vehicle_health / 100.0) - 90.0
	tween = create_tween()
	tween.tween_property(wave_meter_arrow, "rotation_degrees", new_angle, 2.0).set_trans(tween.TRANS_ELASTIC)
	
