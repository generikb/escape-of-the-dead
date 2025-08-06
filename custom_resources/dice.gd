class_name Dice
extends Resource

enum Dice_Type {ZOMBIE, BARRICADE, VEHICLE}

@export var sides : Array[DiceSide]
@export var dice_type : Dice_Type


func roll_dice() -> DiceSide:
	var num_sides : int = sides.size()
	var rolled_side = randi_range(0, num_sides-1)
	return sides[rolled_side]
