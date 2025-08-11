class_name GameStats
extends VBoxContainer

@onready var zombie_count_label: Label = %ZombieCount
@onready var zombie_kills_label: Label = %ZombieKills
@onready var barricade_health_bar: ProgressBar = %BarricadeHealth
@onready var vehicle_health_bar: ProgressBar = %VehicleHealth

var zombie_count : int : set = set_zombie_count
var barricade_health : float : set = set_barricade_health
var vehicle_health : float : set = set_vehicle_health

var next_wave_zombies : int = 1
var zombie_kills : int = 0 : set = set_zombie_kills

func _ready() -> void:
	Events.zombie_killed.connect(add_to_kill_count)
	zombie_count = 1
	barricade_health = 100.0
	vehicle_health = 0.0

func set_zombie_count(value : int) -> void:
	zombie_count = value
	zombie_count_label.text = str(zombie_count) + " (+" + str(next_wave_zombies) + " next wave)"

func set_zombie_kills(value : int) -> void:
	zombie_kills = value
	zombie_kills_label.text = str(zombie_kills)

func set_barricade_health(value : float) -> void:
	barricade_health = value
	barricade_health_bar.value = barricade_health

func set_vehicle_health(value: float) -> void:
	vehicle_health = value
	vehicle_health_bar.value = vehicle_health

func add_to_kill_count() -> void:
	self.zombie_count = clampi(-1, 0, zombie_count)
