extends Node
@warning_ignore_start("UNUSED_SIGNAL")
signal start_turn
signal end_turn

signal dice_selected

signal reward_unlocked
signal reward_redeemed

signal reward_destroy_zombies
signal reward_fix_vehicle
signal reward_no_zombies
signal reward_fix_barricade

signal zombie_attack
signal zombie_attacks_complete

signal zombie_killed
signal barricade_repaired
signal vehicle_repaired

signal game_over(win : bool)
