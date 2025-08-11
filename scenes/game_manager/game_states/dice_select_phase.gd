extends GameState


func _ready() -> void:
	Events.dice_selected.connect(enter_shoot_zombies_phase)

func enter() -> void:
	print("Dice Select Phase")
	if not game_manager.dice_tray_ui.is_node_ready():
		await game_manager.dice_tray_ui.ready
		
	game_manager.dice_tray_ui.clear_dice_tray()
	game_manager.dice_tray_ui.show_dice_tray()
	
func exit() -> void:
	game_manager.dice_tray_ui.hide_dice_tray()


func enter_shoot_zombies_phase() -> void:
	next_state.emit(self, GameState.State.SHOOT_ZOMBIES)
