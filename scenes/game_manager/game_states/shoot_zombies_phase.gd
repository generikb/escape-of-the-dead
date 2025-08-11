extends GameState

const GAME_DICE = preload("res://scenes/game_dice/game_dice.tscn")
const SHOOT_DICE = preload("res://dice/test_dice/shoot_dice.tres")


func enter() -> void:
	print("Shoot Zombie Phase")
	if game_manager.shoot_dice_this_turn > 0:
		for i in range(game_manager.shoot_dice_this_turn):
			var shootdice = GAME_DICE.instantiate()
			shootdice.dice = SHOOT_DICE
			add_child(shootdice)
			shootdice.roll_dice()
		
		await get_tree().create_timer(5.0).timeout
		game_manager.clear_game_dice()
		
	next_state.emit.call_deferred(self, GameState.State.REPAIR_BARRICADE)
	
func exit() -> void:
	pass
