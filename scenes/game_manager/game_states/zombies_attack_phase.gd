extends GameState


func enter() -> void:
	print("Zombie Attack Phase")
	for i in range(game_manager.game_stats.zombie_count):
		print("barricade attacked!")
		Events.zombie_attack.emit(i)
		game_manager.game_stats.barricade_health = clampf(game_manager.game_stats.barricade_health - 10.0, 0.0, game_manager.game_stats.barricade_health)
		if game_manager.game_stats.barricade_health <= 0:
			Events.game_over.emit(false)
		await get_tree().create_timer(1.0).timeout
	
	if not get_tree().paused:
		next_state.emit.call_deferred(self, GameState.State.SELECT_REWARD)
	
func exit() -> void:
	pass
