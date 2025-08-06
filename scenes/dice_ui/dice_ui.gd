class_name DiceUI
extends Control

@export var dice : Dice

@onready var icon: TextureRect = $Icon


func _ready() -> void:
	icon.texture = dice.sides[0].icon


func roll_dice() -> DiceSide:
	var new_side = dice.roll_dice()
	icon.texture = new_side.icon
	return new_side


#func _on_icon_gui_input(event: InputEvent) -> void:
	#if event.is_action_pressed("left_mouse"):
		#roll_dice()
