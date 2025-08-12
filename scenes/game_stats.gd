class_name GameStats
extends VBoxContainer

#@onready var zombie_count_label: Label = %ZombieCount
@onready var zombie_kills_label: Label = %ZombieKills
#@onready var barricade_health_bar: ProgressBar = %BarricadeHealth
@onready var vehicle_health_bar: ProgressBar = %VehicleHealth

var zombie_count : int
var barricade_health : float
var vehicle_health : float : set = set_vehicle_health
var next_wave_zombies : int
var zombie_kills : int = 0 : set = set_zombie_kills

func _ready() -> void:
	zombie_count = 1
	next_wave_zombies = 1
	barricade_health = 100.0
	vehicle_health = 0.0


func set_zombie_kills(value : int) -> void:
	zombie_kills = value
	zombie_kills_label.text = str(zombie_kills)

func set_vehicle_health(value: float) -> void:
	vehicle_health = value
	vehicle_health_bar.value = vehicle_health
