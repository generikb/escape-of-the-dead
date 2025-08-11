class_name GameManager
extends Node2D

@onready var dice_tray_ui: DiceTrayUI = %DiceTrayUI
@onready var zombie_area: ZombieArea = %ZombieArea
@onready var game_stats: VBoxContainer = %GameStats
@onready var game_state_machine: GameStateMachine = $GameStateMachine


var shoot_dice_this_turn : int = 0
var barricade_dice_this_turn : int = 0
var vehicle_dice_this_turn : int = 0

var no_zombies_reward_redeemed : bool = false

var tween : Tween


func _ready() -> void:
	Events.zombie_killed.connect(zombie_killed)
	Events.barricade_repaired.connect(repair_barricade)
	Events.vehicle_repaired.connect(fix_vehicle)
	game_state_machine.init(self)
	zombie_area.add_zombie(1)


func zombie_killed() -> void:
	if zombie_area.children:
		game_stats.zombie_kills += 1

func repair_barricade() -> void:
	print("barricade repaired!")
	game_stats.barricade_health = clampf(game_stats.barricade_health + 10.0, game_stats.barricade_health, 100.0)


func fix_vehicle() -> void:
	print("vehicle repaired!")
	game_stats.vehicle_health = clampf(game_stats.vehicle_health + 10.0, game_stats.vehicle_health, 100.0)
	if game_stats.vehicle_health >= 100.0:
		Events.game_over.emit(true)


func clear_game_dice() -> void:
	for gamedice in get_tree().get_nodes_in_group("gamedice"):
		tween = create_tween()
		tween.tween_property(gamedice, "modulate:a", 0, 1.0)
		tween.tween_callback(gamedice.queue_free)
