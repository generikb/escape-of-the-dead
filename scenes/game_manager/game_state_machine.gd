class_name GameStateMachine
extends Node

@export var initial_state: GameState

var current_state : GameState
var states := {}


func init(game_manager: GameManager) -> void:
	for child in get_children():
		if child is GameState:
			states[child.state] = child
			child.next_state.connect(next_state)
			child.game_manager = game_manager
	
	if initial_state:
		initial_state.enter()
		current_state = initial_state
			

func next_state(from: GameState, to: GameState.State) -> void:
	if from != current_state:
		return
	
	var new_state: GameState = states[to]
	if not new_state:
		return
	
	if current_state:
		current_state.exit()
	
	new_state.enter()
	current_state = new_state
