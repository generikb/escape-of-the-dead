extends GameState


func _ready() -> void:
	#Events.reward_redeemed.connect(reward_redeemed)
	Events.reward_destroy_zombies.connect(reward_destroy_zombies)
	Events.reward_fix_barricade.connect(reward_fix_barricade)
	Events.reward_fix_vehicle.connect(reward_fix_vehicle)
	Events.reward_no_zombies.connect(reward_no_zombies)

func enter() -> void:
	print("Select Reward Phase")
	if game_manager.game_stats.zombie_kills >= 10:
		game_manager.game_stats.zombie_kills -= 10
		Events.reward_unlocked.emit()
	else:
		next_state.emit.call_deferred(self, GameState.State.END_TURN)
	
func exit() -> void:
	pass

func reward_destroy_zombies()-> void:
	# NEED TO ADD THIS FUNCTIONALITY
	next_state.emit(self, GameState.State.END_TURN)


func reward_fix_barricade()-> void:
	game_manager.game_stats.barricade_health = clampf(game_manager.game_stats.barricade_health + 30.0, game_manager.game_stats.barricade_health, 100.0)
	next_state.emit(self, GameState.State.END_TURN)


func reward_fix_vehicle()-> void:
	game_manager.game_stats.vehicle_health = clampf(game_manager.game_stats.vehicle_health + 10.0, game_manager.game_stats.vehicle_health, 100.0)
	if game_manager.game_stats.vehicle_health >= 100.0:
		Events.game_over.emit(true)
	next_state.emit(self, GameState.State.END_TURN)

func reward_no_zombies()-> void:
	game_manager.no_zombies_reward_redeemed = true
	next_state.emit(self, GameState.State.END_TURN)
