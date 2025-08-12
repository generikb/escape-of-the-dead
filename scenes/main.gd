extends Node2D

@onready var game_manager: GameManager = $GameManager

func _ready() -> void:
	pass


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_try_again_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
	
