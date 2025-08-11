extends GameState


func enter() -> void:
	print("End Turn Phase")
	var next_wave_zombies = game_manager.game_stats.next_wave_zombies
	var vehicle_health = game_manager.game_stats.vehicle_health
	if game_manager.no_zombies_reward_redeemed == true:
		next_wave_zombies = 0
		game_manager.no_zombies_reward_redeemed = false
	elif vehicle_health >= 90.0:
		next_wave_zombies = 4
	elif vehicle_health >= 70.0:
		next_wave_zombies = 3
	elif vehicle_health >= 40.0:
		next_wave_zombies = 2
	else:
		next_wave_zombies = 1
	game_manager.zombie_area.add_zombie(next_wave_zombies)
	game_manager.game_stats.zombie_count += next_wave_zombies
	
	next_state.emit.call_deferred(self, GameState.State.DICE_SELECT)
	
func exit() -> void:
	pass
