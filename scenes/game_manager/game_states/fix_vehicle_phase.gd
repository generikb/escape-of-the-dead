extends GameState

const GAME_DICE = preload("res://scenes/game_dice/game_dice.tscn")
const VEHICLE_DICE = preload("res://dice/test_dice/vehicle_dice.tres")


func enter() -> void:
	print("Fix Vehicle Phase")
	for i in range(game_manager.vehicle_dice_this_turn):
		var shootdice = GAME_DICE.instantiate()
		shootdice.dice = VEHICLE_DICE
		add_child(shootdice)
		shootdice.roll_dice()
	
	if game_manager.vehicle_dice_this_turn > 0:
		await get_tree().create_timer(5.0).timeout
		game_manager.clear_game_dice()
	next_state.emit.call_deferred(self, GameState.State.ZOMBIES_ATTACK)
	
func exit() -> void:
	pass
