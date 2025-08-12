extends GameState


func enter() -> void:
	print("End Turn Phase")
	game_manager.update_next_wave_zombies()
	game_manager.zombie_area.add_zombie(game_manager.game_stats.next_wave_zombies)
	game_manager.game_stats.zombie_count += game_manager.game_stats.next_wave_zombies
	
	next_state.emit.call_deferred(self, GameState.State.DICE_SELECT)
	
func exit() -> void:
	pass
