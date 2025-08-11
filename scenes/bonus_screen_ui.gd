class_name BonusScreenUI
extends CanvasLayer

func _ready() -> void:
	self.visible = false
	Events.reward_unlocked.connect(show_bonus_screen)
	#Events.reward_redeemed.connect(hide_bonus_screen)

func show_bonus_screen() -> void:
	self.visible = true


func hide_bonus_screen() -> void:
	self.visible = false


func _on_destroy_zombies_button_pressed() -> void:
	Events.reward_destroy_zombies.emit()
	hide_bonus_screen()


func _on_fix_vehicle_button_pressed() -> void:
	Events.reward_fix_vehicle.emit()
	hide_bonus_screen()


func _on_no_zombies_button_pressed() -> void:
	Events.reward_no_zombies.emit()
	hide_bonus_screen()


func _on_fix_barricade_button_pressed() -> void:
	Events.reward_fix_barricade.emit()
	hide_bonus_screen()
