class_name GameState
extends Node

enum State {DICE_SELECT, SHOOT_ZOMBIES, REPAIR_BARRICADE, FIX_VEHICLE, ZOMBIES_ATTACK, SELECT_REWARD, END_TURN}

signal next_state(from: GameState, to: State)

@export var state: State

var game_manager: GameManager


func enter() -> void:
	pass
	
func exit() -> void:
	pass
