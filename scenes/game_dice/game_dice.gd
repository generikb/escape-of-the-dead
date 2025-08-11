class_name GameDice
extends RigidBody2D

@export var dice : Dice

@onready var icon: Sprite2D = $Icon
@onready var rolling_animation: AnimatedSprite2D = $RollingAnimation



var speed : float = 150.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	icon.texture = dice.sides[0].icon

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(linear_velocity * delta)
	if collision:
		linear_velocity = linear_velocity.bounce(collision.get_normal())


func roll_dice() -> void:
	icon.visible = false
	rolling_animation.visible = true
	linear_velocity = Vector2(-200, -200).normalized() * speed
	await get_tree().create_timer(3.0).timeout
	linear_velocity = Vector2.ZERO
	
	var new_side = dice.roll_dice()
	icon.texture = new_side.icon
	
	rolling_animation.visible = false
	icon.visible = true
	
	if new_side.success:
		match dice.dice_type:
			Dice.Dice_Type.ZOMBIE:
				Events.zombie_killed.emit()
			Dice.Dice_Type.BARRICADE:
				Events.barricade_repaired.emit()
			Dice.Dice_Type.VEHICLE:
				Events.vehicle_repaired.emit()
