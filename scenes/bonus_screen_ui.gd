class_name BonusScreenUI
extends CanvasLayer

func _ready() -> void:
	self.visible = false
	Events.reward_unlocked.connect(show_bonus_screen)
	Events.reward_redeemed.connect(hide_bonus_screen)

func show_bonus_screen() -> void:
	self.visible = true


func hide_bonus_screen() -> void:
	self.visible = false
