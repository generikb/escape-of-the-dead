class_name GameManager
extends Node2D

@onready var zombie_count_label: Label = %ZombieCount
@onready var dice_tray: HBoxContainer = %DiceTray
@onready var zombie_kills_label: Label = %ZombieKills
@onready var barricade_health_bar: ProgressBar = %BarricadeHealth
@onready var vehicle_health_bar: ProgressBar = %VehicleHealth

var zombie_count : int : set = set_zombie_count
var barricade_health : float : set = set_barricade_health
var vehicle_health : float : set = set_vehicle_health

var next_wave_zombies : int = 1
var zombie_kills : int = 0 : set = set_zombie_kills
var no_zombies_reward_redeemed : bool = false

func _ready() -> void:
	Events.start_turn.connect(start_turn)
	zombie_count = 1
	barricade_health = 100.0
	vehicle_health = 0.0
	Events.reward_redeemed.connect(update_zombie_count)

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


func start_turn() -> void:
	print("new turn")
	shoot_zombies()
	repair_barricace()
	fix_vehicle()
	zombies_attack()
	if not rewards_check():
		update_zombie_count()
	Events.end_turn.emit()

func shoot_zombies() -> void:
	for child : DiceUI in dice_tray.get_children():
		if child.dice.dice_type == Dice.Dice_Type.ZOMBIE:
			var shoot_success : DiceSide = child.roll_dice()
			if shoot_success.success:
				print("zombie shot!")
				if zombie_count > 0:
					zombie_kills += 1
				self.zombie_count = clampi(zombie_count-1, 0, zombie_count)



func repair_barricace() -> void:
	for child : DiceUI in dice_tray.get_children():
		if child.dice.dice_type == Dice.Dice_Type.BARRICADE:
			var shoot_success : DiceSide = child.roll_dice()
			if shoot_success.success:
				print("barricade repaired!")
				self.barricade_health = clampf(barricade_health + 10.0, barricade_health, 100.0)


func fix_vehicle() -> void:
	for child : DiceUI in dice_tray.get_children():
		if child.dice.dice_type == Dice.Dice_Type.VEHICLE:
			var shoot_success : DiceSide = child.roll_dice()
			if shoot_success.success:
				print("vehicle repaired!")
				self.vehicle_health = clampf(vehicle_health + 10.0, vehicle_health, 100.0)
				if vehicle_health >= 100.0:
					Events.game_over.emit(true)


func zombies_attack() -> void:
	for i in range(zombie_count):
		print("barricade attacked!")
		self.barricade_health = clampf(barricade_health - 10.0, 0.0, barricade_health)
		if barricade_health <= 0:
			Events.game_over.emit(false)


func update_zombie_count() -> void:
	if no_zombies_reward_redeemed == true:
		next_wave_zombies = 0
		no_zombies_reward_redeemed = false
	elif vehicle_health >= 90.0:
		next_wave_zombies = 4
	elif vehicle_health >= 70.0:
		next_wave_zombies = 3
	elif vehicle_health >= 40.0:
		next_wave_zombies = 2
	else:
		next_wave_zombies = 1
	self.zombie_count += next_wave_zombies


func rewards_check() -> bool:
	if zombie_kills >= 10:
		zombie_kills -= 10
		Events.reward_unlocked.emit()
		return true
	else:
		return false


func _on_destroy_zombies_button_pressed() -> void:
	self.zombie_count = 0
	Events.reward_redeemed.emit()


func _on_fix_vehicle_button_pressed() -> void:
	self.vehicle_health = clampf(vehicle_health + 10.0, vehicle_health, 100.0)
	Events.reward_redeemed.emit()


func _on_no_zombies_button_pressed() -> void:
	no_zombies_reward_redeemed = true
	Events.reward_redeemed.emit()


func _on_fix_barricade_button_pressed() -> void:
	self.barricade_health = clampf(barricade_health + 30.0, barricade_health, 100.0)
	Events.reward_redeemed.emit()
