class_name GameOverUI
extends CanvasLayer

@onready var win_lose_text: Label = %WinLoseText


func _ready() -> void:
	Events.game_over.connect(win_lose)
	self.visible = false


func win_lose(did_i_win) -> void:
	get_tree().paused = true
	if did_i_win:
		win_lose_text.text = "You Win!"
	else:
		win_lose_text.text = "You Lose!"
	self.visible = true
