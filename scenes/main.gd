extends Node2D

@onready var game_manager: GameManager = $GameManager
@onready var audio_game_music: AudioStreamPlayer = $AudioGameMusic
@onready var audio_settings: PanelContainer = $AudioSettings
@onready var audio_icon: TextureRect = %AudioIcon
@onready var game_rules: PanelContainer = %GameRules


func _ready() -> void:
	audio_settings.visible = false
	game_rules.visible = true


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_try_again_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
	


func _on_audio_icon_mouse_entered() -> void:
	audio_icon.modulate = Color(0.871, 0.749, 0.537)

func _on_audio_icon_mouse_exited() -> void:
	audio_icon.modulate = Color.WHITE

func _on_audio_icon_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse"):
		audio_settings.visible = true
