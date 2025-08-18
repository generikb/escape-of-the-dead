class_name GameOverUI
extends CanvasLayer

@onready var win_lose_text: Label = %WinLoseText
@onready var audio_game_win: AudioStreamPlayer = $AudioGameWin
@onready var audio_game_lose_1: AudioStreamPlayer = $AudioGameLose1
@onready var audio_game_lose_2: AudioStreamPlayer = $AudioGameLose2


func _ready() -> void:
	Events.game_over.connect(win_lose)
	self.visible = false


func win_lose(did_i_win) -> void:
	get_tree().paused = true
	if did_i_win:
		win_lose_text.text = "You Win!"
		audio_game_win.play()
	else:
		win_lose_text.text = "You Lose!"
		audio_game_lose_1.play()
		audio_game_lose_2.play()
	self.visible = true
