class_name DiceTrayUI
extends CanvasLayer

@export var game_manager : GameManager

@onready var dice_sign: TextureRect = %DiceSign
@onready var dice_tray: HBoxContainer = %DiceTray
@onready var ready_button: Button = %ReadyButton
@onready var reset_button: Button = %ResetButton
@onready var shoot_zombie_button: Button = %ShootZombieButton
@onready var barricade_button: Button = %BarricadeButton
@onready var vehicle_button: Button = %VehicleButton

var tween : Tween


const DICE_UI = preload("res://scenes/dice_ui/dice_ui.tscn")
const SHOOT_DICE = preload("res://dice/test_dice/shoot_dice.tres")
const BARRICADE_DICE = preload("res://dice/test_dice/barricade_dice.tres")
const VEHICLE_DICE = preload("res://dice/test_dice/vehicle_dice.tres")

func _ready() -> void:
	ready_button.visible = false
	reset_button.visible = false

func show_hide_buttons() -> void:
	ready_button.visible = dice_tray.get_child_count() == 4
	reset_button.visible = dice_tray.get_child_count() > 0
	
	shoot_zombie_button.disabled = dice_tray.get_child_count() == 4
	barricade_button.disabled = dice_tray.get_child_count() == 4
	vehicle_button.disabled = dice_tray.get_child_count() == 4
		

func _on_shoot_zombie_button_pressed() -> void:
	var new_dice = DICE_UI.instantiate()
	new_dice.dice = SHOOT_DICE
	dice_tray.add_child(new_dice)
	game_manager.shoot_dice_this_turn += 1
	show_hide_buttons()


func _on_barricade_button_pressed() -> void:
	var new_dice = DICE_UI.instantiate()
	new_dice.dice = BARRICADE_DICE
	dice_tray.add_child(new_dice)
	game_manager.barricade_dice_this_turn += 1
	show_hide_buttons()


func _on_vehicle_button_pressed() -> void:
	var new_dice = DICE_UI.instantiate()
	new_dice.dice = VEHICLE_DICE
	dice_tray.add_child(new_dice)
	game_manager.vehicle_dice_this_turn += 1
	show_hide_buttons()


func _on_reset_button_pressed() -> void:
	clear_dice_tray()

func clear_dice_tray() -> void:
	if not dice_tray.is_node_ready():
		await dice_tray.ready
	for child in dice_tray.get_children():
		child.free()
	game_manager.shoot_dice_this_turn = 0
	game_manager.barricade_dice_this_turn = 0
	game_manager.vehicle_dice_this_turn = 0
	show_hide_buttons()


func hide_dice_tray() -> void:
	var tween = create_tween()
	tween.tween_property(dice_sign, "position", Vector2(0, 120), 2.0).as_relative().set_trans(tween.TRANS_ELASTIC)
	tween.tween_callback(Events.start_turn.emit)


func show_dice_tray() -> void:
	var tween = create_tween()
	tween.tween_property(dice_sign, "position", Vector2(0, -120), 2.0).as_relative().set_trans(tween.TRANS_ELASTIC)


func _on_ready_button_pressed() -> void:
	Events.dice_selected.emit()
